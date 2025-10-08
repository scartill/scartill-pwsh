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
        cwd = safir .. "/safir-fusion",
    }
    tab_fusion:set_title("fusion")

    local tab_sub, pane_sub = win:spawn_tab { workspace = ws }
    tab_sub:set_title("tracks")
    pane_sub:send_text("cd ../safir-hmi/backend\r\n")
    pane_sub:send_text("uv run hmi\r\n")

    local tab_frontend, pane_frontend = win:spawn_tab { workspace = ws }
    tab_frontend:set_title("frontend")
    pane_frontend:send_text("cd ../safir-hmi/frontend\r\n")
    pane_frontend:send_text("npm run dev\r\n")

    local tab_scripts, pane_scripts = win:spawn_tab { workspace = ws }
    tab_scripts:set_title("scripts")

    local tab_reqs, tabs_pane = win:spawn_tab { workspace = ws }
    tab_reqs:set_title("requirements")
    tab_fusion:activate()
  elseif ws == "embylocal" then
    local tab, pane, win = mux.spawn_window{
      workspace = ws,
      cwd = projects .. "/adsight/embyads-yolotrainer"
    }
    tab:set_title("eyt")
    local tab_pipelines, pane_pipelines = win:spawn_tab { workspace = ws }
    tab_pipelines:set_title("dagster")
    pane_pipelines:send_text("uv run dagster dev\r\n")

    local tab_dask, pane_dask = win:spawn_tab { workspace = ws }
    tab_dask:set_title("dask")
    pane_dask:send_text("uv run eyt dask scheduler\r\n")

    local tab_worker, pane_worker = win:spawn_tab { workspace = ws }
    tab_worker:set_title("worker")
    pane_worker:send_text(
      "uv run eyt --aws-profile embytest dask workers --environment dev --cluster-uri tcp://localhost:8786\r\n"
    )

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
}
