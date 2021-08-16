local M = {}

local failure_modes = {
  qlist = function(ctx)
    return function(job_id, data)
      local errfmt = vim.api.nvim_buf_get_option(ctx.bufnr, "errorformat")

      vim.api.nvim_command "doautocmd QuickFixCmdPost"
    end
  end,
  notify = function(ctx)
    return function(job_id, data)
      local messages = table.concat(
        vim.tbl_filter(function(m)
          return m ~= ""
        end, data),
        ""
      )

      if string.len(messages) > 0 then
        vim.api.nvim_notify(messages, vim.log.levels.ERROR, {})
      end
    end
  end,
}

local output_modes = {
  qlist = function(ctx)
    return function(job_id, data)
      vim.api.nvim_command "doautocmd QuickFixCmdPost"
    end
  end,
  notify = function(ctx)
    return function(job_id, data)
      local messages = table.concat(
        vim.tbl_filter(function(m)
          return m ~= ""
        end, data),
        ""
      )

      if string.len(messages) > 0 then
        vim.api.nvim_notify(messages, vim.log.levels.INFO, {})
      end
    end
  end,
}

function M.make(opts)
  local winnr = vim.fn.win_getid()
  local bufnr = vim.api.nvim_win_get_buf(winnr)

  local makeprg = vim.opt.makeprg:get() -- vim.api.nvim_buf_get_option(bufnr, "makeprg")

  if not makeprg then
    return
  end

  local on_stderr = failure_modes[opts and opts.on_failure or "notify"]
  local on_stdout = output_modes[opts and opts.on_output or "notify"]

  local cmd = vim.fn.expandcmd(makeprg)
  local ctx = { winnr = winnr, bufnr = bufnr, cmd = cmd }

  local job_id = vim.fn.jobstart(cmd, {
    on_stderr = on_stderr(ctx),
    on_stdout = on_stdout(ctx),
    stdout_buffered = true,
    stderr_buffered = true,
  })

  return job_id
end

function M.console() end

return M
