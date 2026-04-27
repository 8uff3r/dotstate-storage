-- generate.lua
local cjson = require("cjson")

local function readFile(path)
    local f = io.open(path, "r")
    if f == nil then
        print("Couldn't open input json")
        return
    end
    local contents = f:read("*a")
    f:close()
    return contents
end

local function serialize(val, indent)
    indent = indent or 0
    local pad = string.rep("  ", indent)
    if type(val) == "table" then
        local parts = {}
        for k, v in pairs(val) do
            local key = type(k) == "string" and k .. " = " or ""
            table.insert(parts, pad .. "  " .. key .. serialize(v, indent + 1))
        end
        return "{\n" .. table.concat(parts, ",\n") .. "\n" .. pad .. "}"
    elseif type(val) == "string" then
        return string.format("%q", val)
    else
        return tostring(val)
    end
end

local data = cjson.decode(readFile("/home/rylan/.local/state/caelestia/scheme.json"))

local f = io.open("colorscheme_gen.lua", "w")
if f == nil then
    print("Couldn't open colorscheme_gen.lua")
    return
end
f:write("return " .. serialize(data))
f:close()

print("Generated colorscheme_gen.lua")
