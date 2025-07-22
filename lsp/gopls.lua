return {
  settings = {
    gopls = {
      env = {
        -- Fixes the "watch.watch: ENOENT: no such file or directory" error
        -- caused by a go.work file being present in a project.
        GOWORK = "off",
      },
    },
  },
}
