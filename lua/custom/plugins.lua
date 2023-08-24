local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "stevearc/resession.nvim",
    lazy = false,
    config = function ()
      local resession = require("resession")

      resession.setup({
        autosave = {
          enabled = true,
          interval = 60,
          notify = false
        }
      })

      
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
           if vim.fn.argc(-1) == 0 then
             resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
           end
        end,
      })
      vim.api.nvim_create_autocmd("VimLeavePre", {
         callback = function()
           resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
         end,
      })
    end
  }
}

return plugins
