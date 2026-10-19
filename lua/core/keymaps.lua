vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true


vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd("set number")
vim.cmd("set relativenumber")

vim.opt.termguicolors = true

vim.keymap.set('n', 'zz', function() vim.cmd("cd %:p:h") end)
vim.keymap.set('n', '<Esc>', function() vim.cmd("nohlsearch") end, { silent = true })
vim.keymap.set('n', '<leader>t', function() vim.cmd("Themery") end, { silent = true })

local transparent = false
local saved_highlights = {}

local function ToggleBg()
  transparent = not transparent

  for _, group in ipairs({ "Normal", "NormalFloat" }) do
    if transparent then
      local highlight = vim.api.nvim_get_hl(0, { name = group, link = false })
      saved_highlights[group] = vim.deepcopy(highlight)
      highlight.bg = nil
      vim.api.nvim_set_hl(0, group, highlight)
    else
      vim.api.nvim_set_hl(0, group, saved_highlights[group])
    end
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    transparent = false
    saved_highlights = {}
  end,
})

vim.keymap.set("n", "<leader>y", ToggleBg, { desc = "Toggle bg transparency" })


-- =========================
-- FILE TREE
-- =========================
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>", { silent = true })

-- =========================
-- TELESCOPE
-- =========================
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })

-- =========================
-- SPLITS
-- =========================
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":split<CR>", { silent = true })

-- =========================
-- MOVE BETWEEN WINDOWS
-- =========================
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")

-- =========================
-- BUFFER NAVIGATION
-- =========================
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { silent = true })

-- =========================
-- CLOSE WINDOW
-- =========================
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
