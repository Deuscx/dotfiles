local global = vim.g
local o = vim.o

vim.scriptencoding = "utf-8"

o.hlsearch = true
o.autoindent = true
o.number = true

-- system clipboard
o.clipboard = "unnamedplus"
-- Map <leader> to space
global.mapleader = " "
global.maplocalleader = " "
-- remap key

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { noremap = true,silent = true })
end

-- Exit insert mode
if vim.g.vscode then
    map("", "<Space>", "<Nop>", opts)
    -- map("", "/", "<Nop>", opts)
    -- Vim extension
    
    -- VSCode KeyMap
    map("n", "<Leader>o", "<Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>")
    map("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
    
    --VsCode Extension
    map("n", "<Leader>i", "<Cmd>call VSCodeNotify('extension.toggleBool')<CR>")
else
    -- ordinary Neovim
end

map("i", "jj", "<ESC>")
-- Select All
map("n", "<C-a>", "ggVG")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
          { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
          { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
          { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
          { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    require('config.treesitter')
})