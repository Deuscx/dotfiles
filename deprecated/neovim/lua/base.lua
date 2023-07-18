local global = vim.g
local o = vim.o

vim.scriptencoding = "utf-8"

o.hlsearch = true
o.autoindent = true
o.number = true
o.mouse = "a"

-- system clipboard
o.clipboard = "unnamedplus"
-- Map <leader> to space
global.mapleader = " "
global.maplocalleader = " "
-- remap key

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {
        noremap = true,
        silent = true
    })
end

-- Exit insert mode
if vim.g.vscode then
    map("", "<Space>", "<Nop>", opts)
    -- map("", "/", "<Nop>", opts)
    -- Vim extension

    -- VSCode KeyMap
    map("n", "<Leader>o", "<Cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<CR>")
    map("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")

    -- Copy in normal mode. when https://github.com/vscode-neovim/vscode-neovim/issues/1266 fixed. Remove it and use `y` to copy
    map("n", "<C-c>", "<Cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>")

    map("n", "za", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>")
    -- VsCode Extension
    map("n", "<Leader>i", "<Cmd>call VSCodeNotify('extension.toggleBool')<CR>")
else
    -- ordinary Neovim
end

map("i", "jj", "<ESC>")
-- Select All
map("n", "<C-a>", "ggVG")

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {{
        "s",
        mode = {"n", "x", "o"},
        function()
            require("flash").jump()
        end,
        desc = "Flash"
    }, {
        "S",
        mode = {"n", "o", "x"},
        function()
            require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
    }, {
        "r",
        mode = "o",
        function()
            require("flash").remote()
        end,
        desc = "Remote Flash"
    }, {
        "R",
        mode = {"o", "x"},
        function()
            require("flash").treesitter_search()
        end,
        desc = "Treesitter Search"
    }, {
        "<c-s>",
        mode = {"c"},
        function()
            require("flash").toggle()
        end,
        desc = "Toggle Flash Search"
    }}
}, require('config.treesitter'), require('config.mini')})
