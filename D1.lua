
local Config = {
    WidthPercentage = 0.65,
    HeightPercentage = 0.98,
    Position = "Center",
    DragThreshold = 8,
    SidebarWidth = 0.29, 
    Colors = {
        Background = Color3.fromRGB(0, 0, 0),
        SidebarBg = Color3.fromRGB(15, 10, 20),
        
        Primary = Color3.fromRGB(138, 43, 226),
        PrimaryDark = Color3.fromRGB(88, 20, 160),
        PrimaryDarker = Color3.fromRGB(55, 0, 100),
        
        
        TabBg = Color3.fromRGB(240, 240, 240),
        TabBgHover = Color3.fromRGB(255, 255, 255),
        TabActive = Color3.fromRGB(255, 255, 255),
        TabText = Color3.fromRGB(30, 30, 30),
        TabTextActive = Color3.fromRGB(138, 43, 226),

        Element = Color3.fromRGB(30, 30, 35),
        ElementHover = Color3.fromRGB(45, 45, 55),
        Text = Color3.fromRGB(230, 230, 230),
        TextDim = Color3.fromRGB(180, 180, 180),
        
        ToggleOff = Color3.fromRGB(50, 30, 75),
        ToggleOn = Color3.fromRGB(138, 43, 226),
    },

    Font = Enum.Font.GothamBold,
    FontBlack = Enum.Font.GothamBlack,
    SoundId = "rbxassetid://99276942443345",
    SoundVolume = 1,
}


local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local parentTarget = gethui and gethui() or game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DMenuSystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999
ScreenGui.Parent = parentTarget

local UISound = Instance.new("Sound")
UISound.SoundId = Config.SoundId
UISound.Volume = Config.SoundVolume
UISound.Parent = SoundService
UISound:Play()

local _orderCounter = 0
local function nextOrder()
    _orderCounter += 1
    return _orderCounter
end


local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Position = UDim2.new(0, 50, 0.5, -21)
ToggleBtn.Active = true
ToggleBtn.Draggable = false
ToggleBtn.ZIndex = 1000
ToggleBtn.AutoButtonColor = false

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleBtn

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Config.Colors.Primary
BtnStroke.Thickness = 1.5
BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
BtnStroke.Parent = ToggleBtn

local LetterD = Instance.new("TextLabel")
LetterD.Parent = ToggleBtn
LetterD.BackgroundTransparency = 1
LetterD.Size = UDim2.new(1, 0, 1, 0)
LetterD.Font = Config.FontBlack
LetterD.Text = "D"
LetterD.TextSize = 30
LetterD.TextColor3 = Config.Colors.PrimaryDark
LetterD.ZIndex = 1001

local LetterStroke = Instance.new("UIStroke")
LetterStroke.Color = Config.Colors.PrimaryDarker
LetterStroke.Thickness = 2
LetterStroke.Parent = LetterD

local ShineGradient = Instance.new("UIGradient")
ShineGradient.Rotation = 45
ShineGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Config.Colors.PrimaryDark),
    ColorSequenceKeypoint.new(0.4, Config.Colors.PrimaryDark),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.6, Config.Colors.PrimaryDark),
    ColorSequenceKeypoint.new(1, Config.Colors.PrimaryDark),
})
ShineGradient.Parent = LetterD

task.spawn(function()
    while ToggleBtn.Parent do
        ShineGradient.Offset = Vector2.new(-1, -1)
        local t = TweenService:Create(ShineGradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 1)})
        t:Play(); t.Completed:Wait()
        task.wait(1)
    end
end)


local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Config.Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(Config.WidthPercentage, 0, Config.HeightPercentage, 0)
MainFrame.Active = true
MainFrame.Draggable = false
MainFrame.ZIndex = 50
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Parent = MainFrame

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Config.Colors.PrimaryDarker
FrameStroke.Thickness = 1
FrameStroke.Parent = MainFrame

local targetPos
if Config.Position == "Center" then
    targetPos = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
elseif Config.Position == "Left" then
    targetPos = UDim2.new(0, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0, 0.5)
