-- CHLIP HUB V1 - MAIN LOADER (Mobile Optimized)
local baseURL = "https://raw.githubusercontent.com/jordanvalenzuela888-max/Chlip-Hub-V1/refs/heads/main/"

local chunks = {
    "chunk1.lua",
    "chunk2.lua", 
    "chunk3.lua",
    "chunk4.lua",
    "chunk5.lua",
    "chunk6.lua",
    "chunk7.lua",
    "chunk8.lua",
    "chunk9.lua",
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
