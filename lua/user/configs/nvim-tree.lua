local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

local icons = require("user.icons")
local border = require("user.borders").style

local start_telescope = function(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode]({ cwd = basedir })
end

local telescope_find_files = function(_)
  start_telescope("find_files")
end

local telescope_live_grep = function(_)
  start_telescope("live_grep")
end

nvim_tree.setup({
  auto_reload_on_write = false,
  sync_root_with_cwd = true, -- REQUIRES: project.nvim
  respect_buf_cwd = true, -- REQUIRES: project.nvim
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  hijack_directories = {
    enable = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = icons.diagnostics.BoldHint,
      info = icons.diagnostics.BoldInfo,
      warning = icons.diagnostics.BoldWarning,
      error = icons.diagnostics.BoldError,
    },
  },
  view = {
    width = 30,
    hide_root_folder = false,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
        { key = "h", action = "close_node" },
        { key = "v", action = "vsplit" },
        { key = "C", action = "cd" },
        { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
        { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
      },
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    float = {
      open_win_config = {
        border = border,
      },
    },
  },
  renderer = {
    add_trailing = true,
    highlight_git = true,
    group_empty = false,
    root_folder_modifier = ":t",
    icons = {
      webdev_colors = true,
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
        default = icons.ui.Text,
        symlink = icons.ui.FileSymlink,
        git = {
          unstaged = icons.git.FileUnstaged,
          staged = icons.git.FileStaged,
          unmerged = icons.git.FileUnmerged,
          renamed = icons.git.FileRenamed,
          untracked = icons.git.FileUntracked,
          deleted = icons.git.FileDeleted,
          ignored = icons.git.FileIgnored,
        },
        folder = {
          arrow_closed = icons.ui.ChevronShortRight,
          arrow_open = icons.ui.ChevronShortDown,
          default = icons.ui.Folder,
          empty = icons.ui.EmptyFolder,
          empty_open = icons.ui.EmptyFolderOpen,
          open = icons.ui.FolderOpen,
          symlink = icons.ui.FolderSymlink,
          symlink_open = icons.ui.FolderSymlink,
        },
      },
    },
  },
  actions = {
    file_popup = {
      open_win_config = {
        border = border,
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { "node_modules", "\\.cache", "^\\.git$" },
    exclude = {},
  },
})
