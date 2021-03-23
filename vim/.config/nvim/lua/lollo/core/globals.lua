--- Pretty print a lua table
-- @param t (table)
function P(t)
  print(vim.inspect(t))
end

--- Load a registered package
-- @param package (string)
function Packadd(package)
  vim.cmd(string.format('packadd %s', package))
end

function Nvim_multiline_command(command)
  vim.validate { command = { command, 's' } }
  for line in vim.gsplit(command, "\n", true) do
    vim.api.nvim_command(line)
  end
end

local function make_mapping(mode, opts)
  local mapping = opts.lhs or opts[1]
  local action = opts.rhs or opts[2]
  vim.api.nvim_set_keymap(mode, mapping, action, { noremap = true })
end

function Nnoremap(opts)
  local args = vim.tbl_extend("force", { noremap = true }, opts)
  make_mapping('n', args)
end

function Inoremap(opts)
  local args = vim.tbl_extend("force", { noremap = true }, opts)
  make_mapping('i', args)
end