else
    targetPos = UDim2.new(1, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(1, 0.5)
end

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
TitleBar.BorderSizePixel = 0
TitleBar.Active = true
TitleBar.ZIndex = 60
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleCover = Instance.new("Frame")
TitleCover.Size = UDim2.new(1, 0, 0, 8)
TitleCover.Position = UDim2.new(0, 0, 1, -8)
TitleCover.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
TitleCover.BorderSizePixel = 0
TitleCover.ZIndex = 60
TitleCover.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -20, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Font = Config.FontBlack
TitleText.Text = "D — Menu"
TitleText.TextColor3 = Config.Colors.Primary
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 61
TitleText.Parent = TitleBar

-- ============================================================
-- 5. تقسيم الواجهة (القوائم + المحتوى)
-- ============================================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(Config.SidebarWidth, 0, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Config.Colors.SidebarBg
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 55
Sidebar.Parent = MainFrame

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 8)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 8)
SidebarPadding.PaddingRight = UDim.new(0, 8)
SidebarPadding.Parent = Sidebar

local SidebarDivider = Instance.new("Frame")
SidebarDivider.Size = UDim2.new(0, 1, 1, 0)
SidebarDivider.Position = UDim2.new(Config.SidebarWidth, 0, 0, 42)
SidebarDivider.BackgroundColor3 = Config.Colors.PrimaryDarker
SidebarDivider.BackgroundTransparency = 0.5
SidebarDivider.BorderSizePixel = 0
SidebarDivider.ZIndex = 55
SidebarDivider.Parent = MainFrame

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1 - Config.SidebarWidth, 0, 1, -42)
ContentArea.Position = UDim2.new(Config.SidebarWidth, 0, 0, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.ZIndex = 55
ContentArea.Parent = MainFrame

-- ============================================================
-- 6. منطق الفتح/الإغلاق
-- ============================================================
local isOpen = true
local currentTween = nil
local openTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local closeTweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local startPos = UDim2.new(-1, 0, -1, 0)
local endPos = UDim2.new(1.5, 0, 1.5, 0)

MainFrame.Visible = true
MainFrame.Position = targetPos

local function setOpen(open)
    isOpen = open
    if currentTween then currentTween:Cancel() end
    if open then
        MainFrame.Visible = true
        MainFrame.Position = startPos
        currentTween = TweenService:Create(MainFrame, openTweenInfo, {Position = targetPos})
    else
        currentTween = TweenService:Create(MainFrame, closeTweenInfo, {Position = endPos})
    end
    currentTween:Play()
    currentTween.Completed:Connect(function(state)
        if state == Enum.PlaybackState.Completed and not isOpen then
            MainFrame.Visible = false
        end
    end)
end

-- سحب زر D
local btnDragInput, btnDragStart, btnStartPos, btnIsDragging
ToggleBtn.InputBegan:Connect(function(input)
    if btnDragInput then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragInput = input
        btnDragStart = input.Position
        btnStartPos = ToggleBtn.Position
        btnIsDragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if btnDragInput ~= input then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - btnDragStart
        if not btnIsDragging and delta.Magnitude > Config.DragThreshold then
            btnIsDragging = true
        end
        if btnIsDragging then
            ToggleBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if btnDragInput ~= input then return end
    if not btnIsDragging then setOpen(not isOpen) end
    btnDragInput, btnDragStart, btnStartPos, btnIsDragging = nil, nil, nil, false
end)

-- سحب الإطار
local tbDragInput, tbDragStart, tbStartPos, tbIsDragging
TitleBar.InputBegan:Connect(function(input)
    if tbDragInput then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if currentTween then currentTween:Cancel() end
        tbDragInput = input
        tbDragStart = input.Position
        tbStartPos = MainFrame.Position
        tbIsDragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if tbDragInput ~= input then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - tbDragStart
        if not tbIsDragging and delta.Magnitude > 5 then
            tbIsDragging = true
        end
        if tbIsDragging then
            MainFrame.Position = UDim2.new(tbStartPos.X.Scale, tbStartPos.X.Offset + delta.X, tbStartPos.Y.Scale, tbStartPos.Y.Offset + delta.Y)
        end
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if tbDragInput ~= input then return end
    tbDragInput, tbDragStart, tbStartPos, tbIsDragging = nil, nil, nil, false
end)

-- ============================================================
-- 7. مكتبة الواجهة (UI Library)
-- ============================================================
local DMenu = {}
DMenu.Config = Config
DMenu.ScreenGui = ScreenGui
DMenu.MainFrame = MainFrame

local function makeCorner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = parent
    return c
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Parent = parent
    return s
end

local activeTab = nil

function DMenu.CreateTab(name)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = "Tab_" .. name
    tabBtn.Size = UDim2.new(1, 0, 0, 38)
    tabBtn.BackgroundColor3 = Config.Colors.TabBg
    tabBtn.BorderSizePixel = 0
    tabBtn.Text = ""
    tabBtn.AutoButtonColor = false
    tabBtn.LayoutOrder = nextOrder()
    tabBtn.ZIndex = 60 -- ✅ إجبار الزر على الظهور فوق الخلفية
    tabBtn.Parent = Sidebar
    makeCorner(tabBtn, 6)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Config.Font
    label.Text = name
    label.TextColor3 = Config.Colors.TabText
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 61 -- ✅ إجبار النص على الظهور
    label.Parent = tabBtn

    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, -10, 1, -10)
    tabContent.Position = UDim2.new(0, 5, 0, 5)
    tabContent.BackgroundTransparency = 1
    tabContent.BorderSizePixel = 0
    tabContent.ScrollBarThickness = 3
    tabContent.ScrollBarImageColor3 = Config.Colors.Primary
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabContent.Visible = false 
    tabContent.ZIndex = 60 -- ✅ إجبار المحتوى على الظهور
    tabContent.Parent = ContentArea

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Parent = tabContent

    local function selectTab()
        for _, child in ipairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Config.Colors.TabBg
                local txt = child:FindFirstChildOfClass("TextLabel")
                if txt then txt.TextColor3 = Config.Colors.TabText end
            end
        end
        for _, child in ipairs(ContentArea:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end

        tabBtn.BackgroundColor3 = Config.Colors.TabActive
        label.TextColor3 = Config.Colors.TabTextActive
        tabContent.Visible = true
        activeTab = tabContent
    end

    tabBtn.MouseButton1Click:Connect(selectTab)

    if not activeTab then
        selectTab()
    end

    return tabContent
end

function DMenu.CreateSection(parentTab, name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    section.BackgroundTransparency = 0.2
    section.BorderSizePixel = 0
    section.LayoutOrder = nextOrder()
    section.ZIndex = 61
    section.Parent = parentTab
    makeCorner(section, 8)
    makeStroke(section, Config.Colors.PrimaryDarker, 1)

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 10)
    pad.PaddingRight = UDim.new(0, 10)
    pad.Parent = section

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = section

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 22)
    title.BackgroundTransparency = 1
    title.Font = Config.FontBlack
    title.Text = name
    title.TextColor3 = Config.Colors.Primary
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.LayoutOrder = 0
    title.ZIndex = 62
    title.Parent = section

    return section
