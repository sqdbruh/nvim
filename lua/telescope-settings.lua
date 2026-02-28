print("telescope loading...")
local telescope = require('telescope')
local actions_layout = require('telescope.actions.layout')

telescope.setup {
  defaults = {
file_ignore_patterns = {
  "^Assets/Packages/",
  "^Library/",
  "^Logs/",
  "^Temp/",
  "^Build/",
  "^Builds/",
  "^AndroidBuild/",
  "^iOSBuild/",
  "^UserSettings/",
  "^Obj/",
  "^DerivedData/",
  "^%.vs/",
  "^%.vscode/",
  "^%.idea/",
  "^%.fleet/",
  "%.meta$",
  "%.asset$",
  -- тяжёлые ассеты (если хочешь “кодовый” find_files):
  "%.fbx$", "%.obj$", "%.blend%d*$",
  "%.tga$", "%.exr$", "%.png$", "%.jpe?g$", "%.psd$",
  "%.wav$", "%.mp3$", "%.ogg$", "%.aac$",
  "%.mov$", "%.avi$",
  -- системные мелочи:
  "%.DS_Store$", "Thumbs%.db$",
  -- архивы/пакеты:
  "%.zip$", "%.unitypackage$", "%.apk$", "%.aab$", "%.ipa$", "%.keystore$",
  -- Xcode проекты:
  "%.xcworkspace$", "%.xcodeproj$",
},

    vimgrep_arguments = {
        'rg',
        '--hidden',
        '--color=never', '--no-heading', '--with-filename', '--line-number', '--column',
        '--smart-case',
        '--max-columns=200',
        '--max-filesize','1M',
      -- Игнор Unity-папок:
      '-g','!Library/**',
      '-g','!Logs/**',
      '-g','!Assets/Packages/**',
      -- Игнор мусора:
      '-g','!.git/**',
      '-g','!node_modules/**',
      '-g','!dist/**','-g','!build/**','-g','!Build/**',
      '-g','!bin/**','-g','!obj/**','-g','!target/**',
      -- Игнор бинарников, видео, Unity-ресурсов и .meta:
      '-g','!*.pdf','-g','!*.zip','-g','!*.mp4','-g','!*.mkv',
      '-g','!*.unity','-g','!*.asset','-g','!*.prefab','-g','!*.mat','-g','!*.map',
      '-g','!TextMesh*',
      '-g','!*.meta',  -- <— вот это ключевая строка

      -- ключевые папки:
      '-g','!Temp/**',
      '-g','!Build/**','-g','!Builds/**','-g','!AndroidBuild/**','-g','!iOSBuild/**',
      '-g','!UserSettings/**',
      '-g','!Obj/**','-g','!DerivedData/**',
      '-g','!.vs/**','-g','!.vscode/**','-g','!.idea/**','-g','!.fleet/**',

      -- только вложенная папка в Assets:
      '-g','!Assets/Packages/**',

      -- системные файлы/архивы/пакеты:
      '-g','!*.meta',
      '-g','!.DS_Store',
      '-g','!Thumbs.db',
      '-g','!*.zip','-g','!*.unitypackage',
      '-g','!*.apk','-g','!*.aab','-g','!*.ipa','-g','!*.keystore',
      '-g','!*.xcworkspace','-g','!*.xcodeproj',

      -- тяжёлые ассеты (если не ищешь по ним текст):
      '-g','!*.fbx','-g','!*.obj','-g','!*.blend*',
      '-g','!*.tga','-g','!*.exr','-g','!*.png','-g','!*.jpg','-g','!*.jpeg','-g','!*.psd',
      '-g','!*.wav','-g','!*.mp3','-g','!*.ogg','-g','!*.aac',
      '-g','!*.mov','-g','!*.avi',
-- (остальные твои игноры оставь как есть)
    },

    color_devicons = false,
    mappings = {},
  },

  pickers = {

    live_grep = {
      previewer = true,
      only_sort_text = true,
    },
    -- (опционально, если используешь fd)
    -- find_files = {
    --   find_command = {
    --     'fd', '--type', 'f', '--hidden', '--follow',
    --     '--exclude', '.git',
    --     '--exclude', 'Library',
    --     '--exclude', 'Logs',
    --     '--exclude', 'Temp',
    --     '--exclude', 'Assets/Packages',
    --     '--exclude', '*.meta',
    --   },
    -- },
  },

  extensions = {
    fzf = { fuzzy=true, override_generic_sorter=true, override_file_sorter=true },
  },
}

telescope.load_extension('fzf')
telescope.load_extension('projects')
