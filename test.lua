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
      if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster") then 
          for _, t in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 
              if t:IsA("TextLabel") then 
                  t.RichText = true 
              end 
          end 
      end
      pcall(function() --// its WILL throw errors cuz im dumbass (were just throwing this errors away)
        local consoleview = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("DevConsoleWindow"):FindFirstChild("DevConsoleUI"):FindFirstChild("MainView"):FindFirstChild("ClientLog")
        if not consoleview then
            return
        end
        if BetterPrint.Container ~= nil then  --// also this code is sh!t
            for _, t in pairs(BetterPrint.Container:GetDescendants()) do 
                if t then 
                    local n = t.Name

                    for index,label in pairs(game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):GetDescendants()) do 
                        if label:IsA("TextLabel") and string.find(label.Text:lower(),n:lower()) then 
                            labelforimg = label 
                            if labelforimg.Parent:FindFirstChild(n) then
                                return
                            end
                            c = t:Clone()
                            c.Parent = labelforimg.Parent
                            c.Visible = true
                            break
                        end 
                    end
                end 
            end 
        end
      end)
    end)
end
local function setupEnv()
    if game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("BetterPrint") then
        BetterPrint.Container = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster"):FindFirstChild("BetterPrint")
        return
    end

    local container = Instance.new("Folder")
    container.Name = "BetterPrint"
    container.Parent = game:GetService("CoreGui"):FindFirstChild("DevConsoleMaster")

    BetterPrint.Container = container
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
function BetterPrint.printimage(assetid, scaletype, height, width)
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

    for i = 0, math.ceil(height / 19) do --// filling gaps (FIXME: fix bug that makes prints that we DONT NEED)
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

function BetterPrint:Examples()
    if BetterPrint.Initiliazed ~= true then 
        print("use BetterPrint:Init() before call this!") 
        return
    end
    BetterPrint.print("github.com/andreythedev/BetterPrint/examples", "Default")
end
function BetterPrint:Clear() --// TODO: remake ts sh!t func
    print(("\n"):rep(50)) --// ts is best what i can make now 
end

--// System
function BetterPrint:GetVersion()
    return BetterPrint.Version
end
function BetterPrint:GetColors()
    return BetterPrint.Colors
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

    BetterPrint.Initiliazed = true
end

return BetterPrint
