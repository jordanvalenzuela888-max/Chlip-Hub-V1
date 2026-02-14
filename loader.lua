-- CHLIP HUB V1 - MAIN LOADER
-- Replace these URLs with your GitHub raw URLs
local baseURL = "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/"

local chunks = {
    "chunk1.lua",  -- Services & Unlock Functions
    "chunk2.lua",  -- Lockpick UI
    "chunk3.lua",  -- Header UI
    "chunk4.lua",  -- Left Scroll Framework
    "chunk5.lua",  -- Left Scroll Toggles 1-5
    "chunk6.lua",  -- Left Scroll Toggles 6-9 + Draggable
    "chunk7.lua",  -- Main Features Framework
    "chunk8.lua",  -- Main Features Elements
    "chunk9.lua",  -- Main Features Functionality
}

local services = nil

for i, chunkName in ipairs(chunks) do
    local success, result = pcall(function()
        local url = baseURL .. chunkName
        local code = game:HttpGet(url)
        local loadedFunction = loadstring(code)
        
        if i == 1 then
            services = loadedFunction()
        else
            services = loadedFunction(services)
        end
    end)
    
    if not success then
        warn("Failed to load " .. chunkName .. ": " .. tostring(result))
        break
    else
        print("Loaded " .. chunkName .. " (" .. i .. "/" .. #chunks .. ")")
    end
end
