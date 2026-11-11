return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "ruff_format", "ruff_organize_imports" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                json = { "prettier" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})

        -- Nvim 0.11+: configure servers with vim.lsp.config; mason-lspconfig enables them.
        vim.lsp.config("*", { capabilities = capabilities })

        vim.lsp.config("pyright", {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "standard",
                        autoImportCompletions = true,
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "workspace",
                    },
                },
            },
        })

        vim.lsp.config("ruff", {
            on_attach = function(client)
                -- pyright handles hover; ruff handles linting
                client.server_capabilities.hoverProvider = false
            end,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim", "ColorMyPencils", "R" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    format = {
                        enable = true,
                        -- NOTE: the value should be STRING!!
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                },
            },
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "ruff",
                "ts_ls",
                "eslint",
                "html",
                "jsonls",
                "terraformls",
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
