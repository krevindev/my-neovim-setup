-- ====================================================================
-- 1. LAZY.NVIM & LAZYVIM BOOTSTRAPPER
-- ====================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Require your main lazy configuration initialization
require("config.lazy")

-- ====================================================================
-- 2. CUSTOM SITE RUNTIME PATH ADDITION
-- ====================================================================
vim.opt.rtp:append("C:/Users/Kyle Revin/AppData/Local/nvim-data/site")

-- ====================================================================
-- 3. DISABLE ACCIDENTAL UPPERCASE SHORTCUTS
-- ====================================================================
vim.keymap.set("n", "ZZ", "<Nop>", { desc = "Disable accidental uppercase ZZ" })
vim.keymap.set("n", "ZQ", "<Nop>", { desc = "Disable accidental uppercase ZQ" })

-- ====================================================================
-- 4. BULLETPROOF QUIT PROMPTS (Intercepts at command / shortcut level)
-- ====================================================================

-- Function wrapper to prompt before executing a Vim command
local function confirm_action(prompt, command)
  local choice = vim.fn.confirm(prompt, "&Yes\n&No", 2)
  if choice == 1 then
    vim.cmd(command)
  end
end

-- Custom user command ':Q' and ':QA' to quit safely with a prompt
vim.api.nvim_create_user_command("Q", function()
  confirm_action("Do you want to quit Neovim?", "quit")
end, {})

vim.api.nvim_create_user_command("QA", function()
  confirm_action("Do you want to exit all of Neovim?", "qa")
end, {})

-- Command abbreviation so typing lower-case ':q' or ':qa' safely maps to our confirmation functions
vim.cmd("cabbrev q Q")
vim.cmd("cabbrev qa QA")

-- Intercept standard split close shortcuts to ask first
vim.keymap.set("n", "<C-w>q", function()
  confirm_action("Do you want to close this split screen?", "close")
end, { desc = "Confirm before closing split window" })

vim.keymap.set("n", "<C-w>c", function()
  confirm_action("Do you want to close this split screen?", "close")
end, { desc = "Confirm before closing split window" })

-- Custom user command ':Tabclose' to confirm before closing a tabpage
vim.api.nvim_create_user_command("Tabclose", function()
  confirm_action("Do you want to close this tab?", "tabclose")
end, {})

-- Shortcut command abbreviation so typing ':tc' or ':tabc' works safely
vim.cmd("cabbrev tabclose Tabclose")
vim.cmd("cabbrev tabc Tabclose")
