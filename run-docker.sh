#!/bin/bash

# Shaka Team Triage Party - Local Docker Launch Script

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if [[ "$GITHUB_TOKEN" == "" ]]; then
  echo "Please set GITHUB_TOKEN first." 1>&2
  exit 1
fi

if [[ "$PORT" == "" ]]; then
  export PORT=8888
  echo "Using default PORT of $PORT." 1>&2
fi

set -ex

DIR=$(realpath $(dirname "$0"))
PROJECT=shaka-player-demo
IMAGE=gcr.io/shaka-player-demo/triage-party-config/triage-party

docker build -t "${IMAGE}" .

docker run \
  --rm \
  -e GITHUB_TOKEN \
  -e PORT \
  -p "${PORT}:${PORT}" \
  "${IMAGE}"
