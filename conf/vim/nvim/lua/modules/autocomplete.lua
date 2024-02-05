return {
  lazy_load = function(load)
    -- vim.g.coq_settings = {
    --   auto_start = 'shut-up',
    --   clients = {
    --     ['tmux.enabled'] = false,
    --     ['paths.enabled'] = false,
    --     ['buffers.enabled'] = false,
    --     ['tags.enabled'] = false,
    --     tree_sitter = {
    --       enabled = true,
    --       always_on_top = true,
    --     },
    --     lsp = {
    --       enabled = true,
    --       resolve_timeout = 0.4,
    --     }
    --   },
    --   keymap = {
    --     manual_complete_insertion_only = true,
    --     manual_complete = "<C-x><C-o>",
    --     recommended = false,
    --   }
    -- }

    -- load "coq_nvim"
    load "nvim-cmp"
    load "cmp-nvim-lsp"
    load "cmp-path"
    load "cmp-buffer"
    load "cmp-cmdline"
    load "cmp-vsnip"
    load "vim-vsnip"
    load "cmp-nvim-lsp-signature-help"
  end,
  plugins = function(use)
    use {
      "hrsh7th/nvim-cmp",
      opt = true,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp-signature-help",
      },
    }

    -- use {
    --   "ms-jpq/coq_nvim",
    --   branch = "coq",
    --   opt = true,
    -- }
  end,
  setup = function()
    vim.lsp.protocol.CompletionItemKind = {
      "   (Text) ",
      "   (Method)",
      "   (Function)",
      "   (Constructor)",
      " ﴲ  (Field)",
      "[] (Variable)",
      "   (Class)",
      " ﰮ  (Interface)",
      "   (Module)",
      " 襁 (Property)",
      "   (Unit)",
      "   (Value)",
      " 練 (Enum)",
      "   (Keyword)",
      "   (Snippet)",
      "   (Color)",
      "   (File)",
      "   (Reference)",
      "   (Folder)",
      "   (EnumMember)",
      " ﲀ  (Constant)",
      " ﳤ  (Struct)",
      "   (Event)",
      "   (Operator)",
      "   (TypeParameter)",
    }
    local cmp = require "cmp"

    cmp.setup {
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm { select = true },
        ["<C-n>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          else
            cmp.complete()
          end
        end, { "i", "c" }),
        ["<C-p>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          else
            cmp.complete()
          end
        end, { "i", "c" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "vsnip" },
        { name = "nvim_lsp_signature_help" },
      },
      preselect = cmp.PreselectMode.None,
      formatting = {
        format = require("lspkind").cmp_format { with_text = false, maxwidth = 50 },
      },
      experimental = { ghost_text = true },
    }

    cmp.setup.cmdline(":", {
      sources = {
        { name = "cmdline" },
      },
    })

    cmp.setup.cmdline("/", {
      sources = {
        { name = "buffer" },
      },
    })

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on(
      "confirm_done",
      cmp_autopairs.on_confirm_done { map_char = {
        all = "(",
        tex = "{",
      } }
    )

    vim.cmd [[
    imap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    smap <expr> <C-j> vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<C-j>'
    imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<C-k>'
    ]]

    local npairs = require "nvim-autopairs"

    npairs.setup { check_ts = true, enable_check_bracket_line = false, map_bs = false, map_cr = false }
  end,

}
