local parser_install_dir = vim.fn.stdpath("data") .. "/treesitter"

vim.opt.runtimepath:prepend(parser_install_dir)

if vim.fn.has("nvim-0.12") == 1 then
  -- Legacy nvim-treesitter callbacks expect one node per capture.
  local query = vim.treesitter.query
  local original = {}
  for _, name in ipairs({ "add_predicate", "add_directive" }) do
    local register = query[name]
    original[name] = register
    query[name] = function(name, handler, opts)
      if type(opts) == "table" and opts.all == false then
        local legacy_handler = handler
        handler = function(match, ...)
          local nodes = {}
          for id, captures in pairs(match) do
            nodes[id] = captures[#captures]
          end
          return legacy_handler(nodes, ...)
        end
      end
      return register(name, handler, opts)
    end
  end
  local ok, err = pcall(require, "nvim-treesitter.query_predicates")
  for name, register in pairs(original) do
    query[name] = register
  end
  if not ok then
    error(err)
  end
end

require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "c", "cpp", "haskell", "lua", "markdown", "markdown_inline", "prolog", "python", "query", "vim", "vimdoc" },
  parser_install_dir = parser_install_dir,

  sync_install = false,
  auto_install = false,
  highlight = {
    enable = true,
  },
}
