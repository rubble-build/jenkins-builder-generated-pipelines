import { readFileSync, writeSync } from 'node:fs';

try {
  const [, , path, keyParameter] = process.argv;
  const job = JSON.parse(readFileSync(path, 'utf8'));
  const definitions = (job.property ?? []).flatMap(property => property.parameterDefinitions ?? []);
  if (keyParameter && !definitions.some(parameter => parameter.name === keyParameter)) {
    throw new Error(`Jenkins job must declare parameter '${keyParameter}' to receive the authentication key; configure the job before retrying`);
  }
  writeSync(1, definitions.length ? 'true\n' : 'false\n');
} catch (error) {
  writeSync(2, `[jenkins-publish] ${error.message}\n`);
  process.exitCode = 1;
}
