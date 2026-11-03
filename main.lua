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
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

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

local existing = CoreGui:FindFirstChild("REDz HUB library")
if existing then existing:Destroy() end

local started = false

local function StartScript()
    if started then return end
    started = true

    local ScreenGui = Create("ScreenGui", CoreGui, {
        Name = "REDz HUB library",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local IntroGui = Create("ScreenGui", CoreGui, {
        Name = "𝑮𝑮_Intro",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })

    local IntroBG = Create("Frame", IntroGui, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0
    })

    local IntroText = Create("TextLabel", IntroBG, {
        Size = UDim2.new(0, 400, 0, 100),
        Position = UDim2.new(0.5, -200, 0.5, -50),
        BackgroundTransparency = 1,
        Font = Configs_HUB.Text_Font,
        Text = "𝑮𝑮~𝒍𝒂𝒏𝒔𝒉𝒆𝒓",
        TextSize = 35,
        TextColor3 = Color3.fromRGB(255, 0, 0),
        TextScaled = true
    })

    task.spawn(function()
        while IntroGui and IntroGui.Parent do
            CreateTween(IntroText, "TextColor3", Color3.fromRGB(40, 0, 0), 0.5, true)
            CreateTween(IntroText, "TextColor3", Color3.fromRGB(255, 50, 50), 0.5, true)
        end
    end)

    task.wait(2)
    CreateTween(IntroBG, "BackgroundTransparency", 1, 0.5, false)
    CreateTween(IntroText, "TextTransparency", 1, 0.5, true)
    IntroGui:Destroy()

    local OpenHubButton = Create("ImageButton", ScreenGui, {
        Size = UDim2.new(0, 60, 0, 60),
        Position = UDim2.new(0, 30, 0.5, -30),
        BackgroundColor3 = Configs_HUB.Cor_Options,
        Image = "rbxassetid://106176016019821",
        Active = true,
        Draggable = true,
        AutoButtonColor = false
    })
    Corner(OpenHubButton, {CornerRadius = UDim.new(1, 0)})
    Stroke(OpenHubButton)

    local Menu_Notifi = Create("Frame", ScreenGui, {
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1
    })
    Create("UIPadding", Menu_Notifi, {
        PaddingLeft = UDim.new(0, 25),
        PaddingTop = UDim.new(0, 25),
        PaddingBottom = UDim.new(0, 50)
    })
    Create("UIListLayout", Menu_Notifi, {
        Padding = UDim.new(0, 15),
        VerticalAlignment = Enum.VerticalAlignment.Bottom
    })

    local Menu = Create("Frame", ScreenGui, {
        BackgroundColor3 = Configs_HUB.Cor_Hub,
        Position = UDim2.new(0.5, -500/2, 0.5, -320/2),
        Active = true,
        Draggable = true,
        Size = UDim2.new(0, 500, 0, 320),
        Visible = false
    })
    Corner(Menu)
    Stroke(Menu)

    OpenHubButton.MouseButton1Click:Connect(function()
        Menu.Visible = not Menu.Visible
    end)

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

    local TitleLabel = Create("TextLabel", TopBar, {
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Font = Configs_HUB.Text_Font,
        Text = "𝑮𝑮 ~ 𝒍𝒂𝒏𝒔𝒉𝒆𝒓",
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255, 40, 40),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3
    })

    coroutine.wrap(function()
        while TitleLabel and TitleLabel.Parent do
            CreateTween(TitleLabel, "TextColor3", Color3.fromRGB(35, 0, 0), 0.8, true)
            CreateTween(TitleLabel, "TextColor3", Color3.fromRGB(255, 40, 40), 0.8, true)
        end
    end)()

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
        local targetHeight = IsMinimized and 35 or 320
        CreateTween(Menu, "Size", UDim2.new(0, 500, 0, targetHeight), 0.15, false)
    end)

    local Close_Button = Create("TextButton", ButtonsFrame, {
        Text = "×",
        TextYAlignment = Enum.TextYAlignment.Bottom,
        TextColor3 = Configs_HUB.Cor_Text,
        Size = UDim2.new(0.5, 0, 1, 0),
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        Font = Configs_HUB.Text_Font,
        TextSize = 25
    })

    local function CreateClose()
        IsMinimized = false
        Minimize_BTN.Text = "-"
        CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 320), 0.3, false)

        local CloseGui = Create("TextButton", Menu, {
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            Size = UDim2.new(1, 0, 1, 0),
            AutoButtonColor = false,
            Text = "",
            BackgroundTransparency = 0.5,
            ZIndex = 5
        })
        Corner(CloseGui)

        local CloseMenu = Create("Frame", CloseGui, {
            Size = UDim2.new(0.7, 0, 0.7, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = Configs_HUB.Cor_Hub
        })
        Corner(CloseMenu)
        Stroke(CloseMenu)

        Create("TextLabel", CloseMenu, {
            Size = UDim2.new(0.8, 0, 0.25, 0),
            Text = "Are you sure you want to close this script?",
            Position = UDim2.new(0.1, 0, 0.2, 0),
            TextColor3 = Configs_HUB.Cor_Text,
            Font = Configs_HUB.Text_Font,
            TextScaled = true,
            BackgroundTransparency = 1
        })

        local Confirm = Create("TextButton", CloseMenu, {
            Size = UDim2.new(0.35, 0, 0.3, 0),
            Position = UDim2.new(0.1, 0, 0.5, 0),
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            Text = "Close Script",
            Font = Configs_HUB.Text_Font,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 20
        })
        Corner(Confirm)
        Stroke(Confirm)

        local Cancel = Create("TextButton", CloseMenu, {
            Size = UDim2.new(0.35, 0, 0.3, 0),
            Position = UDim2.new(0.55, 0, 0.5, 0),
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            Text = "Cancel",
            Font = Configs_HUB.Text_Font,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 20
        })
        Corner(Cancel)
        Stroke(Cancel)

        Confirm.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)
        Cancel.MouseButton1Click:Connect(function()
            CloseGui:Destroy()
        end)
    end

    Close_Button.MouseButton1Click:Connect(CreateClose)

    local line_Containers = Create("Frame", Menu, {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 2
    })

    local function Add_Line(props)
        local line = Create("Frame", line_Containers, props)
        line.BackgroundColor3 = Configs_HUB.Cor_Stroke
        line.BorderSizePixel = 0
    end

    Add_Line({Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)})
end

StartScript()
