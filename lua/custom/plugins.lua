local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "elentok/format-on-save.nvim",
    lazy = true,
    cmd = { "Format" },
    event = { "BufRead" },
    opts = function()
      local formatters = require "format-on-save.formatters"
      return {
        experiments = {
          partial_update = "diff",
        },
        formatter_by_ft = {
          json = formatters.lsp,
          lua = formatters.stylua,
          rust = formatters.lsp,
          sh = formatters.shfmt,
          toml = formatters.lsp,
          yaml = formatters.lsp,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require "crates"

      crates.setup(opts)
      crates.show()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, { name = "crates" })
      return M
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    setup = function()
      require("gitsigns").setup {
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      }
    end,
  },
}

return plugins
