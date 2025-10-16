local telescope = require('telescope')
local actions_layout = require('telescope.actions.layout')

telescope.setup {
  defaults = {
    -- всё тяжёлое игнорим сразу в rg:
    vimgrep_arguments = {
      'rg',
      '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
      '--smart-case',
      '--max-columns=200',              
      '--max-filesize','1M',            
      '-g','!.git/*',
      '-g','!node_modules/*',
      '-g','!Library/*',                 
      '-g','!dist/*','-g','!build/*','-g','!Build/*',
      '-g','!bin/*','-g','!obj/*','-g','!target/*',
      '-g','!*.pdf','-g','!*.zip','-g','!*.mp4','-g','!*.mkv',
      '-g','!*.unity','-g','!*.asset','-g','!*.prefab','-g','!*.mat','-g','!*.map',
      '-g','!TextMesh*',
    },
    file_ignore_patterns = {},          
    color_devicons = false,             
    mappings = {
    },
  },
  pickers = {
    live_grep = {
      previewer = true,                
      only_sort_text = true,
    },
  },
  extensions = {
    fzf = { fuzzy=true, override_generic_sorter=true, override_file_sorter=true },
  },
}

telescope.load_extension('fzf')
telescope.load_extension('projects')
