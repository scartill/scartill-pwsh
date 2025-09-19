local wezterm = require 'wezterm'

local mux = wezterm.mux
local projects = os.getenv("USERPROFILE") .. '/projects'

wezterm.on("gui-startup", function(cmd)
  local ws = mux.get_active_workspace()
  local fvc = projects .. "/flyvercity"
  local safir = fvc .. "/safir"

  if ws == "safir" then
    local tab_fusion, pane_fusion, win = mux.spawn_window {
        workspace = ws,
        cwd = safir .. "/safir-fusion",
        args = { "pwsh.exe" },
    }
    tab_fusion:set_title("fusion")
    local tab_sub, pane_sub = win:spawn_tab { workspace = ws }
    tab_sub:set_title("tracks")
    pane_sub:send_text("cd scripts\r\n")
    pane_sub:send_text("./SubscribeTo-Tracks.ps1\r\n")
    local tab_health, pane_health = win:spawn_tab { workspace = ws }
    tab_health:set_title("health")
    pane_health:send_text("cd scripts\r\n")
    pane_health:send_text("./SubscribeTo-Health.ps1\r\n")
    local tab_scripts, pane_scripts = win:spawn_tab { workspace = ws }
    tab_scripts:set_title("scripts")
    local tab_reqs, tabs_pane = win:spawn_tab { workspace = ws }
    tab_reqs:set_title("requirements")

    tab_fusion:activate()
  else
    local tab, pane, win = mux.spawn_window{
      workspace = ws,
      args = { "pwsh.exe", },
    }
  end
end)

return {
    default_prog = { "pwsh.exe" },
    default_cwd = projects,

	color_scheme = "Nord",
	font = wezterm.font_with_fallback({"MesloLGM Nerd Font", "Consolas" }),
	font_size = 12,
    window_frame = { font_size = 14.0, },
    window_decorations = "TITLE",
    default_gui_startup_args = { "--maximize" },
}
