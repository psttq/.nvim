local lazy = require "lazy"
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "epwalsh/pomo.nvim",
    lazy = false,
    version = "*", -- Recommended, use latest release instead of latest commit
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      -- See below for full list of options 👇
    },
  },
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      require("neoscroll").setup {}
    end,
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  {
    "andrewferrier/debugprint.nvim",
    lazy = false,
    opts = {},
    dependencies = {
      "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints for NeoVim 0.9
    },
    -- Remove the following line to use development versions,
    -- not just the formal releases
    version = "*",
  },
  {
    "luckasRanarison/clear-action.nvim",
    lazy = false,
    opts = {
      mappings = {
        code_action = { "<leader>aq", "Code Action" },
        refactor = { "<leader>ar", "Refactor" },
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
  },
  {
    "m-demare/hlargs.nvim",
    lazy = false,
    config = function()
      require("hlargs").setup {}
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    lazy = false,
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
      local hop = require "hop"
      vim.keymap.set("", "<leader>jc", function()
        hop.hint_char1()
      end, { remap = true, desc = "Hop char" })
      vim.keymap.set("", "<leader>jw", function()
        hop.hint_words()
      end, { remap = true, desc = "Hop words" })
      vim.keymap.set("", "<leader>jp", function()
        hop.hint_patterns()
      end, { remap = true, desc = "Hop patterns" })
    end,
  },
  {
    "jubnzv/virtual-types.nvim",
    lazy = false,
  },
  {
    "mawkler/modicator.nvim",
    lazy = false,
    dependencies = "mawkler/onedark.nvim", -- Add your colorscheme plugin here
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {
      -- Warn if any required option above is missing. May emit false positives
      -- if some other plugin modifies them, which in that case you can just
      -- ignore. Feel free to remove this line after you've gotten Modicator to
      -- work properly.
      show_warnings = true,
    },
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    config = function()
      require("scrollbar").setup()
    end,
  },
  {
    "chikko80/error-lens.nvim",
    lazy = false,
    event = "BufRead",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      -- your options go here
    },
  },
  {
    "tzachar/highlight-undo.nvim",
    lazy = false,
    opts = {
      ...,
    },
    config = function()
      require("highlight-undo").setup {
        duration = 300,
        undo = {
          hlgroup = "HighlightUndo",
          mode = "n",
          lhs = "u",
          map = "undo",
          opts = {},
        },
        redo = {
          hlgroup = "HighlightRedo",
          mode = "n",
          lhs = "<C-r>",
          map = "redo",
          opts = {},
        },
        highlight_for_count = true,
      }
    end,
  },
  {
    "Fildo7525/pretty_hover",
    lazy = false,
    event = "LspAttach",
    opts = {},
    config = function()
      require("pretty_hover").setup {}
      vim.keymap.set("", "<leader>oh", function()
        require("pretty_hover").hover()
      end, { remap = true, desc = "Open hover" })
      vim.keymap.set("", "<leader>oc", function()
        require("pretty_hover").close()
      end, { remap = true, desc = "Close hover" })
    end,
  },
  {
    "shellRaining/hlchunk.nvim",
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
          -- ...
        },
        line_num = {
          enable = true,
        },
      }
    end,
  },
  {
    "kevinhwang91/promise-async",
  },
  {
    "echasnovski/mini.animate",
    lazy = false,
    version = false,
    config = function()
      require("mini.animate").setup {
        scroll = {
          enable = false,
        },
      }
    end,
  },
  {
    "echasnovski/mini.move",
    lazy = false,
    version = "*",
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "LudoPinelli/comment-box.nvim",
    lazy = false,
    config = function()
      local wk = require "which-key"

      wk.register {
        ["<Leader>"] = {
          c = {
            name = " □  Boxes",
            b = { "<Cmd>CBccbox<CR>", "Box Title" },
            t = { "<Cmd>CBllline<CR>", "Titled Line" },
            l = { "<Cmd>CBline<CR>", "Simple Line" },
            d = { "<Cmd>CBd<CR>", "Remove a box" },
          },
        },
      }
    end,
  },
  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
