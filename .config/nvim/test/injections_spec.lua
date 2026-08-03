-- Lightweight smoke test for after/queries/yaml/injections.scm: verifies
-- sourcehut's "tasks:" (dynamic per-task keys, so upstream nvim-treesitter's
-- literal-key heuristics like "run"/"script" don't match it) still gets
-- injected as bash.
--
-- Run: just test-injections (from ~), or directly from this directory:
--   nvim --headless --noplugin -u NONE -c "packadd nvim-treesitter" -l test/injections_spec.lua

local cases = {
  {
    name = "sourcehut tasks: -> bash",
    text = table.concat({
      "image: alpine/edge",
      "tasks:",
      "  - build: |",
      "      cd $site",
      "      hugo build",
      "  - publish: |",
      "      just publish",
    }, "\n"),
    expect_lang = "bash",
    expect_matches = 2,
  },
}

local failures = 0

for _, case in ipairs(cases) do
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(case.text, "\n"))
  vim.bo[buf].filetype = "yaml"

  local parser = vim.treesitter.get_parser(buf, "yaml")
  local root = parser:parse()[1]:root()
  local query = vim.treesitter.query.get("yaml", "injections")

  local found = 0
  for id, node, metadata in query:iter_captures(root, buf, 0, -1) do
    if query.captures[id] == "injection.content" and metadata["injection.language"] == case.expect_lang then
      found = found + 1
    end
  end

  if found ~= case.expect_matches then
    failures = failures + 1
    io.stderr:write(string.format(
      "FAIL: %s -- expected %d %q injection(s), got %d\n",
      case.name,
      case.expect_matches,
      case.expect_lang,
      found
    ))
  else
    print(string.format("ok: %s (%d %q injection(s))", case.name, found, case.expect_lang))
  end
end

if failures > 0 then
  os.exit(1)
end
