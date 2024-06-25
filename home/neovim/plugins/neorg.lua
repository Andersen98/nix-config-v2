require("neorg").setup {
   load = {
     ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.map("norg",
            "n",keybinds.leader .. "l",
            "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<CR>")
          end,
        }
      },
     ["core.defaults"] = {},
     ["core.concealer"] = {},
     ["core.dirman"] = {
        config = {
          workspaces = {
            wiki = "~/neorg/wiki",
            playground = "~/neorg/playground",
          },
          default_workspace = "playground",
        },
      }
   }
 }
