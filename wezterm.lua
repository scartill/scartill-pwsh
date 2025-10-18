local wezterm = require 'wezterm'

local mux = wezterm.mux
local projects = os.getenv("USERPROFILE") .. '/projects'

wezterm.on("gui-startup", function(cmd)
  local ws = mux.get_active_workspace()
  local fvc = projects .. "/flyvercity"
  local safir = fvc .. "/safir"
  local adsight = projects .. "/adsight"

  if ws == "safir" then
    local tab_fusion, pane_fusion, win = mux.spawn_window {
        workspace = ws,
        cwd = safir,
    }
    tab_fusion:set_title("fusion")
    pane_fusion:send_text("cd safir-fusion\r")

    local tab_sub, pane_sub = win:spawn_tab { workspace = ws }
    tab_sub:set_title("tracks")
    pane_sub:send_text("cd safir-hmi/backend\r")
    pane_sub:send_text("uv run hmi\r")

    local tab_frontend, pane_frontend = win:spawn_tab { workspace = ws }
    tab_frontend:set_title("frontend")
    pane_frontend:send_text("cd safir-hmi/frontend\r")
    pane_frontend:send_text("npm run dev\r")

    local tab_scripts, pane_scripts = win:spawn_tab { workspace = ws }
    tab_scripts:set_title("scripts")
    pane_scripts:send_text("cd safir-fusion/scripts\r")

    local tab_reqs, pane_reqs = win:spawn_tab { workspace = ws }
    tab_reqs:set_title("requirements")
    pane_reqs:send_text("cd safir-requirements\r")
    tab_fusion:activate()
  elseif ws == "embylocal" then
    local tab, pane, win = mux.spawn_window{
      workspace = ws,
      cwd = adsight .. "/embyads-yolotrainer"
    }
    tab:set_title("eyt")
    local tab_pipelines, pane_pipelines = win:spawn_tab { workspace = ws }
    tab_pipelines:set_title("dagster")
    pane_pipelines:send_text("uv run dagster dev\r")

    local tab_dask, pane_dask = win:spawn_tab { workspace = ws }
    tab_dask:set_title("dask")
    pane_dask:send_text("uv run eyt dask scheduler\r")

    local tab_worker, pane_worker = win:spawn_tab { workspace = ws }
    tab_worker:set_title("worker")
    pane_worker:send_text(
      "uv run eyt --aws-profile embytest dask workers --environment dev --cluster-uri tcp://localhost:8786\r"
    )

    tab:activate()
  elseif ws == "tapgame" then
    local tab, pane_sam, win = mux.spawn_window{
      workspace = ws,
      cwd = adsight
    }
    tab:set_title("tapgame")
    pane_sam:send_text("cd tapgame\r")
    pane_sam:send_text("./devenv.ps1\r")
    pane_sam:send_text("cd sam\r")

    local tab_test, pane_test = win:spawn_tab { workspace = ws }
    tab_test:set_title("test")
    pane_test:send_text("cd tapgame\r")
    pane_test:send_text("./devenv.ps1\r")
    pane_test:send_text("cd sam/test\r")

    local tab_tools, pane_tools = win:spawn_tab { workspace = ws }
    tab_tools:set_title("tools")
    pane_tools:send_text("cd adstools\r")
    tab:activate()
  elseif ws == "wsl" then
    local tab, pane, win = mux.spawn_window{
      workspace = ws,
      cwd = projects,
      args = { "wsl.exe", }
    }
  else
    local tab, pane, win = mux.spawn_window{
      workspace = ws,
    }
  end
end)

return {
    default_prog = { "pwsh.exe" },
    default_cwd = projects,
    color_scheme = "Horizon Dark (base16)",
    font = wezterm.font_with_fallback({"MesloLGM Nerd Font", "Consolas" }),
    font_size = 12,
    window_frame = { font_size = 14.0, },
    default_gui_startup_args = { "--maximize" },
    ssh_backend = "Ssh2"
}
