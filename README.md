# hercula.nvim
Telescope EPUB picker with floating epub.nvim reader.

## **Lazy Installation**
```lua
  {
    'cx-pete/hercula.nvim',
    dependencies = {
      { 'CrystalDime/epub.nvim', opts = {}, lazy = true },
      { 'nvim-telescope/telescope.nvim', lazy = true },
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    opts = {},
    lazy = true,
  },
```
then, add Telescope extension:
```lua
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        extensions = {
          ['hercula'] = {                   -- These are the default options, they don't need to be set here
            dirs = {                        -- Directory(s) that we will search for EPUBs (table)
              vim.env.HOME,                 -- By default, search OS home directory (string)
            },
            scan = {                        
              hidden = false,               -- Include hidden files (bool)
              depth = 5,                    -- Search depth, recursive from dirs (int)
              search_pattern = '.epub',     -- Regex for which files will be added (string, table of strings, see plenary.scandir for more)
            },
          },
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'hercula')

```

Restart Neovim, then open the Hercula Telescope picker via:

- running the command `:Telescope hercula`
- calling `lua require('hercula').open()`
