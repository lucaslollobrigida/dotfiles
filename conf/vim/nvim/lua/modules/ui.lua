local function status_line()
  local windline = require "windline"
  local helper = require "windline.helpers"

  local state = _G.WindLine.state

  local basic_comps = require "windline.components.basic"
  local lsp_comps = require "windline.components.lsp"
  local git_comps = require "windline.components.git"
  local cache_utils = require "windline.cache_utils"

  local fn = vim.fn

  local function get_buf_name(modify, shorten)
    return function(bufnr)
      local bufname = fn.bufname(bufnr)
      bufname = fn.fnamemodify(bufname, modify)
      if shorten then
        return fn.pathshorten(bufname)
      end
      return bufname
    end
  end

  local file_name = function(default)
    default = default or "[No Name]"

    local fnc_name = get_buf_name ":t"

    fnc_name = get_buf_name("%:p", false)
    return function(bufnr)
      local name = fnc_name(bufnr)
      if name == "" then
        name = default
      end
      return name .. " "
    end
  end

  basic_comps.cache_file_name = function(default)
    return cache_utils.cache_on_buffer("BufEnter", "WL_filename", file_name(default))
  end

  local hl_list = {
    Black = { "white", "black" },
    White = { "black", "white" },
    Inactive = { "InactiveFg", "InactiveBg" },
    Active = { "ActiveFg", "ActiveBg" },
  }
  local basic = {}

  local breakpoint_width = 90
  basic.divider = { basic_comps.divider, "" }
  basic.bg = { " ", "StatusLine" }

  local colors_mode = {
    Normal = { "red", "black" },
    Insert = { "green", "black" },
    Visual = { "yellow", "black" },
    Replace = { "blue_light", "black" },
    Command = { "magenta", "black" },
  }

  basic.vi_mode = {
    name = "vi_mode",
    hl_colors = colors_mode,
    text = function()
      return {
        { " ", "" },
        { basic_comps.cache_file_icon(), state.mode[2] },
      }
    end,
  }

  basic.square_mode = {
    hl_colors = colors_mode,
    text = function()
      return { { "▊", state.mode[2] } }
    end,
  }

  basic.lsp_diagnos = {
    name = "diagnostic",
    hl_colors = {
      red = { "red", "black" },
      yellow = { "yellow", "black" },
      blue = { "blue", "black" },
    },
    width = breakpoint_width,
    text = function(bufnr)
      if lsp_comps.check_lsp(bufnr) then
        return {
          { lsp_comps.lsp_error { format = "  %s", show_zero = true }, "red" },
          { lsp_comps.lsp_warning { format = "  %s", show_zero = true }, "yellow" },
          { lsp_comps.lsp_hint { format = "  %s", show_zero = true }, "blue" },
        }
      end
      return ""
    end,
  }

  basic.file = {
    name = "file",
    hl_colors = {
      default = hl_list.Black,
      white = { "white", "black" },
      magenta = { "magenta", "black" },
    },
    text = function(_, _, width)
      if width > breakpoint_width then
        return {
          { " ", "" },
          { basic_comps.cache_file_name "[No Name]", "magenta" },
          { basic_comps.line_col_lua, "white" },
          { basic_comps.progress_lua, "" },
          { " ", "" },
          { basic_comps.file_modified " ", "magenta" },
        }
      else
        return {
          { " ", "" },
          { basic_comps.cache_file_name "[No Name]", "magenta" },
          { " ", "" },
          { basic_comps.file_modified " ", "magenta" },
        }
      end
    end,
  }

  basic.metals = {
    name = "metals",
    hl_colors = {
      default = hl_list.Black,
      white = { "white", "black" },
      magenta = { "magenta", "black" },
    },
    text = function()
      local status = vim.g["metals_status"] or ""
      return {
        { " ", "" },
        { status, "magenta" },
        { "  ", "" },
      }
    end,
  }

  basic.git = {
    name = "git",
    hl_colors = {
      green = { "green", "black" },
      red = { "red", "black" },
      blue = { "blue", "black" },
    },
    width = breakpoint_width,
    text = function(bufnr)
      if git_comps.is_git(bufnr) then
        return {
          { git_comps.diff_added { format = "  %s", show_zero = true }, "green" },
          { git_comps.diff_removed { format = "  %s", show_zero = true }, "red" },
          { git_comps.diff_changed { format = " 柳%s", show_zero = true }, "blue" },
        }
      end
      return ""
    end,
  }

  local quickfix = {
    filetypes = { "qf", "Trouble" },
    active = {
      { "🚦 Quickfix ", { "white", "black" } },
      { helper.separators.slant_right, { "black", "black_light" } },
      {
        function()
          return vim.fn.getqflist({ title = 0 }).title
        end,
        { "cyan", "black_light" },
      },
      { " Total : %L ", { "cyan", "black_light" } },
      { helper.separators.slant_right, { "black_light", "InactiveBg" } },
      { " ", { "InactiveFg", "InactiveBg" } },
      basic.divider,
      { helper.separators.slant_right, { "InactiveBg", "black" } },
      { "🧛 ", { "white", "black" } },
    },

    always_active = true,
    show_last_status = true,
  }

  local explorer = {
    filetypes = { "fern", "NvimTree", "lir" },
    active = {
      { "  ", { "black", "red" } },
      { helper.separators.slant_right, { "red", "NormalBg" } },
      { basic_comps.divider, "" },
      { basic_comps.file_name "", { "white", "NormalBg" } },
    },
    always_active = true,
    show_last_status = true,
  }

  basic.lsp_name = {
    width = breakpoint_width,
    name = "lsp_name",
    hl_colors = {
      magenta = { "magenta", "black" },
    },
    text = function(bufnr)
      if lsp_comps.check_lsp(bufnr) then
        return {
          { lsp_comps.lsp_name(), "magenta" },
        }
      end
      return {}
    end,
  }

  local default = {
    filetypes = { "default" },
    active = {
      basic.square_mode,
      basic.vi_mode,
      basic.file,
      basic.lsp_diagnos,
      basic.divider,
      -- basic.file_right,
      basic.metals,
      basic.lsp_name,
      basic.git,
      { git_comps.git_branch(), { "magenta", "black" }, breakpoint_width },
      { " ", hl_list.Black },
      basic.square_mode,
    },
    inactive = {
      { basic_comps.full_file_name, hl_list.Inactive },
      basic.file_name_inactive,
      basic.divider,
      basic.divider,
      { basic_comps.line_col, hl_list.Inactive },
      { basic_comps.progress, hl_list.Inactive },
    },
  }

  windline.setup {
    colors_name = function(colors)
      -- print(vim.inspect(colors))
      -- ADD MORE COLOR HERE ----
      return colors
    end,
    statuslines = {
      default,
      quickfix,
      explorer,
    },
  }