end

function DMenu.CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.BackgroundColor3 = Config.Colors.Element
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.LayoutOrder = nextOrder()
    btn.ZIndex = 62
    btn.Parent = parent
    makeCorner(btn, 6)
    makeStroke(btn, Config.Colors.PrimaryDarker, 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.Text
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 63
    label.Parent = btn

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Colors.ElementHover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Config.Colors.Element}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        if callback then task.spawn(callback) end
    end)
    return btn
end

function DMenu.CreateToggle(parent, text, default, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, 0, 0, 34)
    container.BackgroundColor3 = Config.Colors.Element
    container.BorderSizePixel = 0
    container.Text = ""
    container.AutoButtonColor = false
    container.LayoutOrder = nextOrder()
    container.ZIndex = 62
    container.Parent = parent
    makeCorner(container, 6)
    makeStroke(container, Config.Colors.PrimaryDarker, 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.Text
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 63
    label.Parent = container

    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 38, 0, 20)
    track.Position = UDim2.new(1, -48, 0.5, -10)
    track.BackgroundColor3 = Config.Colors.ToggleOff
    track.BorderSizePixel = 0
    track.ZIndex = 63
    track.Parent = container
    makeCorner(track, 10).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
    knob.BorderSizePixel = 0
    knob.ZIndex = 64
    knob.Parent = track
    makeCorner(knob, 8).CornerRadius = UDim.new(1, 0)

    local state = default or false

    local function render(animate)
        local knobPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local trackColor = state and Config.Colors.ToggleOn or Config.Colors.ToggleOff
        if animate then
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = knobPos}):Play()
            TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = trackColor}):Play()
        else
            knob.Position = knobPos
            track.BackgroundColor3 = trackColor
        end
    end
    render(false)

    container.MouseButton1Click:Connect(function()
        state = not state
        render(true)
        if callback then task.spawn(callback, state) end
    end)

    return {
        Frame = container,
        Get = function() return state end,
        Set = function(v)
            state = v
            render(true)
            if callback then task.spawn(callback, state) end
        end,
    }
