# Shaka Team Triage Party - Dockerfile

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# TODO: Restore upstream image if these PRs ever land
#ARG BASE_IMAGE=triageparty/triage-party:latest

# This forked version gets us the ability to:
#  - scope collections to repos while still reusing rules across collections
#    - https://github.com/google/triage-party/pull/286
#  - categorize collections for hierarchical views
#    - Not yet sent, depends on scope PR
# Built from https://github.com/joeyparrish/triage-party/tree/project-hierarchy
ARG BASE_IMAGE=joeyparrish/triage-party:project-hierarchy

FROM ${BASE_IMAGE} AS original

# The base image doesn't have basic distro-type things like /bin/bash.
# To extract and modify parts of the original image, use this busybox image.
FROM busybox:latest AS mods
WORKDIR /

# Run a sed script to patch base.tmpl.
COPY --from=original /app/site/base.tmpl .
COPY patches/base.tmpl.sed .
COPY patches/navbar-brand.html .
RUN sed -f base.tmpl.sed -i base.tmpl

# Run a sed script to patch collection.tmpl.
COPY --from=original /app/site/collection.tmpl .
COPY patches/collection.tmpl.sed .
RUN sed -f collection.tmpl.sed -i collection.tmpl

# Now build our image based on the original, plus patches, some of which were
# derived from originals above.
FROM ${BASE_IMAGE}
WORKDIR /app
COPY patches/custom.css /app/site/static/css/custom.css
COPY patches/shaka-logo.png /app/site/static/img/shaka-logo.png
COPY patches/extra-collection.js /app/site/static/extra-collection.js
COPY shaka-triage-party-config.yaml /app/config/config.yaml
COPY --from=mods /collection.tmpl /app/site/collection.tmpl
COPY --from=mods /base.tmpl /app/site/base.tmpl
