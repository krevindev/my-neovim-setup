return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional for icons
    },
    opts = {
      -- Forces it to behave like a clean top tab instead of displaying deep paths
      show_modified = false,
      show_dirname = false, -- turns off directory pathing completely
      show_basename = true, -- shows just the filename
      context_follow_icon = false,
      lead_custom_section = function() return " " end, -- adds padding to the left edge

      -- Custom filter to keep it off noice.nvim popups and utility bars
      exclude_filetypes = {
        "toggleterm",
        "Neo-tree",
        "noice",
        "notify",
        "prompt",
        "TelescopePrompt",
      },
    },
  }
}
