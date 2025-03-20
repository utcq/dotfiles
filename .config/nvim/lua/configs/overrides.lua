local M = {}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-y>",
      next = "<C-n>",
      prev = "<C-p>",
    },
  },
}

return M
