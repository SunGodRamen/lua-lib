-- Configuration
local ROKU_IP = "192.168.50.190"
local GATEWAY = "192.168.50.1"
local MAC_ADDRESS = "BC:D7:D4:54:DE:E6"

-- Keymap
local keymap = {
    ["\27"] = "Home",           -- escape
    ["h"] = "Rev",
    ["s"] = "Fwd",
    [" "] = "Play",             -- space
    ["\t"] = "Select",          -- tab
    ["\27[A"] = "Up",           -- up arrow
    ["\27[B"] = "Down",         -- down arrow
    ["\27[D"] = "Left",         -- left arrow
    ["\27[C"] = "Right",        -- right arrow
    ["H"] = "Back",             -- shift+h
    ["r"] = "InstantReplay",
    ["\47"] = "Info",           -- shift+/
    ["\8"] = "Backspace",       -- backspace
    ["\13"] = "Enter"           -- enter
}

-- Functions
function sendKey(key)
    local command = "curl -d '' 'http://" .. ROKU_IP .. ":8060/keypress/" .. key .. "'"
    os.execute(command)
end

-- Main loop
print("Listening for key presses...")
while true do
    local c = io.read(1)
    if keymap[c] then
        sendKey(keymap[c])
    end
end
