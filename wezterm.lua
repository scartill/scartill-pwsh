local wezterm = require 'wezterm'

local mux = wezterm.mux
local projects = os.getenv("USERPROFILE") .. '/projects'

wezterm.on("gui-startup", function(cmd)
  local ws = mux.get_active_workspace()
  local fvc = projects .. "/flyvercity"
  local safir = fvc .. "/safir"

  if ws == "safir" then
    local tab_fusion, pane1, win = mux.spawn_window {
        workspace = ws,
        cwd = safir .. "/safir-fusion",
        args = { "pwsh.exe" },
    }
    tab_fusion:set_title("fusion")

    local tab_sub, pane_sub = win:spawn_tab {
        workspace = ws,
        cwd = "scripts",
        args = {"pwsh.exe" },
    }
    tab_sub:set_title("tracks")
    -- pane_sub:send_text("./SubsribeTo-Tracks.ps1\n")

    local tab3, pane3 = win:spawn_tab {
        workspace = ws,
        cwd = safir .. "/safir-fusion/scripts",
        args = { "pwsh.exe" },
    }
    tab3:set_title("health")

    local tab4, pane4 = win:spawn_tab {
        workspace = ws,
        cwd = safir .. "/safir-fusion/scripts",
        args = { "pwsh.exe" },
    }
    tab4:set_title("scripts")

    local tab5, pane5 = win:spawn_tab {
        workspace = ws,
        cwd = safir .. "/safir-requirements",
        args = { "pwsh.exe" },
    }
    tab5:set_title("requirements")

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
    window_decorations = "RESIZE",
    default_gui_startup_args = { "--maximize" },
}
