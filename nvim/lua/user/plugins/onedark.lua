return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- onedark
    -- onelight
    -- onedark_vivid
    -- onedark_dark
    vim.cmd("colorscheme " .. vim.env.COLORSCHEME)
  end
}
