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
  if props then
    SetProps(new, props)
  end
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
  
  if props then
    SetProps(new, props)
  end
  return new
end

local function CreateTween(instance, prop, value, time, tweenWait)
  local tween = TweenService:Create(instance,
  TweenInfo.new(time, Enum.EasingStyle.Linear),
  {[prop] = value})
  tween:Play()
  if tweenWait then
    tween.Completed:Wait()
  end
end

local existing = CoreGui:FindFirstChild("REDz HUB library")
if existing then existing:Destroy() end

local ScreenGui = Create("ScreenGui", CoreGui, {
  Name = "REDz HUB library",
  ResetOnSpawn = false,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

local IntroGui = Create("ScreenGui", CoreGui, {
  Name = "AMAR_Intro",
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
  Text = "AMAR~HUB",
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

function DestroyScript()
  ScreenGui:Destroy()
end

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

function MakeNotifi(Configs)
  local Title = Configs.Title or "HUB ~VRX"
  local text = Configs.Text or "Notification"
  local timewait = Configs.Time or 5
  
  local Frame1 = Create("Frame", Menu_Notifi, {
    Size = UDim2.new(2, 0, 0, 0),
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.Y,
    Name = "Title"
  })
  
  local Frame2 = Create("Frame", Frame1, {
    Size = UDim2.new(0, Menu_Notifi.Size.X.Offset - 50, 0, 0),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y
  })
  Corner(Frame2)
  Stroke(Frame2)
  
  Create("TextLabel", Frame2, {
    Size = UDim2.new(1, -40, 0, 25),
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    Text = Title,
    TextSize = 18,
    Position = UDim2.new(0, 15, 0, 5),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextColor3 = Configs_HUB.Cor_Stroke
  })
  
  local CloseBtn = Create("TextButton", Frame2, {
    Text = "×",
    Font = Configs_HUB.Text_Font,
    TextSize = 22,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Position = UDim2.new(1, -5, 0, 5),
    AnchorPoint = Vector2.new(1, 0),
    Size = UDim2.new(0, 25, 0, 25)
  })
  
  Create("TextLabel", Frame2, {
    Size = UDim2.new(1, -30, 0, 0),
    Position = UDim2.new(0, 15, 0, 35),
    TextSize = 14,
    TextColor3 = Configs_HUB.Cor_Text,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    AutomaticSize = Enum.AutomaticSize.Y,
    Text = text,
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    TextWrapped = true
  })
  
  local FrameSize = Create("Frame", Frame2, {
    Size = UDim2.new(1, -4, 0, 2),
    BackgroundColor3 = Configs_HUB.Cor_Stroke,
    Position = UDim2.new(0, 2, 0, 30),
    BorderSizePixel = 0
  })
  Corner(FrameSize)
  
  task.spawn(function()
    CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0, 2), timewait, true)
  end)
  
  CloseBtn.MouseButton1Click:Connect(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
    CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
    Frame1:Destroy()
  end)
  
  task.spawn(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true)
    CreateTween(Frame2, "Position", UDim2.new(), 0.1, true)
    task.wait(timewait)
    if Frame2 and Frame2.Parent then
      CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
      CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
      Frame1:Destroy()
    end
  end)
end

function MakeWindow(Configs)
  local title = Configs.Hub.Title or "HUB ~VRX"
  
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
    Text = title,
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
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    BackgroundTransparency = 1,
    Font = Configs_HUB.Text_Font,
    TextSize = 25
  })
  
  local function CreateClose()
    IsMinimized = false
    Minimize_BTN.Text = "-"
    CreateTween(Menu, "Size", UDim2.new(0, 500, 0, 270), 0.3, false)
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
      Position = UDim2.new(0.9, 0, 0.5, 0),
      AnchorPoint = Vector2.new(1, 0),
      BackgroundColor3 = Configs_HUB.Cor_Hub,
      Text = "Cancel",
      Font = Configs_HUB.Text_Font,
      TextColor3 = Configs_HUB.Cor_DarkText,
      TextSize = 20
    })
    Corner(Cancel)
    Stroke(Cancel)
    
    Cancel.MouseButton1Click:Connect(function()
      CloseGui:Destroy()
    end)
    
    Confirm.MouseButton1Click:Connect(function()
      CloseGui:Destroy()
      DestroyScript()
    end)
  end
  
  Close_Button.MouseButton1Click:Connect(CreateClose)
  
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
  Create("UIListLayout", ScrollBar, {
    Padding = UDim.new(0, 5)
  })
  
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
  
  Add_Line({Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, TopBar.Size.Y.Offset)})
  Add_Line({Size = UDim2.new(0, 1, 1, -(TopBar.Size.Y.Offset + 1)), Position = UDim2.new(0, ScrollBar.Size.X.Offset, 0, TopBar.Size.Y.Offset)})
  
  local firstVisible = true
  local textsize = 15
  local textcolor = Configs_HUB.Cor_Text
  
  function MakeTab(Configs)
    local TabName = Configs.Name or "Tab"
    local TabTitle = Configs.TabTitle or false
    
    local Frame = Create("Frame", ScrollBar, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundTransparency = 1
    })
    Corner(Frame)
    Stroke(Frame)
    
    local TextButton = Create("TextButton", Frame, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      Text = ""
    })
    
    local TextLabel = Create("TextLabel", Frame, {
      Size = UDim2.new(1, -5, 1, 0),
      Position = UDim2.new(0, 5, 0, 0),
      BackgroundTransparency = 1,
      Font = Configs_HUB.Text_Font,
      TextColor3 = textcolor,
      TextSize = textsize,
      Text = TabName,
      TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local Container = Create("ScrollingFrame", Containers, {
      Size = UDim2.new(1, 0, 1, 0),
      ScrollingDirection = Enum.ScrollingDirection.Y,
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      CanvasSize = UDim2.new(),
      BackgroundTransparency = 1,
      ScrollBarThickness = 2,
      Visible = firstVisible
    })
    
    Create("UIPadding", Container, {
      PaddingLeft = UDim.new(0, 10),
      PaddingRight = UDim.new(0, 10),
      PaddingTop = UDim.new(0, 10),
      PaddingBottom = UDim.new(0, 10)
    })
    
    Create("UIListLayout", Container, {
      Padding = UDim.new(0, 5)
    })
    
    if TabTitle then
      Create("TextLabel", Container, {
        BackgroundTransparency = 1,
        Text = "#" .. string.gsub(TabName, " ", "-"),
        TextSize = 22,
        Font = Configs_HUB.Text_Font,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Configs_HUB.Cor_Stroke,
        Size = UDim2.new(1, 0, 0, 25),
        Name = "Frame"
      })
    end
    
    TextButton.MouseButton1Click:Connect(function()
      ClickSound:Play()
      for _, container in pairs(Containers:GetChildren()) do
        if container:IsA("ScrollingFrame") then
          container.Visible = false
        end
      end
      for _, frame in pairs(ScrollBar:GetChildren()) do
        if frame:IsA("Frame") then
          local lbl = frame:FindFirstChildOfClass("TextLabel")
          if lbl and lbl ~= TextLabel then
            CreateTween(lbl, "TextColor3", Configs_HUB.Cor_DarkText, 0.3, false)
            lbl.TextSize = 14
          end
        end
      end
      Container.Visible = true
      CreateTween(TextLabel, "TextColor3", Configs_HUB.Cor_Text, 0.3, false)
      TextLabel.TextSize = 15
    end)
    
    firstVisible = false
    textsize = 14
    textcolor = Configs_HUB.Cor_DarkText
    
    return Container
  end
  
  function AddButton(parent, Configs)
    local ButtonName = Configs.Name or "Button!!"
    local Callback = Configs.Callback or function() end
    
    local TextButton = Create("TextButton", parent, {
      Size = UDim2.new(1, 0, 0, 25),
      BackgroundColor3 = Configs_HUB.Cor_Options,
      Name = "Frame",
      Text = "",
      AutoButtonColor = false
    })
    Corner(TextButton)
    Stroke(TextButton)
    
    local TextLabel = Create("TextLabel", TextButton, {
      TextSize = 12,
      TextColor3 = Configs_HUB.Cor_Text,
      Text = ButtonName,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 35, 0, 0),
      BackgroundTransparency = 1,
      TextXAlignment = Enum.TextXAlignment.Left,
      Font = Configs_HUB.Text_Font
    })
    
    local ImageLabel = Create("ImageLabel", TextButton, {
      Image = "rbxassetid://99956220697276",
      Size = UDim2.new(0, 20, 0, 20),
      Position = UDim2.new(0, 5, 0, 2.5),
      BackgroundTransparency = 1,
      ImageColor3 = Configs_HUB.Cor_Stroke
    })
    
    TextButton.MouseButton1Click:Connect(function()
      Callback()
      CreateTween(ImageLabel, "ImageColor3", Color3.fromRGB(200, 30, 30), 0.2, true)
      CreateTween(ImageLabel, "ImageColor3", Configs_HUB.Cor_Stroke, 0.2, false)
    end)
    
    return TextButton
  end

  return Menu
end

local Window = MakeWindow({
    Hub = {
        Title = "AMAR ~ HUB"
    }
})

local function CreateSectionBox(parent, titleText, customHeight)
    local box = Create("Frame", parent, {
        Size = UDim2.new(1, 0, 0, customHeight or 90),
        BackgroundColor3 = Configs_HUB.Cor_Options
    })
    Corner(box)
    Stroke(box)
    Create("TextLabel", box, {
        Size = UDim2.new(1, -10, 0, 20),
        Position = UDim2.new(0, 5, 0, 4),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = Configs_HUB.Cor_Stroke,
        Font = Configs_HUB.Text_Font,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    return box
end

local TabScripts = MakeTab({Name = "سكربتات صمله", TabTitle = true})
local TabCommands = MakeTab({Name = "اوامر صمله"})
local TabLag = MakeTab({Name = "تقليل لاق"})
local TabRights = MakeTab({Name = "حقوق"})

AddButton(TabScripts, {Name = "سكربت زيكو", Callback = function() pcall(function() loadstring(game:HttpGet('https://pastefy.app/mXMaE9fC/raw'))() end) end})
AddButton(TabScripts, {Name = "سكربت عسكر", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-3skr-hub-240894"))() end) end})
AddButton(TabScripts, {Name = "سكربت HUB الأساسي", Callback = function() pcall(function() loadstring(game:HttpGet("https://gist.githubusercontent.com/adamoalihossen-lang/1fcc9f47858217b73c7d21396347ee41/raw"))() end) end})
AddButton(TabScripts, {Name = "سكربت المنيوك (معرف كلمه السر) حكومة", Callback = function() pcall(function() loadstring(game:HttpGet('https://pastebin.com/raw/FMC7ZWsw'))() end) end})
AddButton(TabScripts, {Name = "سكربت انصاري", Callback = function() pcall(function() loadstring(game:HttpGet("https://gist.githubusercontent.com/Yemenx/e976b6c7c681e67ebe0f31f88ebb6ac6/raw/536a222c673c23ba43ebe29dfcc29a53c8808eea/ANSRY.YAMEN.VAMPAIRE.lua"))() end) end})
AddButton(TabScripts, {Name = "سكربت أبو عتب", Callback = function() pcall(function() loadstring(game:HttpGet("https://gist.githubusercontent.com/yhmwd406-boop/2dd250fe58d63fabee981b085afc10c5/raw/8bf78e204f3f04cac8bea68e887a95f41c8b81c4/%25D8%25B3%25D9%2583%25D8%25B1%25D8%25A8%25D8%25AA%2520%25D8%25B9%25D8%25AF%25D8%25A7%25D8%25A7%25D8%25AA"))() end) end})
AddButton(TabScripts, {Name = "تشغيل وتخفيف لاق", Callback = function() pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 for _, v in pairs(workspace:GetDescendants()) do if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 end end end) end})
AddButton(TabScripts, {Name = "مضاد لاق", Callback = function() pcall(function() for _, v in pairs(game:GetService("Lighting"):GetChildren()) do if v:IsA("PostEffect") then v.Enabled = false end end end) end})
AddButton(TabScripts, {Name = "سكربت داركو", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Zenix-all-on-one-240296"))() end) end})
AddButton(TabScripts, {Name = "سكربت نقاط مراد", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-NO9AT-SAMLAT-47637"))() end) end})
AddButton(TabScripts, {Name = "مضاد تطير", Callback = function() local p = game.Players.LocalPlayer if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then p.Character.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5) end end})
AddButton(TabScripts, {Name = "مضاد طرد قوي", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AntiAFK-v-AntiKick-V3-v-Kick-Attempt-Logger-27977"))() end) end})
AddButton(TabScripts, {Name = "مضاد افك (Anti-AFK)", Callback = function() local vu = game:GetService("VirtualUser") game:GetService("Players").LocalPlayer.Idled:Connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) task.wait(1) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end) end})
AddButton(TabScripts, {Name = "سكربت عزام", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-3azaam-hub-224262"))() end) end})
AddButton(TabScripts, {Name = "سكربت افك", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ANTI-AFK-by-gun-265109"))() end) end})
AddButton(TabScripts, {Name = "سكربت ادمن ميكي شات", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-ITMEANS-ULTIMATEX-234677"))() end) end})
AddButton(TabScripts, {Name = "سكربت ميكي شات", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Mickey-Chat-85762"))() end) end})
AddButton(TabScripts, {Name = "سكربت خاروش بن مخرش", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AV8-113421"))() end) end})
AddButton(TabScripts, {Name = "سكربت REXM", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-REXM-206004"))() end) end})
AddButton(TabScripts, {Name = "سكربت ABD", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-ABD-HUB-PRO-238979"))() end) end})
AddButton(TabScripts, {Name = "طيران عدنان", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Flying-55336"))() end) end})
AddButton(TabScripts, {Name = "سكربت JG", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-New-Update-Script-JG-Brookhaven-93130"))() end) end})
AddButton(TabScripts, {Name = "رافكس سكربت زين", Callback = function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-RAVEX-HUB-ARAB-NOW-86210"))() end) end})

local function SendChatCommand(cmd)
    pcall(function()
        local chatEvents = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents and chatEvents:FindFirstChild("SayMessageRequest") then
            chatEvents.SayMessageRequest:FireServer(cmd, "All")
            return
        end
        local TextChatService = game:GetService("TextChatService")
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channels = TextChatService:FindFirstChild("TextChannels")
            if channels and channels:FindFirstChild("RBXGeneral") then
                channels.RBXGeneral:SendAsync(cmd)
            end
        end
    end)
end

local commandList = {
    "nofog",
    "autokeypress",
    "autokeypress nan",
    "2022materials",
    "clearerror",
    "antilag",
    "backtrack nan",
    "xray",
    "antiafk",
    "antikick",
    "backtrack 999",
    "datalimit 660",
    "Replicationlag 999"
}

local commandsBox = CreateSectionBox(TabCommands, "اوامر صمله", 40 + (#commandList * 30))
for i, cmdText in ipairs(commandList) do
    local btn = Create("TextButton", commandsBox, {
        Size = UDim2.new(0.97, 0, 0, 25),
        Position = UDim2.new(0, 5, 0, 26 + ((i - 1) * 30)),
        BackgroundColor3 = Configs_HUB.Cor_Hub,
        Text = cmdText,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 11,
        Font = Configs_HUB.Text_Font,
        AutoButtonColor = false
    })
    Corner(btn)
    Stroke(btn)
    btn.MouseButton1Click:Connect(function()
        SendChatCommand(":" .. cmdText)
        MakeNotifi({Title = "اوامر صمله", Text = "تم إرسال الأمر: " .. cmdText, Time = 2})
    end)
end

local lagEnabled = false
local savedTransparencies = {}

local function isCharacterPart(part)
    local model = part:FindFirstAncestorOfClass("Model")
    if model and model:FindFirstChildOfClass("Humanoid") then return true end
    return false
end

local function enableXrayAndAntilag()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not isCharacterPart(v) then
            if v.Transparency < 1 then
                savedTransparencies[v] = v.Transparency
                v.Transparency = 0.7
            end
        end
    end
    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
    end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end
end

local function disableXrayAndAntilag()
    for part, trans in pairs(savedTransparencies) do
        if part and part.Parent then
            part.Transparency = trans
        end
    end
    savedTransparencies = {}
    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = true end
    end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            v.Enabled = true
        end
    end
end

local lagBtn = AddButton(TabLag, {
    Name = "~تقليل لاق~",
    Callback = function()
        lagEnabled = not lagEnabled
        if lagEnabled then
            enableXrayAndAntilag()
            lagBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            MakeNotifi({Title = "تقليل لاق", Text = "تم تفعيل Xray و Antilag", Time = 3})
        else
            disableXrayAndAntilag()
            lagBtn.BackgroundColor3 = Configs_HUB.Cor_Options
            MakeNotifi({Title = "تقليل لاق", Text = "تم إلغاء Xray و Antilag", Time = 3})
        end
    end
})

local creditsBox = Create("Frame", TabRights, {
    Size = UDim2.new(1, 0, 0, 200),
    BackgroundColor3 = Configs_HUB.Cor_Options
})
Corner(creditsBox)
Stroke(creditsBox)

Create("TextLabel", creditsBox, {
    Size = UDim2.new(1, -20, 1, -10),
    Position = UDim2.new(0, 10, 0, 5),
    BackgroundTransparency = 1,
    Text = "+++\nهذا السكربت من تطوير عمار و معلمه لانشر\n+++\nلا يسمح ب أحد استخدامه من اي احد الا عمار ولانشر\n+++\nكسخت كل واحد يستخدم السكربت من غير أذن\n+++\nوالسلام عليكم",
    TextColor3 = Configs_HUB.Cor_Text,
    Font = Configs_HUB.Text_Font,
    TextSize = 14,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Top
})

AddButton(TabRights, {
    Name = "amar_2557",
    Callback = function()
        pcall(function() setclipboard("https://www.tiktok.com/@amar_2557") end)
        pcall(function() game:GetService("GuiService"):OpenBrowserWindow("https://www.tiktok.com/@amar_2557") end)
        MakeNotifi({Title = "حقوق", Text = "تم نسخ رابط تيك توك: amar_2557", Time = 4})
    end
})
