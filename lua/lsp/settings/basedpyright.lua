return {
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, {
      "pyrightconfig.json", "pyproject.toml", "setup.py", "setup.cfg",
      "requirements.txt", "Pipfile", ".git",
    })
    if not root or root == vim.uv.os_homedir() or root == "/" then
      root = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
    end
    on_dir(root)
  end,
  before_init = function(params, config)
    local root = params.rootUri and vim.uri_to_fname(params.rootUri)
    if root == vim.uv.os_homedir() or root == "/" then
      -- Keep diagnostics for open files without enumerating home or the disk.
      config.settings.basedpyright.analysis.exclude = { "**/*" }
    end
  end,
  settings = {
    basedpyright = {
      analysis = {
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}
