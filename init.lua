-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.rtp:append("C:/Users/Kyle Revin/AppData/Local/nvim-data/site")

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function ()
    local choice = vim.fn.confirm("Do you want to quit Neovim?", "&Yes\n&NO", 2)
    if choice ~= 1 then
      vim.cmd("cclose") -- Prevents quitting if you choose 'No'
    end
  end,
})


-- Disable accidental uppercase quit shortcuts
vim.keymap.set("n", "ZZ", "<Nop>")
vim.keymap.set("n", "ZQ", "<Nop>")

