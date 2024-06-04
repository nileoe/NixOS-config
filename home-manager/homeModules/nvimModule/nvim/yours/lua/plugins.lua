-- sets up Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath) -- shorthand for vim.opt.rtp.prepend(vim.opt.rtp, lazypath)
-- looks into runtime path dirs and looks for lazy, and runs the init.lua from this directory
require("lazy").setup({
    { -- ALL OF THIS IS TREESITTER DO NOT PANIC
        -- treesitter allows for multiple modules (i.e. plugins) in treesitter.configs.
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                -- when you wanna install another language parser:
                -- add to above table according to this list:
                -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
                -- actually because anto_install active u don't need to

                auto_install = true,

                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = { -- set to `false` to disable one of the mappings
                        -- init_selection = "<leader>ss",       -- Selection Start
                        -- scope_incremental = "<leader>sc",    -- Selection sCope increement
                        -- node_incremental = "<leader>si",     -- Selection Increment
                        -- node_decremental = "<leader>sd",     -- Selection Decrement
                        node_incremental = "v", -- Selection Increment
                        node_decremental = "V", -- Selection Decrement
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- you can use the capture groups defined in textobjects.scm
                            -- those effectvely become new MOTIONS like iw, i{, a" etc.
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- you can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "select inner part of a class region" },
                            -- you can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "select language scope" },
                        },
                        -- you can choose the select mode (default is charwise 'v') MEANING normal visual mode
                        --
                        -- can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'v', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        -- BASICALLY (Lino) which type of visual mode should each selection use?
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'v',  -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- if you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = true,
                    },
                },
            }) -- END OF TREESITTER STUFF ffs
        end,
    },
    -- ############################ MASON / LSPs ############################
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        "neovim/nvim-lspconfig",
        --        dependencies = { "mason-lspconfig.nvim" },
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        -- mason lsp server names don't always match with nvim-lspconfig.
        -- This plugin (mason-lspconfig.nvim) bridges the two.
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
            -- the function below (setup_handlers) essentially takes care of installing to the mason-installed LSPs.
            -- to actually understand it: help on :h mason-lspconfig-automatic-server-setup
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            })
        end,
    },
    -- NO DAP INSTALLLED FOR MASON (install stuff listed on mason github installation required plugins)
    -- I think: only LSPs are taken care of. for linter / dapper / formatter probably do more stuff
    -- To install LSPs: use Mason, install, and the lsp should work. To see if it's active: run LspInfo in a file in which it should be active.
    -- ############################ END of Mason / LSPs ############################
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    {
        "Eandrju/cellular-automaton.nvim"
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            local harpoonConfigFileFfs = require("plugins/harpoon")
            harpoon:setup({})

            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end

            -- vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
            -- { desc = "Open harpoon window" })
        end,
    },
    {
        "folke/zen-mode.nvim"
    },
    -- #################################### LINT ####################################
    -- NOTE: current config doesnt't have lint configured.
    {
        "mfussenegger/nvim-lint",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = { -- linters by file type
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                -- add other languages here https://www.youtube.com/watch?v=y1WWOaLCNyI
            }
            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                group = lint_augroup,
                callback = function()
                    lint.try_lint()
                end,
            })
            vim.keymap.set("n", "<leader>ll", function()
                lint.try_lint()
            end, { desc = "Trigger linting for current file" })
        end,
    },
    -- #################################### FORMATTER ####################################
    -- NOTE: current config doesnt't have formatter configured.
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    javascript = { { "prettierd", "prettier" } },
                    typescript = { { "prettierd", "prettier" } },
                    javascriptreact = { { "prettierd", "prettier" } },
                    typescriptreact = { { "prettierd", "prettier" } },
                    css = { { "prettierd", "prettier" } },
                    scss = { { "prettierd", "prettier" } },
                    json = { { "prettierd", "prettier" } },
                    java = { "google-java-format" },
                    html = { "htmlbeautifier" },
                    bash = { "buf" },
                    rust = { "rustfmt" },
                    toml = { "taplo" },
                    -- add other languages here https://www.youtube.com/watch?v=y1WWOaLCNyI
                }
            })

            vim.keymap.set({ "n", "v" }, "<leader>l", function()
                conform.format({
                    -- runs vim.lsp.buf.format()
                    lsp_fallback = true, -- use other formatter if this one doesn't work (after 500 ms I guess)
                    timeout_ms = 500,
                    async = false,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
    -- #################################### AUTOCOMPLETE ####################################
    -- #################################### COLOUR THEMES BELOW THIS LINE ####################################
    -- fzf-lua used to pick color themes lol
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            vim.keymap.set({ "n", "v" }, "<leader>ff", ":FzfLua files<CR>")
            vim.keymap.set({ "n", "v" }, "<leader>fco", ":FzfLua colorschemes<CR>")
            require("fzf-lua").setup({})
        end
    },
    {
        'sainnhe/edge',
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.edge_enable_italic = true
            -- vim.cmd.colorscheme('edge')
        end
    },
    {
        "catppuccin/nvim",
        config = function()
            -- vim.cmd.colorscheme("catppuccin-mocha")
        end
    },
    "rebelot/kanagawa.nvim",
    "rose-pine/neovim",
    "EdenEast/nightfox.nvim",
    "savq/melange-nvim",
    "projekt0n/github-nvim-theme",
})
-- vim.cmd.colorscheme("catppuccin-mocha")

-- for nvim: functions return something, commands ("void") don't and just do something
-- to run vim command from init.lua file: vim.cmd.COMMANDNAME("arguments")
