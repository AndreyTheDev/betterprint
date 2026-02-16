--[[
    BetterPrint v0.15 | alpha
        developed by andreythedevv
        t.me/SegmaNews

    github.com/andreythedev/betterprint

    // also credits to verified (i stole his idea lmao)
    https://scriptblox.com/script/Universal-Script-Change-output-color-16903
]]
local LogService = game:GetService("LogService")

local BetterPrint = {
    Colors = {
        ["Default"] = "255,255,255",
        ["Red"] = "255,106,87",
        ["Green"] = "59,255,0",
        ["Blue"] = "0,71,255",
        ["White"] = "255,255,255",
        ["Black"] = "0,0,0",
        ["Cyan"] = "33,161,163",
        ["Yellow"] = "242,255,0"
    },
    Version = "v0.15",
    Initialized = false,

    --// sys
    Container = nil
}

--// helpers
local function MakeTextRich() --// YAY TEXT NOW IS SUPER RICH WHATAFU
    game:GetService("RunService").Heartbeat:Connect(function()
      pcall(function()
        if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster") then 
            for _, t in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 
                if t:IsA("TextLabel") then 
                    if t.RichText ~= true then
                        t.RichText = true 
                    end
                end 
            end 
        end          
      end)

    pcall(function()
        local consoleview = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("DevConsoleWindow"):FindFirstChild("DevConsoleUI"):FindFirstChild("MainView"):FindFirstChild("ClientLog")
        if not consoleview or not BetterPrint or not BetterPrint.Container then return end
        
        for _, label in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do
            if label:IsA("TextLabel") then
                for _, img in pairs(BetterPrint.Container:GetDescendants()) do
                    if img:IsA("ImageLabel") and string.find(label.Text:lower(), img.Name:lower(), 1, true) and not label.Parent:FindFirstChild(img.Name) then
                        c = img:Clone()
                        c.Parent = label.Parent
                        c.Visible = true
                    end
                end
            end
        end
     end)
    end)
end
local function setupEnv()
    pcall(function() --// also throwing errs so i just throwing it away :3
        if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("BetterPrint") then
            BetterPrint.Container = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("BetterPrint")
            return
        end

        local container = Instance.new("Folder")
        container.Name = "BetterPrint"
        container.Parent = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster")

        BetterPrint.Container = container        
    end)
end
local function IsStartsWithNum(str)
    if str:match("^%d") then
        --print("true")
        return true
    else
        --print("false")
        return false
    end
end
local function generateAscii(text, font) --// we use https://asciified.thelicato.io/ api cuz im too lazy to make ascii arts generator in lua :P
    local url = "https://asciified.thelicato.io/api/v2/ascii?text=".. string.gsub(text, " ", "+") .."&font=".. font
    local response = request({
        Url = url,
        Method = "GET"
    })
    return "\n".. response.Body
end

--// functions
function BetterPrint.print(text, color, size)
    if BetterPrint.Initiliazed ~= true then 
        print("use BetterPrint:Init() before call this!") 
        return
    end
    --// default vars
    color = color or "Default"
    size = size or 15
    if IsStartsWithNum(color) then
        color = color
    else
        color = BetterPrint.Colors[color]
    end
    
    --// print
    local formatted = "<font color='rgb(" .. color .. ")' size='" .. tostring(size) .. "'"
    formatted = formatted .. '>' .. tostring(text) .. '</font>'
    print(formatted)
end
function BetterPrint.Loading(title, completeText, color, wait, symbol) --// credits to Verified (https://scriptblox.com/script/Universal-Script-Luarmor-like-loading-ig-18152)
    if BetterPrint.Initiliazed ~= true then 
        print("use BetterPrint:Init() before call this!") 
        return
    end

    title = title or "BetterPrint"
    completeText = completeText or "Completed!"
    color = color or "Green"
    if IsStartsWithNum(color) then
        color = color
    else
        color = BetterPrint.Colors[color]
    end

    wait = wait or 0.1
    symbol = symbol or "#"
    local title2 = "".. title .." ".. completeText .. "/" .. tostring(math.random(0, 10000000))
    print(title2)

    local loadingLabel = nil
    local progress = ""

    repeat task.wait()
        for index,label in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 

            if label:IsA("TextLabel") and string.find(label.Text:lower(),title2:lower()) then 
                loadingLabel = label 
                print(label:GetFullName())
        break
            end 
        end 
    until loadingLabel
    local start = os.time()

    for i = 1, 50 do
        progress = progress .. symbol
        loadingLabel.Text = string.format("<font color='rgb(%s)' size='15'>[%s] [%d%%] %s</font>", BetterPrint.Colors["White"], title, i*2, progress)
        task.wait(wait)
    end
    loadingLabel.Text = string.format("<font color='rgb(%s)' size='15'>[%s] %s</font>", color, title, completeText)
end
function BetterPrint.printimage(assetid, height, width, scaletype)
    if BetterPrint.Initiliazed ~= true then 
        print("use BetterPrint:Init() before call this!") 
        return
    end
    assetid = assetid or "rbxassetid://11104447788"
    scaletype = scaletype or "Stretch"
    height = height or 100
    width = width or 100
    id = tostring(math.random(0, 10000000))
    print(" ".. id) --// for replacing

    for i = 0, math.ceil(height / 20) do --// filling gaps (FIXME: fix bug that makes prints that we DONT NEED)
        print()
    end

    if IsStartsWithNum(assetid) then
        assetid = "rbxassetid://".. assetid
    end

    --// we are making frame with fuckin img label, js like im default print (cuz we just use image instead of text)
    local image = Instance.new("ImageLabel")
    image.Name = id
    image.Parent = BetterPrint.Container
    image.Size = UDim2.new(0, width, 0, height)
    image.Position = UDim2.new(0, 110, 0, 0)
    image.Image = assetid
    image.ScaleType = scaletype
    image.Visible = false
end
function BetterPrint.printascii(text, color, font)
    if not request then
        BetterPrint.print("ur exploit didnt supports request funcs so we cant generate ascii")
        return
    end
    text = text or "BetterPrint!"
    font = font or "Standard"
    color = color or "Default"
    if IsStartsWithNum(color) then
        color = color
    else
        color = BetterPrint.Colors[color]
    end

    BetterPrint.print(generateAscii(text, "Standard"), color)
end
function BetterPrint.what()
    if BetterPrint.Initiliazed ~= true then 
        print("use BetterPrint:Init() before call this!") 
        return
    end
    BetterPrint.printimage("rbxassetid://85702299740614", 200, 200)
end

--// System
function BetterPrint:GetVersion()
    return BetterPrint.Version
end
function BetterPrint:GetColors()
    return BetterPrint.Colors
end
function BetterPrint:Clear() --// TODO: remake ts sh!t func
    print(("\n"):rep(50)) --// ts is best what i can make now ()
    -- TODO: make real console cleanup by deleting all in console thats 
    --       before i think print (like in printimage)
end
function BetterPrint:Init(ShowCredits)
    ShowCredits = ShowCredits or false --// please dont disable it :(
    if ShowCredits then
        print("BetterPrint " .. BetterPrint.Version .. " | by andreythedevv")
        print("t.me/SegmaNews /!/ and also thanks dev of ts script https://scriptblox.com/script/Universal-Script-Change-output-color-16903 (cuz i stole his idea)")
    end

    --// so we starting init here
    setupEnv()
    MakeTextRich() --// wow pro

    BetterPrint.Initialized = true
end

return function()
    return BetterPrint
end
