-- Ravine Scripts Loader mit Junkie Key System + Multi Scripts
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "Ravine Scripts"
Junkie.identifier = "12345"
Junkie.provider = "Mixed"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer
local PlaceId = game.PlaceId

-- Key Validation
local validatedKey = nil
local maxAttempts = 5
local attempts = 0

local function validateKey()
    while not validatedKey and attempts < maxAttempts do
        local link = Junkie.get_key_link()
        if link and setclipboard then setclipboard(link) end
        
        local keyInput = showKeyInputUI()
        if keyInput and #keyInput > 0 then
            attempts = attempts + 1
            local validation = Junkie.check_key(keyInput)
            if validation.valid then
                validatedKey = keyInput
                getgenv().SCRIPT_KEY = keyInput
                return true
            end
        end
        if attempts >= maxAttempts then return false end
        task.wait(1)
    end
    return false
end

function showKeyInputUI()
    local keyValue = nil
    local inputGui = Instance.new("ScreenGui")
    inputGui.Name = "KeyInput"
    inputGui.ResetOnSpawn = false
    inputGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    inputGui.Parent = (gethui and gethui()) or CoreGui
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 350, 0, 180)
    bg.Position = UDim2.new(0.5, -175, 0.5, -90)
    bg.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    bg.BorderSizePixel = 0
    bg.Parent = inputGui
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel", bg)
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    title.Text = "Enter Key - Ravine Scripts"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)
    
    local fix = Instance.new("Frame", title)
    fix.Size = UDim2.new(1, 0, 0, 10)
    fix.Position = UDim2.new(0, 0, 1, -10)
    fix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    fix.BorderSizePixel = 0
    
    local inputBox = Instance.new("TextBox", bg)
    inputBox.Size = UDim2.new(1, -40, 0, 35)
    inputBox.Position = UDim2.new(0, 20, 0, 55)
    inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    inputBox.PlaceholderText = "Paste your key here..."
    inputBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.Font = Enum.Font.Gotham
    inputBox.TextSize = 14
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)
    
    local submitBtn = Instance.new("TextButton", bg)
    submitBtn.Size = UDim2.new(1, -40, 0, 35)
    submitBtn.Position = UDim2.new(0, 20, 0, 105)
    submitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    submitBtn.Text = "SUBMIT"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 14
    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 6)
    
    submitBtn.MouseButton1Click:Connect(function()
        keyValue = inputBox.Text
        inputGui:Destroy()
    end)
    
    repeat task.wait() until keyValue ~= nil or not inputGui.Parent
    if inputGui.Parent then inputGui:Destroy() end
    return keyValue
end

if not validateKey() then
    player:Kick("Invalid key")
    return
end

-- ==================== LOADER UI ====================
local RavineLoader = Instance.new("ScreenGui")
RavineLoader.Name = "RavineLoader"
RavineLoader.ResetOnSpawn = false
RavineLoader.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
RavineLoader.Parent = (gethui and gethui()) or CoreGui

local Accent = Color3.fromRGB(255, 0, 0)
local Background = Color3.fromRGB(15, 15, 15)
local Secondary = Color3.fromRGB(25, 25, 25)
local TextColor = Color3.fromRGB(255, 255, 255)
local TextDim = Color3.fromRGB(150, 150, 150)

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = RavineLoader
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 140)
Header.BackgroundColor3 = Secondary
Header.BorderSizePixel = 0
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local HeaderFix = Instance.new("Frame", Header)
HeaderFix.Size = UDim2.new(1, 0, 0, 12)
HeaderFix.Position = UDim2.new(0, 0, 1, -12)
HeaderFix.BackgroundColor3 = Secondary
HeaderFix.BorderSizePixel = 0

local Logo = Instance.new("ImageLabel", Header)
Logo.Size = UDim2.new(0, 50, 0, 50)
Logo.Position = UDim2.new(0, 20, 0, 20)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://128553373538203"

local TitleLabel = Instance.new("TextLabel", Header)
TitleLabel.Size = UDim2.new(0, 200, 0, 30)
TitleLabel.Position = UDim2.new(0, 80, 0, 18)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Ravine Scripts"
TitleLabel.TextColor3 = TextColor
TitleLabel.TextSize = 24
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel", Header)
Version.Size = UDim2.new(0, 100, 0, 20)
Version.Position = UDim2.new(0, 80, 0, 48)
Version.BackgroundTransparency = 1
Version.Text = "v1.0.0"
Version.TextColor3 = Accent
Version.TextSize = 12
Version.Font = Enum.Font.Gotham
Version.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 15)
CloseBtn.BackgroundColor3 = Accent
CloseBtn.Text = "X"
CloseBtn.TextColor3 = TextColor
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
CloseBtn.MouseButton1Click:Connect(function() RavineLoader:Destroy() end)

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -85, 0, 15)
MinBtn.BackgroundColor3 = Secondary
MinBtn.Text = "-"
MinBtn.TextColor3 = TextColor
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
MinBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

local StatsBar = Instance.new("Frame", Header)
StatsBar.Size = UDim2.new(1, -40, 0, 30)
StatsBar.Position = UDim2.new(0, 20, 0, 85)
StatsBar.BackgroundColor3 = Background
StatsBar.BorderSizePixel = 0
Instance.new("UICorner", StatsBar).CornerRadius = UDim.new(0, 6)

