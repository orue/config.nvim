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

      -- C/C++ DAP configuration (using lldb)
      -- lldb-dap ships with the Xcode Command Line Tools but isn't on PATH
      local lldb_dap = vim.fn.exepath('lldb-dap')
      if lldb_dap == '' then
        lldb_dap = vim.trim(vim.fn.system({ 'xcrun', '--find', 'lldb-dap' }))
      end

      dap.adapters.lldb = {
        type = 'executable',
        command = lldb_dap,
        name = 'lldb'
      }

      dap.configurations.c = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
        },
      }

      -- C++ uses the same configuration as C
      dap.configurations.cpp = dap.configurations.c

      -- Go DAP configuration (using Delve)
      -- `dlv dap` speaks DAP over TCP, not stdio: nvim-dap starts it on a free port and connects
      local dlv = vim.fn.exepath('dlv')
      dap.adapters.go = {
        type = 'server',
        port = '${port}',
        executable = {
          command = dlv ~= '' and dlv or 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
        },
      }

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Attach',
          mode = 'local',
          request = 'attach',
          processId = require('dap.utils').pick_process,
          showLog = false,
        },
        {
          type = 'go',
          name = 'Debug',
          mode = 'debug',
          request = 'launch',
          program = '${fileDirname}',
          args = {},
        },
        {
          type = 'go',
          name = 'Debug Package',
          mode = 'debug',
          request = 'launch',
          program = '${workspaceFolder}',
          args = {},
        },
        {
          type = 'go',
          name = 'Debug Test',
          mode = 'test',
          request = 'launch',
          program = '${workspaceFolder}',
          args = {},
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
      { "<leader>do", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
      {
        "<leader>dB",
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(cond)
            if cond and cond ~= "" then require("dap").set_breakpoint(cond) end
          end)
        end,
        desc = "Conditional breakpoint",
      },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "x" }, desc = "Evaluate expression" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle debug panels" },
    },
  },
}
