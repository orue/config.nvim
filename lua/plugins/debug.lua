return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local utils = require('config.utils')

      -- Set breakpoint signs
      vim.fn.sign_define('DapBreakpoint', {
        text = '🔴',
        texthl = 'DapBreakpoint',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapBreakpointCondition', {
        text = '🟡',
        texthl = 'DapBreakpointCondition',
        linehl = '',
        numhl = ''
      })
      vim.fn.sign_define('DapStopped', {
        text = '▶️',
        texthl = 'DapStopped',
        linehl = 'DapStoppedLine',
        numhl = ''
      })
      
      -- Python DAP configuration
      dap.adapters.python = function(cb, config)
        if config.request == 'attach' then
          local port = (config.connect or config).port
          local host = (config.connect or config).host or '127.0.0.1'
          cb({
            type = 'server',
            port = assert(port, '`connect.port` is required for a python `attach` configuration'),
            host = host,
            options = {
              source_filetype = 'python',
            },
          })
        else
          cb({
            type = 'executable',
            command = utils.get_python_path(),
            args = { '-m', 'debugpy.adapter' },
            options = {
              source_filetype = 'python',
            },
          })
        end
      end

      dap.configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = "Launch file",
          program = "${file}",
          console = "integratedTerminal",
          pythonPath = function()
            return utils.get_python_path()
          end,
        },
      }
      
      dapui.setup()
      
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>ds", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    },
  },
}
