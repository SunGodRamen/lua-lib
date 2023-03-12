local json = require("dkjson")
local http = require("socket.http")
local ltn12 = require("ltn12")

local ROKU_IP = "192.168.50.190"
local APPS = {
  {name = "plex", id = "13535"},
  {name = "youtube", id = "837"},
  {name = "crunchyroll", id = "2285"},
}

function launch_app(app_id)
  local url = "http://" .. ROKU_IP .. ":8060/launch/" .. app_id
  local response_body = {}
  local res, code, response_headers = http.request{
    url = url,
    method = "POST",
    headers = {
      ["Content-Type"] = "application/json",
      ["Content-Length"] = "0"
    },
    source = ltn12.source.string(""),
    sink = ltn12.sink.table(response_body)
  }
  if code == 200 then
    print("Successfully launched app")
  else
    print("Error launching app: " .. code)
  end
end

function list_apps()
  print("Please select an app to launch:")
  for i, app in ipairs(APPS) do
    print(i .. ". " .. app.name)
  end
end

function select_app(app_name)
  if app_name then
    for _, app in ipairs(APPS) do
      if app.name:lower() == app_name:lower() then
        return app.id
      end
    end
    print("Invalid app name")
    return
  else
    list_apps()
    local input = io.read()
    local app_id = tonumber(input)
    if app_id then
      if APPS[app_id] then
        return APPS[app_id].id
      else
        print("Invalid selection")
        return select_app()
      end
    else
      for _, app in ipairs(APPS) do
        if app.name:lower() == input:lower() then
          return app.id
        end
      end
      print("Invalid selection")
      return select_app()
    end
  end
end

local app_name = arg[1]
local app_id = select_app(app_name)
if app_id then
  launch_app(app_id)
end

