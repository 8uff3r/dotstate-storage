local function winnr(direction)
  return vim.api.nvim_call_function("winnr", { direction })
end

local function is_nvim_border(border)
  return winnr() == winnr("1" .. border)
end

local function wincmd(direction, count)
  return vim.api.nvim_command((count or 1) .. "wincmd " .. direction)
end
local function to(direction)
  local wez = require("wezterm")
  local convert = { Up = "k", Down = "j", Right = "l", Left = "h" }
  local vd = convert[direction]

  local is_in_nvim_border = is_nvim_border(vd)
  if is_in_nvim_border then
    wez.switch_pane.direction(direction)
  else
    wincmd(vd)
  end
end

return {
  "willothy/wezterm.nvim",
  enabled = true,
  keys = {
    {
      "<A-CR>",
      function()
        local wez = require("wezterm")
        wez.split_pane.vertical({ cwd = vim.fn.getcwd(), percent = 30 })
      end,
    },
    {
      "<A-S-CR>",
      function()
        local wez = require("wezterm")
        wez.split_pane.horizontal({ cwd = vim.fn.getcwd(), percent = 30 })
      end,
    },
    {
      "<C-J>",
      function()
        to("Down")
      end,
    },
    {
      "<C-K>",
      function()
        to("Up")
      end,
    },
    {
      "<C-H>",
      function()
        to("Left")
      end,
    },
    {
      "<C-L>",
      function()
        to("Right")
      end,
    },
  },
  opts = {},
}
