-- ~/.config/nvim/lua/plugins/orgmode.lua
return {
  "nvim-orgmode/orgmode",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-orgmode/telescope-orgmode.nvim",
    "nvim-orgmode/org-bullets.nvim",
    "Saghen/blink.cmp",
  },
  event = "VeryLazy",
  config = function(_, opts)
    local orgmode = require("orgmode")
    require("headlines").setup()
    require("org-bullets").setup()
    require("blink.cmp").setup({
      sources = {
        per_filetype = {
          org = { "orgmode" },
        },
        providers = {
          orgmode = {
            name = "Orgmode",
            module = "orgmode.org.autocompletion.blink",
            fallbacks = { "buffer" },
          },
        },
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "org",
      callback = function(event)
        vim.keymap.set("n", "<leader>or", function()
          require("telescope").extensions.orgmode.refile_heading()
        end, {
          buffer = event.buf,
          -- noremap = true,
          silent = true,
          nowait = true,
          desc = "Org: Refile (Telescope)",
        })
      end,
    })
    require("telescope").setup({})
    require("telescope").load_extension("orgmode")
    vim.keymap.set(
      "n",
      "<leader>or",
      require("telescope").extensions.orgmode.refile_heading,
      { desc = "refile (telescope)" }
    )
    vim.keymap.set(
      "n",
      "<leader>of",
      require("telescope").extensions.orgmode.search_headings,
      { desc = "search headings" }
    )
    vim.keymap.set(
      "n",
      "<leader>oil",
      require("telescope").extensions.orgmode.insert_link,
      { noremap = true, desc = "insert link" }
    )
    -- Your todo keywords (adjust as needed)
    local todo_keywords = {
      "TODO(t)",
      "PROG(p)",
      "READ(r)",
      "|",
      "DONE(d)",
      "CANCELLED(c)",
      "HOLD(h)",
    }
    -- Build list of keywords without separators
    local keywords_only = vim.tbl_filter(
      function(kw)
        return kw ~= "|"
      end,
      vim.tbl_map(function(kw)
        return kw:match("([%u-]+)") or kw
      end, todo_keywords)
    )

    local function file_has_todo(file)
      local lines = vim.fn.readfile(file)
      for _, line in ipairs(lines) do
        -- Check each keyword with simple pattern matching
        for _, keyword in ipairs(keywords_only) do
          if
            string.match(line, "^%*+%s+" .. keyword .. "%s") ~= nil
            or string.match(line, "^%*+%s+" .. keyword .. "$") ~= nil
          then
            return true
          end
        end
      end
      return false
    end

    -- Debug function to check pattern
    function _G.OrgDebugPattern()
      print("Keywords: " .. table.concat(keywords_only, ", "))
      local test_lines = {
        "* TODO Test task",
        "** TODO Another task",
        "* NEXT Do something",
        "*** DONE Finished",
        "* TODO",
      }
      for _, line in ipairs(test_lines) do
        local found = false
        for _, keyword in ipairs(keywords_only) do
          if
            string.match(line, "^%*+%s+" .. keyword .. "%s") ~= nil
            or string.match(line, "^%*+%s+" .. keyword .. "$") ~= nil
          then
            found = keyword
            break
          end
        end
        print('"' .. line .. '" -> ' .. (found or "NO MATCH"))
      end
    end

    local function init_agenda_files()
      -- Use ** for recursive globbing
      local files = vim.fn.globpath("~/org", "**/*.org", false, true)
      local agenda = {}
      for _, f in ipairs(files) do
        if file_has_todo(f) then
          table.insert(agenda, f)
        end
      end
      return agenda
    end
    -- Create a mutable table for agenda files
    local agenda_files_cache = init_agenda_files()

    -- Expose cache globally for debugging
    _G.agenda_files_cache = agenda_files_cache

    -- define globally so you can call it from anywhere
    function _G.OrgRefreshAgendaFiles()
      -- clear the existing table
      for i = #agenda_files_cache, 1, -1 do
        table.remove(agenda_files_cache, i)
      end
      -- repopulate with fresh scan - USE RECURSIVE GLOB
      local org_dir = vim.fn.expand("~") .. "/org"
      local files = vim.fn.globpath(org_dir, "**/*.org", true, true)

      print("DEBUG: Found " .. #files .. " .org files total")

      for _, f in ipairs(files) do
        print("DEBUG: Checking file: " .. f)
        if file_has_todo(f) then
          table.insert(agenda_files_cache, f)
          print("DEBUG: Added to agenda: " .. f)
        end
      end
      print("Org agenda files refreshed: " .. #agenda_files_cache .. " files")
    end
    vim.api.nvim_create_user_command("OrgRefreshAgendaFiles", function()
      _G.OrgRefreshAgendaFiles()
    end, {})
    -- Setup orgmode
    orgmode.setup(vim.tbl_extend("force", opts or {}, {
      org_agenda_files = "~/org/roam/**/*",
      -- org_agenda_files = agenda_files_cache,
      org_default_notes_file = "~/org/roam/refile.org",
      org_todo_keywords = todo_keywords,
      calendar_week_start_day = 1,
      org_hide_leading_stars = true,
      org_indent_mode = "indent",
      org_startup_folded = "overview",
      org_id_link_to_org_use_id = true,
      mappings = {
        org_refile = false,
      },
    }))
    -- Autocmd to update the cache on save
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.org",
      callback = function(args)
        local file = vim.fn.fnamemodify(args.file, ":p")
        local has_todo = file_has_todo(file)
        local idx
        for i, f in ipairs(agenda_files_cache) do
          if f == file then
            idx = i
            break
          end
        end
        if has_todo and not idx then
          table.insert(agenda_files_cache, file)
        elseif not has_todo and idx then
          table.remove(agenda_files_cache, idx)
        end
      end,
    })
  end,
}
