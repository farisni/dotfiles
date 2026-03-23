vim.g.maplocalleader = " "

-- 安装 lazy.nvim 的自动引导代码
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 🚀 这里定义你的插件列表
require("lazy").setup({
  -- 1. 颜色主题
  "folke/tokyonight.nvim",

  -- 2. 文件树
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons", -- 文件图标

  -- 3. 语法高亮 (Treesitter)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "lua", "python", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- 4. 自动补全 (LSP + CMP)
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/nvim-cmp",

  -- 5. Mason (管理语言服务器)
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- 6. 状态栏
  "nvim-lualine/lualine.nvim",

  -- 7. 快捷键提示
  "folke/which-key.nvim",

  -- 8. Better Escape (快速退出插入模式)
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup({
        timeout = vim.o.timeoutlen,
        default_mappings = false,
        mappings = {
          i = {
            j = {
              k = "<Esc>",
              j = "<Esc>",
            },
          },
          c = {
            j = {
              k = "<C-c>",
              j = "<C-c>",
            },
          },
          t = {
            j = {
              k = "<C-\\><C-n>",
              j = "<C-\\><C-n>",
            },
          },
        },
      })
    end,
  },
}, {
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- 🎨 应用主题
vim.cmd.colorscheme("tokyonight")

-- ⚙️ 插件初始化
require("nvim-tree").setup()
require("lualine").setup()
require("which-key").setup()

-- LSP 自动补全配置 (基础版)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
-- 示例：启用 Python 和 Lua 的语言服务器 (需要先通过 :Mason 安装)
-- lspconfig.pyright.setup({ capabilities = capabilities })
-- lspconfig.lua_ls.setup({ capabilities = capabilities })

