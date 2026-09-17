# Jenkins builder generated pipelines

This repository holds Rubble-generated Jenkins pipelines and their user hooks.
It is a pipeline code repository, not a software module.

`main` retains the shared scripts under `.rubble/`. Each Rubble publication creates
a one-use `runs/<UUID>` branch containing `rubble-generated/Jenkinsfile`, the job
payloads, and the current hooks. GitHub's push webhook starts the matching branch
in the fixed [Jenkins Multibranch Pipeline](https://jenkins-x86_64-linux.rubble.build/job/jenkins-builder-generated-pipelines/).
Generated branches and Jenkins build history are retained for inspection.

Configure the local Rubble Jenkins builder with this repository root as
`build-dir`, `pipeline.mode: webhook`, and
`pipeline.name: jenkins-builder-generated-pipelines`. The execution environment
provides Rubble configuration and credentials (`authentication.source: environment`).
Platform mappings, runtime bundle URLs, remote-store configuration and Jenkins
API credentials belong in the operator's local Rubble configuration.

Run `rubble build --builder jenkins /path/to/brick.yaml` from your development
workspace. The publisher preserves the caller's branch and index. With `wait: true`
it observes the exact published branch and checkout commit before reporting success;
`wait: false` returns after Git push without contacting the Jenkins API.

Customize `.rubble/hooks/`, `.rubble/publish.sh` and `.rubble/release.sh` as needed.
Generation preserves these files. The Jenkins release script contains comments
where users can implement artifact publication; it does not create GitHub releases.
Do not place credentials in this repository or edit disposable generated payloads.