end

function DMenu.CreateSlider(parent, text, minVal, maxVal, default, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundColor3 = Config.Colors.Element
    container.BorderSizePixel = 0
    container.LayoutOrder = nextOrder()
    container.ZIndex = 62
    container.Parent = parent
    makeCorner(container, 6)
    makeStroke(container, Config.Colors.PrimaryDarker, 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -80, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 6)
    label.BackgroundTransparency = 1
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.Text
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 63
    label.Parent = container

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 70, 0, 20)
    valueLabel.Position = UDim2.new(1, -80, 0, 6)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Font = Config.Font
    valueLabel.TextColor3 = Config.Colors.Primary
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.ZIndex = 63
    valueLabel.Parent = container

    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -20, 0, 8)
    barBg.Position = UDim2.new(0, 10, 0, 32)
    barBg.BackgroundColor3 = Config.Colors.PrimaryDarker
    barBg.BorderSizePixel = 0
    barBg.ZIndex = 63
    barBg.Parent = container
    makeCorner(barBg, 4).CornerRadius = UDim.new(1, 0)

    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Config.Colors.Primary
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 64
    barFill.Parent = barBg
    makeCorner(barFill, 4).CornerRadius = UDim.new(1, 0)

    local value = default
    local dragInput

    local function setValue(v, fire)
        v = math.clamp(v, minVal, maxVal)
        value = v
        local ratio = (maxVal == minVal) and 0 or (v - minVal) / (maxVal - minVal)
        barFill.Size = UDim2.new(ratio, 0, 1, 0)
        valueLabel.Text = tostring(math.floor(v * 100 + 0.5) / 100)
        if fire and callback then task.spawn(callback, v) end
    end

    local function updateFromInput(input)
        local relX = input.Position.X - barBg.AbsolutePosition.X
        local ratio = math.clamp(relX / barBg.AbsoluteSize.X, 0, 1)
        setValue(minVal + ratio * (maxVal - minVal), true)
    end

    barBg.InputBegan:Connect(function(input)
        if dragInput then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            updateFromInput(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragInput ~= input then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateFromInput(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if dragInput == input then dragInput = nil end
    end)

    setValue(default, false)

    return {
        Frame = container,
        Get = function() return value end,
        Set = function(v) setValue(v, true) end,
    }
end

function DMenu.CreateLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Font = Config.Font
    label.Text = text
    label.TextColor3 = Config.Colors.TextDim
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = nextOrder()
    label.ZIndex = 63
    label.Parent = parent
    return label
end

function DMenu.CreateDivider(parent)
    local div = Instance.new("Frame")
    div.Size = UDim2.new(1, 0, 0, 1)
    div.BackgroundColor3 = Config.Colors.PrimaryDarker
    div.BackgroundTransparency = 0.4
    div.BorderSizePixel = 0
    div.LayoutOrder = nextOrder()
    div.ZIndex = 63
    div.Parent = parent
    return div
end



local mainTab = DMenu.CreateTab("رئيسي")

local mainSection = DMenu.CreateSection(mainTab, "التحكم")
DMenu.CreateLabel(mainSection, "مرحباً بك!")
DMenu.CreateDivider(mainSection)
DMenu.CreateButton(mainSection, "تجربة الزر", function()
    print("تم الضغط!")
end)
DMenu.CreateToggle(mainSection, "ميزة", false, function(state)
    print("الحالة:", state)
end)
DMenu.CreateSlider(mainSection, "السرعة", 1, 100, 50, function(value)
    print("القيمة:", value)
end)

local otherTab = DMenu.CreateTab("إعدادات")
local otherSection = DMenu.CreateSection(otherTab, "عام")
DMenu.CreateLabel(otherSection, "هنا الإعدادات.")

-- getgenv().DMenu = DMenu
