vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 4
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus"
vim.opt.signcolumn = "yes"


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    install = { colorscheme = { "default" } },
    checker = { enable = false },
    spec = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "bash",
                        "c",
                        "cmake",
                        "cpp",
                        "java",
                        "lua",
                        "luadoc",
                        "make",
                        "python",
                        "rust",
                        "toml",
                        "vim",
                        "vimdoc",
                    },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>f", builtin.find_files)
                vim.keymap.set("n", "<leader>b", builtin.buffers)
                vim.keymap.set("n", "<leader>n", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end)
                vim.keymap.set("n", "<leader>g", builtin.live_grep)
            end,
        },
        {
            "kylechui/nvim-surround",
            config = true,
        },
    },
})
