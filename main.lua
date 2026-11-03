--[[
    واجهة فقط - بدون تبويبات وبدون أي محتوى
    لا يوجد: تبويبات / أزرار داخلية / loadstring / HttpGet / أي تنفيذ
    فقط: نافذة رئيسية + شريط علوي + زر إغلاق
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("XR7_Gaheem_UI")
if old then old:Destroy() end

local function new(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    if parent then obj.Parent = parent end
    return obj
end

local gui = new("ScreenGui", {
    Name = "XR7_Gaheem_UI",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local main = new("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(620, 420),
    BackgroundColor3 = Color3.fromRGB(18, 18, 22),
    BorderSizePixel = 0,
}, gui)

new("UICorner", { CornerRadius = UDim.new(0, 14) }, main)
new("UIStroke", {
    Color = Color3.fromRGB(70, 70, 85),
    Thickness = 1,
}, main)

local top = new("Frame", {
    Name = "TopBar",
    Size = UDim2.new(1, 0, 0, 46),
    BackgroundColor3 = Color3.fromRGB(25, 25, 32),
    BorderSizePixel = 0,
}, main)

new("UICorner", { CornerRadius = UDim.new(0, 14) }, top)

new("TextLabel", {
    Name = "Title",
    Position = UDim2.fromOffset(16, 0),
    Size = UDim2.new(1, -100, 1, 0),
    BackgroundTransparency = 1,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(235, 235, 245),
    TextXAlignment = Enum.TextXAlignment.Left,
    Text = "XR7 ~ Gaheem",
}, top)

local close = new("TextButton", {
    Name = "Close",
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -10, 0.5, 0),
    Size = UDim2.fromOffset(30, 30),
    BackgroundColor3 = Color3.fromRGB(45, 45, 55),
    Text = "×",
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 120, 120),
    AutoButtonColor = true,
}, top)

new("UICorner", { CornerRadius = UDim.new(0, 8) }, close)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- منطقة محتوى فارغة (جاهزة لأي شيء تبي تحطه لاحقًا)
local content = new("Frame", {
    Name = "Content",
    Position = UDim2.fromOffset(10, 54),
    Size = UDim2.new(1, -20, 1, -64),
    BackgroundColor3 = Color3.fromRGB(22, 22, 28),
    BorderSizePixel = 0,
}, main)

new("UICorner", { CornerRadius = UDim.new(0, 10) }, content)
