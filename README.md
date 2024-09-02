# hercula.nvim
Telescope EPUB picker with floating epub.nvim reader

**Install via Lazy**
```
return {
  {
    'cx-pete/hercula.nvim',
    dependencies = {
      'CrystalDime/epub.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    opts = {
      -- idk
    },
    config = function()
      -- test
      pcall(require('telescope').load_extension, 'hercula')
    end,
  },
}
```

Open toggleterm-manager by either:

- running the command `:Telescope hercula`
- calling lua require('hercula').open()
