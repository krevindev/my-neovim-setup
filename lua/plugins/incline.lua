return {
  -- 1. Barbecue: Winbar breadcrumbs using nvim-navic
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    event = "LazyFile",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Show modified indicator next to filename
      show_modified = true,
      -- Exclude filetypes where winbar is unnecessary
      exclude_filetypes = { "netrw", "toggleterm", "lazy", "mason", "neo-tree", "snacks_dashboard" },
      -- Optional: Disable navic if you only want file paths, or keep true for LSP symbols
      show_navic = true,
    },
  },

  -- 2. Incline: Floating statuslines / filenames per split window
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 1 },
      },
      hide = {
        cursorline = true, -- Automatically hide when cursor overlaps
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = "#000000" } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          modified and " ●" or "",
          " ",
          guibg = "#24283b", -- Matches TokyoNight/dark themes well
        }
      end,
    },
  },
}
