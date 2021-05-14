local M = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'lunar',
    hidden_files = true,
    wrap_lines = false,
    shell = 'bash',

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = "maintained",
        highlight = {enabled = true},
        playground = {enabled = true},
        rainbow = {enabled = true}
    },

    paths = {
        data = vim.fn.stdpath('data'),
        cache = vim.fn.stdpath('cache'),
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},

    python = {
        linter = 'flake8',
        formatter = 'yapf',
        autoformat = true,
        isort = true,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true},
		analysis = {type_checking = "basic", auto_search_paths = true, use_library_code_types = true}
    },
    dart = {sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'},
    lua = {
        formatter = 'lua-format',
        autoformat = true,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    sh = {
        linter = 'shellcheck',
        formatter = 'shfmt',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    tsserver = {
        linter = 'eslint',
        formatter = 'prettier',
        autoformat = true,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    json = {
        formatter = 'prettier',
        autoformat = false,
        diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}
    },
    tailwindls = {filetypes = {'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'}},
    clang = {diagnostics = {virtual_text = {spacing = 0, prefix = ""}, signs = true, underline = true}},
	ruby = {
		diagnostics = {virtualtext = {spacing = 0, prefix = ""}, signs = true, underline = true},
		filetypes = {'rb', 'erb', 'rakefile'}
	},
    -- css = {formatter = '', autoformat = false, virtual_text = true},

	dashboard = {
		custom_header = {
'',
'                                           "',
'             m mm    mmm    mmm   m   m  mmm    mmmmm',
'             #"  #  #"  #  #" "#  "m m"    #    # # #',
'             #   #  #""""  #   #   #m#     #    # # #',
'             #   #  "#mm"  "#m#"    #    mm#mm  # # #',
'',
		},
		footer= {'https://github.com/lucaslollobrigida/dotfiles'}
	}
}

return M
