local harpoon = require("harpoon")

-- REQUIRED
-- harpoon:setup() -- called in plugins.lua
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>A", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<A-u>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-i>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-o>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-p>", function() harpoon:list():select(4) end)

-- vim.keymap.set("n", "<A-u>", "oAlt + h baby<C-c>")
-- vim.keymap.set("n", "<A-i>", "oAlt + j baby<C-c>")
-- vim.keymap.set("n", "<A-o>", "oAlt + k baby<C-c>")
-- vim.keymap.set("n", "<A-p>", "oAlt + l baby<C-c>")

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<A-S-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<A-S-n>", function() harpoon:list():next() end)
