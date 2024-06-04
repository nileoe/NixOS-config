local set = vim.keymap.set
-- vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
-- vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
-- vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
-- vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- ################### 
set("n", "<leader>e", ":NvimTreeToggle<CR>")
set("n", "<leader>E", ":Ex<CR>")
set("n", "<leader>sep", "o####################################  <C-c>hhyiw$pbhi")
set("n", "<leader>-sep", "o-- ####################################  <C-c>hhyiw$pbhi")
set("n", "<leader>z", ":ZenMode<CR>");

set({"n", "v"}, "J", "myJ`y", {silent=true}) -- don't move cursor when calling J
