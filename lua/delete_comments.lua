local M = {}

local function get_lang_from_parser(parser)
  if parser and parser.lang then return parser:lang() end
  return vim.bo.filetype
end

local function only_ws_before(line, col)
  return line:sub(1, col):match("^%s*$") ~= nil
end

local function only_ws_after(line, col)
  return line:sub(col + 1):match("^%s*$") ~= nil
end

function M.run()
  local bufnr = 0

  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    vim.notify("Tree-sitter parser not found", vim.log.levels.ERROR)
    return
  end
  local lang = get_lang_from_parser(parser)

  local query_ok, query = pcall(vim.treesitter.query.parse, lang, "((comment) @c)")
  if not query_ok or not query then
    vim.notify("Could not create call for this lang: " .. tostring(lang), vim.log.levels.ERROR)
    return
  end

  local orig_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local ranges = {}
  local lines_to_delete = {}  

  local function mark_line_for_possible_delete(lnum)
    lines_to_delete[lnum] = true
  end

  for _, tree in ipairs(parser:parse()) do
    local root = tree:root()
    for id, node, _ in query:iter_captures(root, bufnr, 0, -1) do
      local cap = query.captures[id]
      if cap == "c" then
        local sr, sc, er, ec = node:range() 
        table.insert(ranges, { sr = sr, sc = sc, er = er, ec = ec })

        if sr == er then
          local line = orig_lines[sr + 1] or ""
          if only_ws_before(line, sc) and only_ws_after(line, ec) then
            mark_line_for_possible_delete(sr)
          end
        else
          local sline = orig_lines[sr + 1] or ""
          if only_ws_before(sline, sc) then
            mark_line_for_possible_delete(sr)
          end
          for l = sr + 1, er - 1 do
            mark_line_for_possible_delete(l)
          end
          local eline = orig_lines[er + 1] or ""
          if only_ws_after(eline, ec) then
            mark_line_for_possible_delete(er)
          end
        end
      end
    end
  end

  if #ranges == 0 then
    vim.notify("No comments found", vim.log.levels.INFO)
    return
  end

  table.sort(ranges, function(a, b)
    if a.sr == b.sr then return a.sc > b.sc end
    return a.sr > b.sr
  end)
  for _, r in ipairs(ranges) do
    vim.api.nvim_buf_set_text(bufnr, r.sr, r.sc, r.er, r.ec, { "" })
  end

  local last = vim.api.nvim_buf_line_count(bufnr)
  for l = last, 1, -1 do
    local idx0 = l - 1
    if lines_to_delete[idx0] then
      local cur_line = vim.api.nvim_buf_get_lines(bufnr, idx0, idx0 + 1, false)[1] or ""
      if cur_line:match("^%s*$") then
        vim.api.nvim_buf_set_lines(bufnr, idx0, idx0 + 1, false, {})
      end
    end
  end

  vim.notify("Comments are deleted", vim.log.levels.INFO)
end

return M
