require("neorg").setup {
   load = {
     ["core.keybinds"] = {
        config = {
          hook = function(keybinds)
            keybinds.map("norg",
            "n",keybinds.leader .. "lc",
            "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<CR>")
            keybinds.map("all",
            "n",keybinds.leader .. "nwd",
            "<cmd>Neorg workspace default<CR>")
          end,
        }
      },
    ["core.esupports.indent"] = {
      config = {
        format_on_enter = false,
        format_on_escape = false,
      },
    },
     ["core.defaults"] = {},
     ["core.concealer"] = {},
     ["core.summary"] = {},
     ["core.text-objects"] = {
        config = {
          hook = function(keybinds)
              -- Binds to move items up or down
              keybinds.remap_event("norg", "n", "<A-k>", "core.text-objects.item_up")
              keybinds.remap_event("norg", "n", "<A-j>", "core.text-objects.item_down")

              -- text objects, these binds are available as `vaH` to "visual select around a header" or
              -- `diH` to "delete inside a header"
              keybinds.remap_event("norg", { "o", "x" }, "iH", "core.text-objects.textobject.heading.inner")
              keybinds.remap_event("norg", { "o", "x" }, "aH", "core.text-objects.textobject.heading.outer")
          end,

        },
     },
     ["core.dirman"] = {
        config = {
          workspaces = {
            wiki = "~/neorg/wiki",
            playground = "~/neorg/playground",
          },
          default_workspace = "playground",
          open_last_workspace = "default",
        },
      },
   },
 }
