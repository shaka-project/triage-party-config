# Shaka Project Triage Party Config - Agent Guide

This repo contains the configuration and UI customization for the Shaka Team's
instance of [Triage Party](https://github.com/google/triage-party), a tool for
triaging GitHub issues across multiple repos. It is deployed as a Docker
container on Google Cloud Run via Cloud Build.


## Attribution

Read [AGENT-ATTRIBUTION.md](AGENT-ATTRIBUTION.md) for attribution details.


## Directory Overview

| Path | Purpose |
|------|---------|
| `shaka-triage-party-config.yaml` | Main Triage Party config: repos, rules, and collections |
| `Dockerfile` | Builds the custom image from the base image, applying patches |
| `google-cloud-build.yaml` | CI/CD: builds, pushes to GCR, and deploys to Cloud Run on merge |
| `run-docker.sh` | Runs the image locally for manual testing |
| `patches/` | UI customizations: sed scripts that patch upstream templates, plus CSS, JS, and image assets |


## How to Test Locally

There is no automated test suite or linter. The only way to validate changes is
to build and run the Docker image locally:

```sh
GITHUB_TOKEN=<your_token> ./run-docker.sh
```

Then open `http://localhost:8888` in a browser. The default port is 8888; set
`PORT` to override it.

The script requires a `GITHUB_TOKEN` with read access to the Shaka Project
GitHub org. Without it, the script will exit immediately with an error.


## Gotchas

**The base image is a fork, not upstream.** The `Dockerfile` uses
`joeyparrish/triage-party:project-hierarchy`, a fork that adds features not
yet merged upstream (repo-scoped collections, hierarchical category views).
Do not switch it to `triageparty/triage-party:latest`.

**UI patches use sed scripts, not direct template edits.** The `patches/`
directory contains `.sed` scripts that are applied to templates copied out of
the base image at Docker build time. To change a template, edit the
corresponding `.sed` file - do not add raw template files to this repo, as they
would be stale copies that ignore upstream changes.
