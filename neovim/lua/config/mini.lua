-- https://github.com/echasnovski/mini.nvim
return {{
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        require('mini.comment').setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        })
    end,
}}
