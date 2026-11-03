local Configs_HUB = {
    Cor_Hub = Color3.fromRGB(15, 15, 15),
    Cor_Options = Color3.fromRGB(28, 28, 28),
    Cor_Stroke = Color3.fromRGB(255, 50, 50),
    Cor_Text = Color3.fromRGB(255, 255, 255),
    Cor_DarkText = Color3.fromRGB(150, 150, 150),
    Corner_Radius = UDim.new(0, 12),
    Text_Font = Enum.Font.FredokaOne
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://6895079853"
ClickSound.Volume = 1.5
ClickSound.Parent = SoundService

local function Create(instance, parent, props)
    local new = Instance.new(instance, parent)
    if props then
        for prop, value in pairs(props) do
            new[prop] = value
        end
    end
    return new
end

local function SetProps(instance, props)
    if instance and props then
        for prop, value in pairs(props) do
            instance[prop] = value
        end
    end
    return instance
end

local function Corner(parent, props)
    local new = Create("UICorner", parent)
    new.CornerRadius = Configs_HUB.Corner_Radius
    if props then SetProps(new, props) end
    return new
end

local function Stroke(parent, props)
    local new = Create("UIStroke", parent)
    new.Color = Configs_HUB.Cor_Stroke
    new.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    new.Thickness = 2
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
    }
    gradient.Rotation = 0
    gradient.Parent = new
    coroutine.wrap(function()
        while new.Parent do
            gradient.Rotation = (gradient.Rotation + 2) % 360
            RunService.RenderStepped:Wait()
        end
    end)()
    if props then SetProps(new, props) end
    return new
end

local function CreateTween(instance, prop, value, time, tweenWait)
    local tween = TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Linear), {[prop] = value})
    tween:Play()
    if tweenWait then
        tween.Completed:Wait()
    end
end

local function TextSetColor(instance)
    instance.MouseEnter:Connect(function()
        CreateTween(instance, "TextColor3", Color3.fromRGB(255, 150, 150), 0.3, false)
    end)
    instance.MouseLeave:Connect(function()
        CreateTween(instance, "TextColor3", Configs_HUB.Cor_Text, 0.3, false)
    end)
end

local existing = CoreGui:FindFirstChild("REDz HUB library")
if existing then
    existing:Destroy()
end

local ScreenGui = Create("ScreenGui", CoreGui, {
    Name = "REDz HUB library",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local IntroGui = Create("ScreenGui", CoreGui, {
    Name = "XR7_Intro",
    ResetOnSpawn = false
})

local Menu = Create("Frame", ScreenGui, {
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0.5, -500/2, 0.5, -270/2),
    Active = true,
    Draggable = true,
    Size = UDim2.new(0, 500, 0, 270),
    Visible = false
})
Corner(Menu)
Stroke(Menu)

local HubBGImage = Create("ImageLabel", Menu, {
    Name = "HubBackground",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = "rbxassetid://118002360765644",
    ImageTransparency = 0.3,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0
})
Corner(HubBGImage)

local TopBar = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 25),
    ZIndex = 2
})

local RotatingImage = Create("ImageLabel", TopBar, {
    Name = "RotatingLogo",
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(0, 2, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundTransparency = 1,
    Image = "rbxassetid://106176016019821",
    ZIndex = 3
})
Corner(RotatingImage, {CornerRadius = UDim.new(1, 0)})

task.spawn(function()
    local rotation = 0
    while RotatingImage and RotatingImage.Parent do
        rotation = (rotation + 1) % 360
        RotatingImage.Rotation = rotation
        task.wait(0.016)
    end
end)

local TitleLabel = Create("TextLabel", TopBar, {
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 25, 0, 0),
    TextColor3 = Color3.fromRGB(255, 0, 0),
    Font = Configs_HUB.Text_Font,
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "XR7 ~ Gaheem",
    TextSize = 20,
    BackgroundTransparency = 1
})

task.spawn(function()
    while TitleLabel and TitleLabel.Parent do
        CreateTween(TitleLabel, "TextColor3", Color3.fromRGB(35, 0, 0), 0.8, true)
        CreateTween(TitleLabel, "TextColor3", Color3.fromRGB(255, 40, 40), 0.8, true)
    end
end)

local ButtonsFrame = Create("Frame", TopBar, {
    Size = UDim2.new(0, 40, 1, -5),
    Position = UDim2.new(1, -10, 0, 2.5),
    AnchorPoint = Vector2.new(1, 0),
    BackgroundTransparency = 1
})

local Minimize_BTN = Create("TextButton", ButtonsFrame, {
    Text = "-",
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextYAlignment = Enum.TextYAlignment.Bottom,
    TextSize = 25
})

local IsMinimized = false
Minimize_BTN.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    Minimize_BTN.Text = IsMinimized and "+" or "-"
    local targetHeight = IsMinimized and 35 or 270
    CreateTween(Menu, "Size", UDim2.new(0, 500, 0, targetHeight), 0.15, false)
end)

local Close_Button = Create("TextButton", ButtonsFrame, {
    Text = "×",
    TextYAlignment = Enum.TextYAlignment.Bottom,
    TextColor3 = Configs_HUB.Cor_Text,
    Size = UDim2.new(0.5, 0, 1, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextSize = 25
})

local line_Containers = Create("Frame", Menu, {
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 2
})

local ScrollBar = Create("ScrollingFrame", Menu, {
    Size = UDim2.new(0, 140, 1, -(TopBar.Size.Y.Offset + 2)),
    Position = UDim2.new(0, 0, 1, 0),
    AnchorPoint = Vector2.new(0, 1),
    CanvasSize = UDim2.new(),
    ScrollingDirection = Enum.ScrollingDirection.Y,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    ScrollBarThickness = 2,
    ZIndex = 2
})
Create("UIPadding", ScrollBar, {
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10)
})
Create("UIListLayout", ScrollBar, { Padding = UDim.new(0, 5) })

local Containers = Create("Frame", Menu, {
    Size = UDim2.new(1, -(ScrollBar.Size.X.Offset + 2), 1, -(TopBar.Size.Y.Offset + 2)),
    AnchorPoint = Vector2.new(1, 1),
    Position = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    ZIndex = 2
})
Corner(Containers)

local function Add_Line(props)
    local line = Create("Frame", line_Containers, props)
    line.BackgroundColor3 = Configs_HUB.Cor_Stroke
    line.BorderSizePixel = 0
end

Add_Line({
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)
})
Add_Line({
    Size = UDim2.new(0, 1, 1, -(TopBar.Size.Y.Offset + 1)),
    Position = UDim2.new(0, ScrollBar.Size.X.Offset, 0, TopBar.Size.Y.Offset)
})