local StatsLabel = Instance.new("TextLabel", StatsBar)
StatsLabel.Size = UDim2.new(1, 0, 1, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "Welcome, " .. player.DisplayName .. " | Made by xaaaxaa/yen"
StatsLabel.TextColor3 = TextDim
StatsLabel.TextSize = 12
StatsLabel.Font = Enum.Font.Gotham

local FooterLabel = Instance.new("TextLabel", Header)
FooterLabel.Size = UDim2.new(1, -40, 0, 15)
FooterLabel.Position = UDim2.new(0, 20, 0, 118)
FooterLabel.BackgroundTransparency = 1
FooterLabel.Text = "discord.gg/get-ravine"
FooterLabel.TextColor3 = Accent
FooterLabel.TextSize = 10
FooterLabel.Font = Enum.Font.Gotham
FooterLabel.TextXAlignment = Enum.TextXAlignment.Center

local ScriptsContainer = Instance.new("ScrollingFrame", Main)
ScriptsContainer.Size = UDim2.new(1, -10, 1, -150)
ScriptsContainer.Position = UDim2.new(0, 5, 0, 145)
ScriptsContainer.BackgroundTransparency = 1
ScriptsContainer.BorderSizePixel = 0
ScriptsContainer.ScrollBarThickness = 3
ScriptsContainer.ScrollBarImageColor3 = Accent
ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

local ScriptList = Instance.new("UIListLayout", ScriptsContainer)
ScriptList.Padding = UDim.new(0, 10)
ScriptList.HorizontalAlignment = Enum.HorizontalAlignment.Center
ScriptList.SortOrder = Enum.SortOrder.LayoutOrder

local function CreateCard(name, desc, icon, placeId, callback)
    local Card = Instance.new("Frame", ScriptsContainer)
    Card.Size = UDim2.new(1, -10, 0, 70)
    Card.BackgroundColor3 = Secondary
    Card.BorderSizePixel = 0
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8)
    
    local Icon = Instance.new("ImageLabel", Card)
    Icon.Size = UDim2.new(0, 45, 0, 45)
    Icon.Position = UDim2.new(0, 12, 0.5, -22)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon
    Icon.ScaleType = Enum.ScaleType.Fit
    Instance.new("UICorner", Icon).CornerRadius = UDim.new(0, 6)
    
    local NameLabel = Instance.new("TextLabel", Card)
    NameLabel.Size = UDim2.new(1, -160, 0, 25)
    NameLabel.Position = UDim2.new(0, 70, 0, 10)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = TextColor
    NameLabel.TextSize = 15
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local DescLabel = Instance.new("TextLabel", Card)
    DescLabel.Size = UDim2.new(1, -160, 0, 20)
    DescLabel.Position = UDim2.new(0, 70, 0, 35)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = desc
    DescLabel.TextColor3 = TextDim
    DescLabel.TextSize = 11
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local LoadBtn = Instance.new("TextButton", Card)
    LoadBtn.Size = UDim2.new(0, 70, 0, 28)
    LoadBtn.Position = UDim2.new(1, -85, 0.5, -14)
    LoadBtn.BackgroundColor3 = PlaceId == placeId and Accent or Color3.fromRGB(100, 100, 100)
    LoadBtn.Text = PlaceId == placeId and "LOAD" or "WRONG GAME"
    LoadBtn.TextColor3 = TextColor
    LoadBtn.TextSize = PlaceId == placeId and 12 or 9
    LoadBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 5)
    
    if PlaceId == placeId then
        LoadBtn.MouseEnter:Connect(function() TweenService:Create(LoadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play() end)
        LoadBtn.MouseLeave:Connect(function() TweenService:Create(LoadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Accent}):Play() end)
        LoadBtn.MouseButton1Click:Connect(function()
            Main.Visible = false
            callback()
        end)
    end
    
    ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, ScriptList.AbsoluteContentSize.Y + 20)
end

-- ==================== SCRIPTS ====================
-- Jedes Script wird von einer SEPARATEN URL geladen
-- So kannst du mehrere Scripts haben ohne dass die Datei zu gross wird

local Scripts = {
    {
        Name = "Chicken Farm",
        Description = "Auto Collect, Deposit, Upgrade, Merge, Lucky Blocks",
        Icon = "https://tr.rbxcdn.com/180DAY-2bcc5a3b5a0a7b9a55f174d41fccda6f/768/432/Image/Webp/noFilter",
        PlaceId = 137233438285284,
        
        ScriptUrl = "https://api.jnkie.com/api/v1/luascripts/public/b99290ab5a4cde0b21f5e8ae933b738230a72028938eca6d4555b13b34bc0fe8/download"
    },
    {
        Name = "Ravine FIAS",
        Description = "Combat, Farming, ESP, Teleports, Visuals & More",
        Icon = "rbxassetid://128553373538203",
        PlaceId = 17698425045,
        
        ScriptUrl = "https://api.jnkie.com/api/v1/luascripts/public/6a738d69bfbf6714714cc37a11021c149c512e93db82b9c422ca99e0b686deb5/download"
    },
}

for _, scriptData in ipairs(Scripts) do
    CreateCard(scriptData.Name, scriptData.Description, scriptData.Icon, scriptData.PlaceId, function()
        loadstring(game:HttpGet(scriptData.ScriptUrl))()
    end)
end

-- Dragging
local dragging, dragStart, startPos
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then Main.Visible = not Main.Visible end
end)
