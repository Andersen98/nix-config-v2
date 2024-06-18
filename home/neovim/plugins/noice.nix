
{pkgs,lib,...}:
let
  fromGitHub =
    {
      rev,
      ref,
      repo,
    }:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
        rev = rev;
      };
    };
in
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    nui-nvim
    nvim-notify
    { plugin = fromGitHub {
        rev = "8bccd26e912a439f45829bd1fe83e77c4dc263ad";
        ref = "main";
        repo = "folke/noice.nvim";
        };
      config = ''
      require("noice").setup({
          lsp = {
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
               ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
               ["vim.lsp.util.stylize_markdown"] = true,
              -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
            },
          },
          -- you can enable a preset for easier configuration
          presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = false, -- add a border to hover docs and signature help
          },
        })
      '';
      type = "lua";
    }
  ];
}
