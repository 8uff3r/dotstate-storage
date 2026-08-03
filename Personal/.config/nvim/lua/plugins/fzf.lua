return {
  "ibhagwan/fzf-lua",

  enabled = false,
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local actions = fzf.actions
    return {
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["ctrl-h"] = { actions.toggle_hidden },
        },
      },
    }
  end,
}
