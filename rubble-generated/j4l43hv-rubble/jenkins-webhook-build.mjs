// Jenkins webhook observation uses structured JSON; it never schedules work.
import { readFileSync } from 'node:fs';

const [operation, file, referenceUrl, expectedCommit] = process.argv.slice(2);
const data = JSON.parse(readFileSync(file, 'utf8'));
function fail(message) { throw new Error(message); }
function assignment(name, value) {
  console.log(`${name}='${String(value).replaceAll("'", "'\\''")}'`);
}
function repositoryKey(value) {
  const scp = /^git@([^:]+):(.+)$/.exec(value);
  const url = new URL(scp ? `ssh://git@${scp[1]}/${scp[2]}` : value);
  return `${url.hostname.toLowerCase()}${url.pathname.replace(/\/$/, '').replace(/\.git$/, '')}`;
}

switch (operation) {
  case 'parent':
    if (data._class !== 'org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject') {
      fail('pipeline.name must identify an existing Jenkins Multibranch Pipeline');
    }
    break;
  case 'discover': {
    const builds = data.builds ?? [];
    for (const build of builds) {
      if (!Number.isSafeInteger(build.number) || build.number < 1) fail('Invalid Jenkins build number');
    }
    // Each generated runs/<UUID> branch is published once. Observe its first run,
    // even if someone subsequently rebuilds that branch through the Jenkins UI.
    assignment('build_number', builds.length ? Math.min(...builds.map(build => build.number)) : '');
    // Queue.Item.url is relative to the controller context, unlike the trigger
    // API's Location header. Preserve contexts such as https://host/jenkins/.
    const queueReference = data.queueItem?.url;
    assignment('queue_url', queueReference ? new URL(queueReference, `${referenceUrl.replace(/\/+$/, '')}/`).href : '');
    break;
  }
  case 'revision': {
    const matches = (data.actions ?? []).some(action =>
      action.lastBuiltRevision?.SHA1 === expectedCommit &&
      (action.remoteUrls ?? []).some(remote => repositoryKey(remote) === repositoryKey(referenceUrl)));
    if (!matches) fail(`Jenkins build did not check out the published repository at commit ${expectedCommit}`);
    break;
  }
  default: fail(`Unknown webhook observation operation: ${operation}`);
}
