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
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
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
          -- rust = formatters.lsp,
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
  {
    "petertriho/nvim-scrollbar",
    setup = function()
      require("nvim-scrollbar").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    setup = function()
      require("neodev").setup {
        library = {
          enabled = true,
        },
        lspconfig = true,
      }
    end,
  },
  {
    "olimorris/persisted.nvim",
    config = true,
    lazy = false,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = "olimorris/persisted.nvim",
    opts = {
      extensions_list = { "themes", "terms", "persisted" },
      extensions = {
        persisted = {
          prompt_title = "Session Manager",
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    enabled = true,
    lazy = false,
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover = { enabled = false },
        signature = { enabled = false },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      views = {
        messages = { backend = "popup" },
      },
      popupmenu = { enabled = true, backend = "nui" },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_show", find = '"*"*lines --*%--' },
          opts = { skip = true },
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = { enabled = false },
      select = { enabled = true },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    opts = {
      top_down = true,
      max_width = 100,
    },
  },
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 100
    end,
    opts = {
      window = {
        border = "rounded",
        position = "bottom",
        margin = { 10, 10, 4, 10 },
      },
    },
  },
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      local glance = require "glance"
      local actions = glance.actions
      glance.setup {
        height = 25,
        border = {
          enable = true,
          top_char = "▔",
          bottom_char = "▁",
        },
        theme = { enable = true, mode = "auto" },
        mappings = {
          list = {
            ["<C-v>"] = actions.jump_vsplit,
            ["<C-x>"] = actions.jump_split,
            ["<C-t>"] = actions.jump_tab,
          },
        },
      }
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
  },
}

return plugins
