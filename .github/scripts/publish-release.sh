#!/usr/bin/env bash
set -euo pipefail

tag="v${VERSION}"
commit="$(git rev-parse HEAD)"
notes=".github/release-notes/${VERSION}.md"
test -s "$notes"

# Never move an existing tag or replace an already published release.
git fetch --tags origin
if git rev-parse --verify "refs/tags/${tag}" >/dev/null 2>&1; then
  if [[ "$(git rev-parse "refs/tags/${tag}^{commit}")" != "$commit" ]]; then
    echo "Tag ${tag} points to a different commit" >&2
    exit 1
  fi
fi

if gh release view "$tag" --json isDraft,targetCommitish > release.json; then
  python3 - "$commit" <<'PY'
import json
import sys

release = json.load(open('release.json'))
if not release['isDraft']:
    raise SystemExit('Release is already published; its assets will not be replaced')
if release['targetCommitish'] != sys.argv[1]:
    raise SystemExit('Existing draft targets a different commit')
PY
else
  gh release create "$tag" --draft --target "$commit" \
    --title "$VERSION" --notes-file "$notes"
fi

# A failed upload leaves a draft that can be safely retried for this commit.
gh release upload "$tag" dist/* --clobber
gh release edit "$tag" --draft=false
