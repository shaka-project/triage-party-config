/* Shaka Team Triage Party - Extra JS for Collection View
 *
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// This is loaded on collection views in Triage Party.  We can inject custom JS
// here.
(() => {
  const onLoaded = () => {
    // Sort all collections by least recent update.
    // These have been waiting for attention the longest.
    // NOTE: We initially used least recent response, but the metadata for that
    // doesn't seem to match what you would expect.
    document.querySelectorAll('.hd.col-update.sorting').forEach(x => x.click());
  };

  // Wait for the page to finish loading before executing the code above.
  if (document.readyState == 'complete') {
    onLoaded();
  } else {
    window.addEventListener('load', onLoaded);
  }
})();
