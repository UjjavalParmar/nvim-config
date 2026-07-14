return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        require('nvim-autopairs').setup({
            -- Disable autopairs in specific filetypes
            disable_filetype = { "TelescopePrompt", "spectre_panel", "snacks_picker_input" },
            
            -- Enable these features
            enable_moveright = true,
            enable_afterquote = true,
            enable_check_bracket_line = true,
            enable_bracket_in_quote = true,
            
            -- Disable these features
            disable_in_macro = true,
            disable_in_visualblock = false,
            disable_in_replace_mode = true,
            
            -- Mapping
            map_cr = true,
            map_bs = true,
            map_c_h = false,
            map_c_w = false,
        })
    end
}
