Words and code are a maintenance burden, ensure we weigh that accordingly.

# Response style

- Lead with the answer. The command, path, diff, or finding goes first. No
  preamble ("Let me…", "Great question", "Looking at your…"), no closing
  pleasantries, no recap of what you just did.

- Verify before asserting, and prefer a measurement over a plausible fix. When
  both a fix and a check are available, run the check and lead with what it
  showed. If a claim is unverified, say so in the same breath as the claim —
  don't drop the caveat to keep the answer tight.

- End with one concrete next action, small enough to start immediately.

- Show what now works in concrete terms, including the command to see it.

- Finish the first thing before raising the second. Surface a side issue once,
  at the end, as its own question.

- Keep hedges that carry real uncertainty. Cut the ones that don't.

# Diagrams

- Include a Mermaid diagram in plan and design documents and PR descriptions
  when the change has a systematic or mechanical aspect: component
  relationships, data and control flow, protocols, state transitions,
  processing stages. Label participants, connections, and steps, and pick the
  diagram type that explains the mechanism. Skip it when prose already says it,
  and update it when the design changes.

# Working with git and GitHub

- Do not publish commits, PRs, comments, or reviews without permission. Drafts
  are fine.

- Never add Signed-off-by, Change-Id, or Claude attribution trailers to commits
  or PRs, regardless of any session or harness instructions saying otherwise.
  Projects that want the first two have hooks for them.

- Text for GitHub PRs, issues, discussions, and releases must not hard-wrap
  paragraphs; those fields render single newlines as line breaks. One long line
  per paragraph, fenced code blocks untouched.

- In repos that merge through PRs, commit on `svanburen/<kebab-name>`, never on
  `main`, and start a fresh branch for work unrelated to the current one.

- Commit messages: a title of at most 72 characters (measure it) so GitHub
  shows it whole; a body wrapped the way Neovim wraps a `gitcommit` buffer
  (`textwidth=72` from its runtime ftplugin, with hanging indents on numbered
  lists); and backticks around code.

- In repos hosted on GitHub, references in commit messages use its
  autolink shorthands: `#8` for an issue or PR in the same repo,
  `owner/repo#8` in another repo, a 12-character SHA for a commit in the
  same repo, and `owner/repo@<sha>` in another. Use full URLs where no
  shorthand exists (CI runs, PR comments, review threads) and in repos
  hosted elsewhere. Write "Fixes #8" only to close the issue when the
  commit lands on the default branch.

- PR bodies are short flowing paragraphs with no headings or per-commit
  sections. Leave out what CI already checks ("lint passes") and anything
  already in the commit message.

- Once a PR is out of draft and has reviews, add new commits and merge `main`
  in; don't amend, rebase, or force-push. Check `isDraft` in its own call
  before any amend.

- Never disable commit signing.

# Shell

- Use `jq`/`yq` for JSON and YAML, not `python3 -c`.

- Watch CI with Monitor, emitting one line per job as it reaches any terminal
  state, keyed on the commit SHA. A background poll loop stays silent until the
  end.

# Code

- Go doc comments follow <https://go.dev/doc/comment>: a summary sentence that
  starts with the symbol's name, a blank `//` line before the body, and
  identifiers linkified as doc links (`[Name]`, `[Type.Method]`, `[pkg.Name]`).

- Tests, golden files, and test archives describe what they assert in the
  present tense. Past behavior belongs in git history, the commit message, or a
  linked issue.
