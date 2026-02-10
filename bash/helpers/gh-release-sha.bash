#!/usr/bin/env bash

# Get the SHA of the latest Github release in the current repository
gh-release-sha() {
    set -o pipefail
    gh release view --json tagName --jq .tagName | xargs -I{} gh api /repos/{owner}/{repo}/git/refs/tags/{} --jq .object.sha | xargs -I{} gh api /repos/{owner}/{repo}/git/tags/{} --jq .object.sha
}

export -f gh-release-sha
