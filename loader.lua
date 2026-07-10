-- Ravine Scripts - FREE Loader
local Junkie = loadstring(game:HttpGet("https://jnkie.com/sdk/library.lua"))()
Junkie.service = "ravine"
Junkie.identifier = "1064771"
Junkie.provider = "ravine"

local result = (function()
    getgenv().UI_CLOSED = false
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Lighting = game:GetService("Lighting")
    local Colors = {
        background    = Color3.fromRGB(10, 10, 12),
        surface       = Color3.fromRGB(18, 14, 14),
        surfaceLight  = Color3.fromRGB(28, 20, 20),
        primary       = Color3.fromRGB(192, 0, 14),
        primaryDark   = Color3.fromRGB(140, 0, 8),
        primaryGlow   = Color3.fromRGB(220, 40, 40),
        accent        = Color3.fromRGB(180, 30, 30),
        success       = Color3.fromRGB(47, 183, 117),
        successDark   = Color3.fromRGB(37, 153, 97),
        successGlow   = Color3.fromRGB(67, 203, 137),
        error         = Color3.fromRGB(248, 81, 73),
        textPrimary   = Color3.fromRGB(230, 220, 220),
        textSecondary = Color3.fromRGB(160, 130, 130),
        textMuted     = Color3.fromRGB(110, 90, 90),
        border        = Color3.fromRGB(60, 30, 30),
        borderLight   = Color3.fromRGB(80, 40, 40),
        glass         = Color3.fromRGB(255, 255, 255),
        neonBlue      = Color3.fromRGB(255, 60, 60),
        neonPurple    = Color3.fromRGB(200, 0, 0)
    }

    local DISCORD_LINK = "https://discord.gg/get-ravine"

    local function saveVerifiedKey(key)
        pcall(function() writefile("verified_key.txt", key) end)
    end

    local function loadVerifiedKey()
        local ok, content = pcall(function() return readfile("verified_key.txt") end)
        return ok and content or nil
    end

    local function clearSavedKey()
        pcall(function() delfile("verified_key.txt") end)
    end

    local function loadUIFactory()
        return function(Colors, Players, TweenService, UserInputService, Lighting)
            local IconAssets = {
                shield = 84528813312016, x = 73070135088117,
                key = 128426502701541, link = 73034596791310, check = 83827110621355
            }

            local function createIconImage(name, size, color)
                local id = IconAssets[name]
                if id then
                    local img = Instance.new("ImageLabel")
                    img.BackgroundTransparency = 1
                    img.Size = UDim2.new(0, size or 18, 0, size or 18)
                    img.Image = "rbxassetid://" .. tostring(id)
                    img.ImageColor3 = color or Color3.fromRGB(255, 255, 255)
                    img.ScaleType = Enum.ScaleType.Fit
                    return img
                end
                return nil
            end

            return function(self)
                if self.gui then self.gui:Destroy() end
                self.gui = Instance.new("ScreenGui")
                self.gui.Name = "RavineKeySystem"
                self.gui.ResetOnSpawn = false
                self.gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                self.gui.IgnoreGuiInset = true

                local backdrop = Instance.new("Frame")
                backdrop.Size = UDim2.new(1, 0, 1, 0)
                backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                backdrop.BackgroundTransparency = 0.35
                backdrop.BorderSizePixel = 0
                backdrop.Parent = self.gui

                local blur = Instance.new("BlurEffect")
                blur.Size = 16
                blur.Name = "JunkieUIBlur"
                blur.Parent = Lighting

                local container = Instance.new("Frame")
                container.Size = UDim2.new(0, 580, 0, 320)
                container.Position = UDim2.new(0.5, 0, 0.5, 0)
                container.AnchorPoint = Vector2.new(0.5, 0.5)
                container.BackgroundColor3 = Colors.surface
                container.BorderSizePixel = 0
                container.Parent = backdrop
                Instance.new("UICorner", container).CornerRadius = UDim.new(0, 14)
                
                local containerStroke = Instance.new("UIStroke")
                containerStroke.Color = Colors.primary
                containerStroke.Thickness = 1.5
                containerStroke.Transparency = 0.4
                containerStroke.Parent = container

                local glowFrame = Instance.new("Frame")
                glowFrame.Size = UDim2.new(1, 60, 1, 60)
                glowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                glowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                glowFrame.BackgroundColor3 = Colors.primary
                glowFrame.BackgroundTransparency = 0.93
                glowFrame.BorderSizePixel = 0
                glowFrame.ZIndex = -1
                glowFrame.Parent = backdrop
                Instance.new("UICorner", glowFrame).CornerRadius = UDim.new(0, 30)
                TweenService:Create(glowFrame, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                    {BackgroundTransparency = 0.87, Size = UDim2.new(1, 80, 1, 80)}):Play()

                local topBar = Instance.new("Frame")
                topBar.Size = UDim2.new(1, 0, 0, 45)
                topBar.BackgroundColor3 = Colors.background
                topBar.BorderSizePixel = 0
                topBar.ZIndex = 10
                topBar.Parent = container
                Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 14)
                local topBarFix = Instance.new("Frame", topBar)
                topBarFix.Size = UDim2.new(1, 0, 0, 10)
                topBarFix.Position = UDim2.new(0, 0, 1, -10)
                topBarFix.BackgroundColor3 = Colors.background
                topBarFix.BorderSizePixel = 0

                local topBarLine = Instance.new("Frame")
                topBarLine.Size = UDim2.new(1, 0, 0, 1)
                topBarLine.Position = UDim2.new(0, 0, 1, -1)
                topBarLine.BackgroundColor3 = Colors.primary
                topBarLine.BackgroundTransparency = 0.4
                topBarLine.BorderSizePixel = 0
                topBarLine.Parent = topBar

                local brandLogo = Instance.new("Frame")
                brandLogo.Size = UDim2.new(0, 220, 1, 0)
                brandLogo.Position = UDim2.new(0, 16, 0, 0)
                brandLogo.BackgroundTransparency = 1
                brandLogo.ZIndex = 11
                brandLogo.Parent = topBar

                local brandIcon = createIconImage("shield", 20, Colors.primary)
                brandIcon.AnchorPoint = Vector2.new(0, 0.5)
                brandIcon.Position = UDim2.new(0, 0, 0.5, 0)
                brandIcon.ZIndex = 11
                brandIcon.Parent = brandLogo

                local brandText = Instance.new("TextLabel")
                brandText.BackgroundTransparency = 1
                brandText.Size = UDim2.new(1, -30, 1, 0)
                brandText.Position = UDim2.new(0, 28, 0, 0)
                brandText.Text = "Ravine Key System"
                brandText.TextColor3 = Colors.textPrimary
                brandText.TextSize = 15
                brandText.TextXAlignment = Enum.TextXAlignment.Left
                brandText.Font = Enum.Font.GothamSemibold
                brandText.ZIndex = 11
                brandText.Parent = brandLogo

                local closeButton = Instance.new("TextButton")
                closeButton.Size = UDim2.new(0, 30, 0, 30)
                closeButton.Position = UDim2.new(1, -40, 0.5, 0)
                closeButton.AnchorPoint = Vector2.new(0, 0.5)
                closeButton.BackgroundColor3 = Colors.primary
                closeButton.BackgroundTransparency = 0.7
                closeButton.BorderSizePixel = 0
                closeButton.Text = ""
                closeButton.AutoButtonColor = false
                closeButton.ZIndex = 11
                closeButton.Parent = topBar
                Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)
                local closeIcon = createIconImage("x", 16, Colors.textPrimary)
                closeIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                closeIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                closeIcon.ZIndex = 12
                closeIcon.Parent = closeButton

                local contentArea = Instance.new("Frame")
                contentArea.Size = UDim2.new(1, -40, 1, -65)
                contentArea.Position = UDim2.new(0, 20, 0, 55)
                contentArea.BackgroundTransparency = 1
                contentArea.Parent = container

                local titleSection = Instance.new("Frame")
                titleSection.Size = UDim2.new(1, 0, 0, 85)
                titleSection.Position = UDim2.new(0, 0, 0, 5)
                titleSection.BackgroundTransparency = 1
                titleSection.Parent = contentArea

                local iconFrame = Instance.new("Frame")
                iconFrame.Size = UDim2.new(0, 52, 0, 52)
                iconFrame.Position = UDim2.new(0.5, -26, 0, 0)
                iconFrame.BackgroundColor3 = Colors.surfaceLight
                iconFrame.BorderSizePixel = 0
                iconFrame.Parent = titleSection
                Instance.new("UICorner", iconFrame).CornerRadius = UDim.new(0, 12)

                local iconGradient = Instance.new("UIGradient")
                iconGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Colors.primary),
                    ColorSequenceKeypoint.new(0.5, Colors.primaryGlow),
                    ColorSequenceKeypoint.new(1, Colors.accent)
                }
                iconGradient.Rotation = 45
                iconGradient.Parent = iconFrame

                local iconStroke = Instance.new("UIStroke")
                iconStroke.Color = Colors.primary
                iconStroke.Thickness = 2
                iconStroke.Transparency = 0.4
                iconStroke.Parent = iconFrame

                local mainIcon = createIconImage("shield", 26, Color3.fromRGB(255, 255, 255))
                mainIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                mainIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                mainIcon.Parent = iconFrame

                local titleText = Instance.new("TextLabel")
                titleText.Size = UDim2.new(1, 0, 0, 24)
                titleText.Position = UDim2.new(0, 0, 0, 58)
                titleText.BackgroundTransparency = 1
                titleText.Text = "Ravine Scripts"
                titleText.TextColor3 = Colors.textPrimary
                titleText.TextSize = 17
                titleText.TextXAlignment = Enum.TextXAlignment.Center
                titleText.Font = Enum.Font.GothamBold
                titleText.Parent = titleSection

                local subtitleText = Instance.new("TextLabel")
                subtitleText.Size = UDim2.new(1, 0, 0, 18)
                subtitleText.Position = UDim2.new(0, 0, 0, 82)
                subtitleText.BackgroundTransparency = 1
                subtitleText.Text = "Made by xaaaxaa/yen"
                subtitleText.TextColor3 = Colors.textSecondary
                subtitleText.TextSize = 13
                subtitleText.TextXAlignment = Enum.TextXAlignment.Center
                subtitleText.Font = Enum.Font.Gotham
                subtitleText.Parent = titleSection

                local inputSection = Instance.new("Frame")
                inputSection.Size = UDim2.new(1, 0, 0, 46)
                inputSection.Position = UDim2.new(0, 0, 0, 115)
                inputSection.BackgroundColor3 = Colors.surfaceLight
                inputSection.BorderSizePixel = 0
                inputSection.Parent = contentArea
                Instance.new("UICorner", inputSection).CornerRadius = UDim.new(0, 10)
                local inputStroke = Instance.new("UIStroke")
                inputStroke.Color = Colors.border
                inputStroke.Thickness = 1
                inputStroke.Transparency = 0.4
                inputStroke.Parent = inputSection

                local keyIcon = createIconImage("key", 18, Colors.primary)
                keyIcon.AnchorPoint = Vector2.new(0, 0.5)
                keyIcon.Position = UDim2.new(0, 14, 0.5, 0)
                keyIcon.Parent = inputSection

                local keyInput = Instance.new("TextBox")
                keyInput.Size = UDim2.new(1, -50, 1, 0)
                keyInput.Position = UDim2.new(0, 40, 0, 0)
                keyInput.BackgroundTransparency = 1
                keyInput.PlaceholderText = "Enter your verification key"
                keyInput.PlaceholderColor3 = Colors.textMuted
                keyInput.Text = ""
                keyInput.TextColor3 = Colors.textPrimary
                keyInput.TextSize = 14
                keyInput.Font = Enum.Font.Gotham
                keyInput.Parent = inputSection

                local buttonSection = Instance.new("Frame")
                buttonSection.Size = UDim2.new(1, 0, 0, 40)
                buttonSection.Position = UDim2.new(0, 0, 0, 175)
                buttonSection.BackgroundTransparency = 1
                buttonSection.Parent = contentArea

                local getKeyButton = Instance.new("TextButton")
                getKeyButton.Size = UDim2.new(0.48, 0, 1, 0)
                getKeyButton.Position = UDim2.new(0, 0, 0, 0)
                getKeyButton.BackgroundColor3 = Colors.background
                getKeyButton.Text = "Get Key"
                getKeyButton.TextColor3 = Color3.fromRGB(220, 220, 220)
                getKeyButton.TextSize = 14
                getKeyButton.Font = Enum.Font.GothamSemibold
                getKeyButton.AutoButtonColor = false
                getKeyButton.Parent = buttonSection
                Instance.new("UICorner", getKeyButton).CornerRadius = UDim.new(0, 10)
                local getKeyStroke = Instance.new("UIStroke")
                getKeyStroke.Color = Colors.primary
                getKeyStroke.Thickness = 1.5
                getKeyStroke.Transparency = 0.2
                getKeyStroke.Parent = getKeyButton

                local verifyButton = Instance.new("TextButton")
                verifyButton.Size = UDim2.new(0.48, 0, 1, 0)
                verifyButton.Position = UDim2.new(0.52, 0, 0, 0)
                verifyButton.BackgroundColor3 = Colors.primary
                verifyButton.Text = "Verify Key"
                verifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                verifyButton.TextSize = 14
                verifyButton.Font = Enum.Font.GothamSemibold
                verifyButton.AutoButtonColor = false
                verifyButton.Parent = buttonSection
                Instance.new("UICorner", verifyButton).CornerRadius = UDim.new(0, 10)

                local statusText = Instance.new("TextLabel")
                statusText.Size = UDim2.new(1, -40, 0, 20)
                statusText.Position = UDim2.new(0.5, 0, 1, -38)
                statusText.AnchorPoint = Vector2.new(0.5, 0)
                statusText.BackgroundTransparency = 1
                statusText.Text = ""
                statusText.TextColor3 = Colors.textSecondary
                statusText.Font = Enum.Font.Gotham
                statusText.TextSize = 12
                statusText.TextXAlignment = Enum.TextXAlignment.Center
                statusText.Visible = false
                statusText.Parent = container

                self.elements = {
                    backdrop = backdrop, container = container,
                    iconFrame = iconFrame, title = titleText,
                    subtitle = subtitleText, getLinkButton = getKeyButton,
                    inputFrame = inputSection, keyInput = keyInput,
                    verifyButton = verifyButton, statusText = statusText,
                    inputStroke = inputStroke, closeButton = closeButton,
                    glowFrame = glowFrame
                }

                closeButton.MouseButton1Click:Connect(function()
                    getgenv().UI_CLOSED = true
                    TweenService:Create(container, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(backdrop, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    task.wait(0.2)
                    if blur then blur:Destroy() end
                    self.gui:Destroy()
                end)

                getKeyButton.MouseButton1Click:Connect(function()
                    local link = Junkie.get_key_link()
                    if link and setclipboard then
                        setclipboard(link)
                        self:updateStatus("Link copied to clipboard!", Colors.success, 3)
                    else
                        self:updateStatus("Failed to get link", Colors.error, 3)
                    end
                end)

                verifyButton.MouseButton1Click:Connect(function()
                    local key = keyInput.Text:gsub("%s+", "")
                    if key == "" then
                        self:updateStatus("Please enter a key", Colors.error, 3)
                        self:shakeInput()
                        return
                    end
                    self:updateStatus("Verifying...", Colors.primary, 0)
                    local result = Junkie.check_key(key)
                    if result and result.valid then
                        saveVerifiedKey(key)
                        getgenv().SCRIPT_KEY = key
                        self:updateStatus("Key verified!", Colors.success, 0)
                        task.wait(0.5)
                        self:close()
                    else
                        self:updateStatus("Invalid key", Colors.error, 3)
                        self:shakeInput()
                    end
                end)

                self.updateStatus = function(self, message, color, duration)
                    local st = self.elements.statusText
                    if st then
                        st.Text = message
                        st.TextColor3 = color or Colors.textSecondary
                        st.Visible = true
                        if duration and duration > 0 then
                            task.delay(duration, function()
                                if st and st.Text == message then st.Visible = false end
                            end)
                        end
                    end
                end

                self.shakeInput = function(self)
                    local f = self.elements.inputFrame
                    if not f then return end
                    local orig = f.Position
                    for i = 1, 3 do
                        TweenService:Create(f, TweenInfo.new(0.05), {Position = UDim2.new(orig.X.Scale, orig.X.Offset-8, orig.Y.Scale, orig.Y.Offset)}):Play()
                        task.wait(0.05)
                        TweenService:Create(f, TweenInfo.new(0.05), {Position = UDim2.new(orig.X.Scale, orig.X.Offset+8, orig.Y.Scale, orig.Y.Offset)}):Play()
                        task.wait(0.05)
                    end
                    f.Position = orig
                end

                self.close = function(self)
                    getgenv().UI_CLOSED = true
                    TweenService:Create(self.elements.container, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(self.elements.backdrop, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                    task.wait(0.2)
                    if blur then blur:Destroy() end
                    self.gui:Destroy()
                end

                self.gui.Parent = game:GetService("CoreGui")
                return self.gui
            end
        end
    end

    local UI = {}
    UI.__index = UI

    function UI.new()
        local self = setmetatable({}, UI)
        self.player = Players.LocalPlayer
        self.gui = nil
        return self
    end

    UI.createUI = function(self)
        local UIFactory = loadUIFactory()
        local uiBuilder = UIFactory(Colors, Players, TweenService, UserInputService, Lighting)
        uiBuilder(self)
        return self.gui
    end

    local ui = UI.new()
    ui:createUI()

    local savedKey = loadVerifiedKey()
    if savedKey then
        local result = Junkie.check_key(savedKey)
        if result and result.valid then
            getgenv().SCRIPT_KEY = savedKey
            ui:close()
            return getgenv().SCRIPT_KEY
        else
            clearSavedKey()
        end
    end

    while not getgenv().UI_CLOSED do task.wait(0.1) end
    return getgenv().SCRIPT_KEY
end)()

-- Free Loader UI
if getgenv().SCRIPT_KEY and getgenv().SCRIPT_KEY ~= "" then
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")
    local player = Players.LocalPlayer
    local PlaceId = game.PlaceId

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

    local function CreateCard(name, desc, icon, placeIds, scriptUrl)
        local validPlace = false
        if type(placeIds) == "table" then
            for _, id in ipairs(placeIds) do
                if PlaceId == id then validPlace = true; break end
            end
        else
            validPlace = PlaceId == placeIds
        end

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
        LoadBtn.BackgroundColor3 = validPlace and Accent or Color3.fromRGB(100, 100, 100)
        LoadBtn.Text = validPlace and "LOAD" or "WRONG GAME"
        LoadBtn.TextColor3 = TextColor
        LoadBtn.TextSize = validPlace and 12 or 9
        LoadBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 5)
        if validPlace then
            LoadBtn.MouseEnter:Connect(function() TweenService:Create(LoadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}):Play() end)
            LoadBtn.MouseLeave:Connect(function() TweenService:Create(LoadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Accent}):Play() end)
            LoadBtn.MouseButton1Click:Connect(function()
                RavineLoader:Destroy()
                loadstring(game:HttpGet(scriptUrl))()
            end)
        end
        ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, ScriptList.AbsoluteContentSize.Y + 20)
    end

    local Scripts = {
        {
            Name = "Ravine FIAS",
            Description = "Combat, Farming, Kill Aura, Teleports, & More",
            Icon = "https://tr.rbxcdn.com/180DAY-7673b5e1c0a3a7b07c67aa457adf05ea/768/432/Image/Webp/noFilter",
            PlaceIds = {17698425045, 86098085533596, 18248633989, 118758941554698},
            ScriptUrl = "https://api.jnkie.com/api/v1/luascripts/public/6a738d69bfbf6714714cc37a11021c149c512e93db82b9c422ca99e0b686deb5/download"
        },
        {
            Name = "Ravine Fight on A Baseplate",
            Description = "Kill Aura, Auto Weave, No Collide, Anti Shake, Move While Knocked",
            Icon = "https://tr.rbxcdn.com/180DAY-fb0455d36bd1cd15f946c57abb8f2c6d/256/256/Image/Webp/noFilter",
            PlaceIds = {130960021905304},
            ScriptUrl = "https://api.jnkie.com/api/v1/luascripts/public/cffebf9fcf41cb050a6a9963ec213e7ae19527e1916f74442fa8678d991c465e/download"
        },
        {
            Name = "Ravine Chicken Farm",
            Description = "Auto Collect, Deposit, Upgrade, Merge, Lucky Blocks",
            Icon = "https://tr.rbxcdn.com/180DAY-fb0455d36bd1cd15f946c57abb8f2c6d/256/256/Image/Webp/noFilter",
            PlaceIds = {137233438285284},
            ScriptUrl = "https://api.jnkie.com/api/v1/luascripts/public/b99290ab5a4cde0b21f5e8ae933b738230a72028938eca6d4555b13b34bc0fe8/download"
        },
    }

    for _, scriptData in ipairs(Scripts) do
        CreateCard(scriptData.Name, scriptData.Description, scriptData.Icon, scriptData.PlaceIds, scriptData.ScriptUrl)
    end

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
end
