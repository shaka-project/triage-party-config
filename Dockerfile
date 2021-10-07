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

FROM triageparty/triage-party:latest AS original

# The base image doesn't have basic distro-type things like /bin/bash.
# To extract and modify parts of the original image, use this busybox image.
FROM busybox:latest AS mods
WORKDIR /
COPY --from=original /app/site/collection.tmpl .
# Insert additional JavaScript into the collection view template.
# This JavaScript is specific to the collection view.
# This sed command looks for the line that defines JS in the template, then
# inserts our script tag right after that.
RUN sed \
    -e '/{{ define "js" }}/a <script src="/static/extra-collection.js"></script>' \
    -i collection.tmpl

# Now build our image based on the original, plus patches, some of which were
# derived from originals above.
FROM triageparty/triage-party:latest
WORKDIR /app
COPY custom.css /app/site/static/css/custom.css
COPY shaka-triage-party-config.yaml /app/config/config.yaml
COPY extra-collection.js /app/site/static/extra-collection.js
COPY --from=mods /collection.tmpl /app/site/collection.tmpl
