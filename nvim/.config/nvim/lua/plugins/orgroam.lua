return {
  "chipsenkbeil/org-roam.nvim",
  tag = "0.2.0",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.7.0",
    },
  },
  config = function()
    require("org-roam").setup({
      directory = "~/org/roam",
      templates = {
        d = {
          description = "default",
          template = "%?",
          target = "%<%Y%m%d%H%M%S>-%[slug].org",
        },
        n = {
          description = "normal",
          template = "%?",
          target = "%[slug].org",
        },
      },
      -- optional
      org_files = {
        -- "~/another_org_dir",
        -- "~/some/folder/*.org",
        -- "~/a/single/org_file.org",
      },
    })
  end,
}
