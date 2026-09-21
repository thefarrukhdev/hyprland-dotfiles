local config_dir = os.getenv("HOME") .. "/.config/hypr/"
package.path = package.path .. ";" .. config_dir .. "?.lua;" .. config_dir .. "conf/?.lua"

-- Parse pywal colors directly from json
local function load_pywal_colors(filepath)
    local f = io.open(filepath, "r")
    if not f then return false end
    local content = f:read("*a")
    f:close()
    
    local loaded = false
    -- Parse simple hex strings out of json natively
    for key, hex in content:gmatch('"([^"]+)":%s*"#(%x+)"') do
        if #hex == 6 then
            _G[key] = "rgba(" .. hex .. "ff)"
            loaded = true
        end
    end
    return loaded
end

local has_wal = load_pywal_colors(os.getenv("HOME") .. "/.cache/wal/colors.json")

-- Fallbacks if variables needed by settings aren't in pywal or no wal cache
_G.primary = _G.color10 or "rgba(b1c5ffff)"
_G.on_primary = _G.color0 or "rgba(172e60ff)"
_G.background = _G.color0 or "rgba(121318ff)"

require("conf.monitors")
require("conf.env")
require("conf.input")
require("conf.settings")
require("conf.rules")
require("conf.keybinds")
require("conf.autostart")

-- Custom configuration (non-blocking)
pcall(require, "custom")
