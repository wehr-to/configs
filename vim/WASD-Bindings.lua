-- lua/wasd.lua
-- Prototype WASD-first navigation for Neovim
-- Scope: normal/visual/operator-pending; window + scrolling quality-of-life
-- Intent: Replace hjkl with wasd while keeping a sane path to original motions.

local map = vim.keymap.set

-- sensible defaults
vim.g.mapleader = " "
local silent   = { silent = true }
local nore_s   = { noremap = true, silent = true }
local remap_s  = { remap = true,  silent = true }

-- 1) Core movement: hjkl > wasd
--    Use {remap=true} so single-letter motions compose naturally (e.g., '3w' > '3k').
--    Modes: normal, visual, operator-pending.
local mv_modes = { "n", "v", "o" }
map(mv_modes, "a", "h", remap_s) -- left
map(mv_modes, "s", "j", remap_s) -- down
map(mv_modes, "w", "k", remap_s) -- up
map(mv_modes, "d", "l", remap_s) -- right

-- 2) Window navigation: <C-w> + wasd
map("n", "<C-w>a", "<C-w>h", nore_s)
map("n", "<C-w>s", "<C-w>j", nore_s)
map("n", "<C-w>w", "<C-w>k", nore_s)
map("n", "<C-w>d", "<C-w>l", nore_s)

-- Optional: direct pane hops on Ctrl+{h/j/k/l} → Ctrl+{a/s/w/d}
map("n", "<C-a>", "<C-w>h", nore_s)
map("n", "<C-s>", "<C-w>j", nore_s)
map("n", "<C-w>", "<C-w>k", nore_s) -- NOTE: <C-w> alone is a prefix; avoid stealing it wholesale.
map("n", "<C-d>", "<C-w>l", nore_s)

-- 3) Scrolling ergonomics (optional)
-- Alt+W / Alt+S for half-page up/down; Alt+A / Alt+D for left/right screen scroll
map("n", "<A-w>", "<C-u>", nore_s)   -- half-page up
map("n", "<A-s>", "<C-d>", nore_s)   -- half-page down
map("n", "<A-a>", "zh",    nore_s)   -- view left
map("n", "<A-d>", "zl",    nore_s)   -- view right

-- 4) “Escape hatches” to original word motions (because 'w' is now 'up')
-- Use :normal! to bypass mappings entirely.
local function normal_bang(keys) return function() vim.cmd.normal { keys, bang = true } end

-- Leader-based access to canonical word/nav motions:
map(mv_modes, "<leader>w", normal_bang("w"), nore_s)   -- word forward
map(mv_modes, "<leader>b", normal_bang("b"), nore_s)   -- word back
map(mv_modes, "<leader>e", normal_bang("e"), nore_s)   -- to end of word
map(mv_modes, "<leader>ge", normal_bang("ge"), nore_s) -- to end of previous word

-- You can similarly preserve other single-letter defaults that clash with your scheme:
-- map(mv_modes, "<leader>h", normal_bang("h"), nore_s)
-- map(mv_modes, "<leader>j", normal_bang("j"), nore_s)
-- map(mv_modes, "<leader>k", normal_bang("k"), nore_s)
-- map(mv_modes, "<leader>l", normal_bang("l"), nore_s)

-- 5) Visual line vs. logical line preference (optional)
-- If you prefer wrapped-line movement, uncomment these to mirror default "gk"/"gj" behavior:
-- map(mv_modes, "w", "gk", remap_s)
-- map(mv_modes, "s", "gj", remap_s)

-- 6) Terminal mode quick-escape and window hops (quality-of-life)
map("t", "<Esc>", [[<C-\><C-n>]], silent)
map("t", "<C-a>", [[<C-\><C-n><C-w>h]], silent)
map("t", "<C-s>", [[<C-\><C-n><C-w>j]], silent)
map("t", "<C-w>", [[<C-\><C-n><C-w>k]], silent)
map("t", "<C-d>", [[<C-\><C-n><C-w>l]], silent)

-- 7) (Optional) Nudge yourself to adopt WASD by disabling arrow keys
-- map({"n","v","i"}, "<Up>",    "<Nop>", nore_s)
-- map({"n","v","i"}, "<Down>",  "<Nop>", nore_s)
-- map({"n","v","i"}, "<Left>",  "<Nop>", nore_s)
-- map({"n","v","i"}, "<Right>", "<Nop>", nore_s)