end

return {
  lazy_load = function(load)
    load "embark"
    load "nvim-notify"
    load "indent-blankline.nvim"
    load "windline.nvim"
    load "nui.nvim"
    load "noice.nvim"
    load "github-theme"
    load "tokyonight.nvim"
  end,
  plugins = function(use)
    use {
      "embark-theme/vim",
      as = "embark",
      opt = true,
    }
    use {
      "projekt0n/github-nvim-theme",
      tag = "v0.0.7",
      opt = true,
      config = function()
        require("github-theme").setup {}
      end,
    }
    use { 'folke/tokyonight.nvim', opt = true }
    use { "lukas-reineke/indent-blankline.nvim", opt = true }
    use { "windwp/windline.nvim", opt = true }

    use {
      "folke/noice.nvim",
      requires = {
        { "MunifTanjim/nui.nvim", opt = true },
        { "rcarriga/nvim-notify", opt = true },
      },
    }
    use {
      'j-hui/fidget.nvim',
      tag = 'legacy',
      event = "LspAttach",
      config = function()
        require("fidget").setup {
          -- options
        }
      end
    }
  end,
  setup = function()
    local C = require "config"
    -- require("noice").setup()

    vim.cmd("colorscheme " .. C.colorscheme)

    vim.g.embark_terminal_italics = true

    vim.cmd "hi link xmlEndTag xmlTag"
    vim.cmd "hi htmlArg gui=italic"
    vim.cmd "hi Comment gui=italic"
    vim.cmd "hi Type gui=italic"
    vim.cmd "hi htmlArg cterm=italic"
    vim.cmd "hi Type cterm=italic"

    require("ibl").setup {
      indent = { char = "¦" },
      scope = { exclude = { language = { "terminal", "clojure" } } },
    }

    if pcall(require, "notify") then
      vim.notify = require "notify"
    end

    status_line()
  end,
}
