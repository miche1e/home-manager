vim.g.mapleader = " "

-- write quit
vim.keymap.set("n", "<leader>w", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

-- get to the explorer
vim.keymap.set("n", "<leader>jk", vim.cmd.Ex)
vim.keymap.set("n", "<leader>kj", vim.cmd.Ex)

-- best remap ever
vim.keymap.set("x", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<cr>gv=gv")

-- return in normal mode
vim.keymap.set("i", "df", "<Esc>")
vim.keymap.set("i", "fd", "<Esc>")

-- drops the pasted over line into the void
vim.keymap.set("x", "<leader>p", "\"_dP")

-- how to use system clipboard (thx xclip <3)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- no swapfile, use undotree instead
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. "/.vim/undodir"

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- cursor padding
vim.opt.scrolloff = 16

vim.opt.signcolumn = "auto"

-- makes the plugins react faster (ms)
vim.opt.updatetime = 150

-- the line on the right ->
vim.opt.colorcolumn = "80"
-- let me use my mouse pls
vim.opt.mouse = "r"
