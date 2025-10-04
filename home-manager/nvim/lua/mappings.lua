local map = vim.keymap.set

-- Centre screen when jumping
map("n"    ,"n"            ,"nzz"                        ,{ desc = "Next search result (centred)"     })
map("n"    ,"N"            ,"Nzz"                        ,{ desc = "Previous search result (centred)" })
map("n"    ,"<C-u>"        ,"<C-u>zz"                    ,{ desc = "Half page up (centred)"           })
map("n"    ,"<C-d>"        ,"<C-d>zz"                    ,{ desc = "Half page down (centred)"         })

-- nvim-tree
map("n"    ,"<C-n>"        ,"<cmd>NvimTreeToggle<cr>"    ,{ desc = "Toggle Nvim Tree"                 })
map("n"    ,"<leader>e"    ,"<cmd>NvimTreeFocus<cr>"     ,{ desc = "Focus Nvim Tree"                  })

-- harpoon
local harpoon = require("harpoon")
map("n"    ,"<leader>h"    ,function() harpoon.ui:toggle_quick_menu(harpoon:list())                 end)
map("n"    ,"<leader>a"    ,function() harpoon:list():add()                                         end)

map("n"    ,"<C-h>"        ,function() harpoon:list():select(4)                                     end)
map("n"    ,"<C-j>"        ,function() harpoon:list():select(1)                                     end)
map("n"    ,"<C-k>"        ,function() harpoon:list():select(2)                                     end)
map("n"    ,"<C-l>"        ,function() harpoon:list():select(3)                                     end)

-- telescope
local telescope = require("telescope.builtin")
map("n"    ,"<leader>ff"   ,telescope.find_files         ,{ desc = "Telescope find files"             })
map("n"    ,"<leader>fw"   ,telescope.live_grep          ,{ desc = "Telescope live grep"              })
map("n"    ,"<leader>fb"   ,telescope.buffers            ,{ desc = "Telescope buffers"                })

map("n"    ,"<leader>w"    ,"<cmd>set wrap!<cr>"         ,{ desc = "Toggle line wrapping"             })

