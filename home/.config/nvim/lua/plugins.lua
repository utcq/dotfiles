local lazypath = vim.fn.stdpath("data") .. "/site/pack/packer/start/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "kanagawa",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            colored = true,
            symbols = { added = " ", modified = "柳 ", removed = " " }, -- fancy icons
          },
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            diagnostics_color = {
              error = "DiagnosticError",
              warn  = "DiagnosticWarn",
              info  = "DiagnosticInfo",
              hint  = "DiagnosticHint",
            },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = "slant",
        show_buffer_icons = true,
        show_close_icon = false,
        enforce_regular_tabs = false,
        max_prefix_length = 15,
        truncate_names = true,
        numbers = "none",
        always_show_bufferline = true,
        diagnostics = "nvim_lsp",
        indicator = { style = 'underline' },
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error"   and " "
                      or e == "warning" and " "
                      or e == "info"    and " "
                      or " "
            s = s .. n .. sym
          end
          return s
        end,
      },
      highlights = {
        fill = {
          guifg = "#a9b1d6",
          guibg = "#181616",
        },
        background = {
          guifg = "#565f89",
          guibg = "#181616",
        },
        buffer_selected = {
          guifg = "#c0caf5",
          guibg = "#181616",
          gui = "bold",
        },
      },
    },
  },

  { "nvim-tree/nvim-web-devicons" },

  {
    "goolord/alpha-nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require("alpha.themes.startify")
      startify.file_icons.provider = "devicons"
      require("alpha").setup(
        startify.config
      )
    end,
  },

  { 'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup()
    end
  },

  {
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        comment_empty = false,
        hook = nil
      })
    end,
  },

  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "rebelot/kanagawa.nvim"
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl"
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "cpp", "lua", "python", "rust", "javascript", "typescript" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        indent = { enable = true },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.pyright.setup({})
      lspconfig.rust_analyzer.setup({})
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        })
      })
    end,
  },
})


local highlight = { "KanagawaIndent" }

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "KanagawaIndent", { fg = "#2c2e3f", nocombine = true })
end)

require("ibl").setup {
  indent = {
    highlight = highlight,
    char = "▏",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
  },
  exclude = { filetypes = { "help", "terminal", "dashboard" } },
}

require('kanagawa').setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  transparent = false,
  dimInactive = false,
  terminalColors = true,
  theme = "dragon",
  overrides = function(colors)
    return {
      NormalFloat = { bg = colors.theme.ui.bg_p1 },
      FloatBorder = { fg = colors.palette.sumiInk4 },
      TelescopeBorder = { fg = colors.palette.sumiInk4 },
      TelescopePromptBorder = { fg = colors.palette.sumiInk4 },
      TelescopeResultsBorder = { fg = colors.palette.sumiInk4 },
      TelescopePreviewBorder = { fg = colors.palette.sumiInk4 },
      DiagnosticVirtualTextError = { bg = colors.palette.samuraiRed, fg = colors.palette.fujiWhite },
      DiagnosticVirtualTextWarn = { bg = colors.palette.roninYellow, fg = colors.palette.fujiWhite },
      DiagnosticVirtualTextInfo = { bg = colors.palette.waveAqua1, fg = colors.palette.fujiWhite },
      DiagnosticVirtualTextHint = { bg = colors.palette.dragonBlue, fg = colors.palette.fujiWhite },
      Pmenu = { bg = "none" },
    }
  end,
})
vim.cmd("colorscheme kanagawa-dragon")
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "CmpItemAbbr", { link = "Pmenu" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "CmpItemKind", { link = "Type" })
    vim.api.nvim_set_hl(0, "CmpItemMenu", { link = "Comment" })
  end,
})
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Comment" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#3e4452", fg = "white" }) -- selected item

require('telescope').setup{
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    path_display = { "smart" },
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = { prompt_position = "top" },
      vertical = { mirror = false },
    },
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
  }
}


