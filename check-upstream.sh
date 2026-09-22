#!/usr/bin/env bash
# check-upstream.sh — report how far this fork is behind mattpocock/skills.
#
# Usage:
#   ./check-upstream.sh          # show ahead/behind counts + new upstream commits
#   ./check-upstream.sh --sync   # fetch + merge upstream/main into current branch
#
# The fork tracks upstream at the 'upstream' remote. Nothing is pushed for you;
# review, then `git push` when you're happy.

set -euo pipefail
cd "$(dirname "$0")"

UPSTREAM_BRANCH="upstream/main"

if ! git remote | grep -qx upstream; then
  echo "No 'upstream' remote found. Add it with:"
  echo "  git remote add upstream https://github.com/mattpocock/skills.git"
  exit 1
fi

echo "Fetching upstream…"
git fetch --quiet upstream --tags

CURRENT="$(git rev-parse --abbrev-ref HEAD)"
read -r BEHIND AHEAD < <(git rev-list --left-right --count "HEAD...${UPSTREAM_BRANCH}")

echo
echo "Branch '${CURRENT}' vs ${UPSTREAM_BRANCH}:"
echo "  ${AHEAD} commit(s) behind upstream"
echo "  ${BEHIND} commit(s) ahead (your own changes)"

if [ "${AHEAD}" -gt 0 ]; then
  echo
  echo "New upstream commits you don't have yet:"
  git --no-pager log --oneline --no-decorate "HEAD..${UPSTREAM_BRANCH}"
  echo
  # Surface changeset entries — Matt's human-readable release notes.
  if git --no-pager diff --name-only "HEAD..${UPSTREAM_BRANCH}" | grep -q '^\.changeset/'; then
    echo "Changeset notes added upstream (release-worthy changes):"
    git --no-pager diff "HEAD..${UPSTREAM_BRANCH}" -- '.changeset/*.md' | sed -n 's/^+//p' | grep -v '^++' || true
    echo
  fi
  echo "To sync:  ./check-upstream.sh --sync    (then review + git push)"
else
  echo
  echo "Up to date with upstream. ✅"
fi

if [ "${1:-}" = "--sync" ]; then
  echo
  echo "Merging ${UPSTREAM_BRANCH} into '${CURRENT}'…"
  git merge "${UPSTREAM_BRANCH}"
  echo "Merge done. Review the result, then: git push"
fi
