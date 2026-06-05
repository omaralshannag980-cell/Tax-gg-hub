-- Carregando a biblioteca RedzLib V4
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/techwearhubofc/Redz/main/Source.lua"))()

-- Criando a janela
local Window = redzlib:MakeWindow({
  Title = "Tax gg hub [ Beta ] : Brookhaven 🏡RP",
  SubTitle = "by : 7zn",
  LoadText = "Tax gg hub Loading... by 7zn",
  Flags = "Tax gg hub | TikTok: 9z_e.1"
})

Window:AddMinimizeButton({
  Button = {
    Image = "rbxassetid://130688450838044"
  },
  UICorner = {true, CornerRadius = UDim.new(0.5, 0)},
  UIStroke = {false, {}}
})

-- تنبيه ترحيبي
redzlib:Notification("Tax gg hub", "تم تشغيل السكربت بنجاح\nby 7zn | TikTok: 9z_e.1", "success", 5)

-- إنشاء التبويبات
local SongsTab = Window:MakeTab({"قائمة الأغاني والـ IDs", "music"})
local AntiTab = Window:MakeTab({"المضادات والـ Anti", "shield"})
local CreditsTab = Window:MakeTab({"الحقوق والمطور", "info"})

---------------------------------------------------------------------
-- [1] نظام الصوتيات والأغاني المحسن
---------------------------------------------------------------------

local LocalPlayer = game:GetService("Players").LocalPlayer

-- دالة مخصصة للبحث عن الراديو وتشغيل الكود للجميع
local function playForEveryone(audioId)
    -- تحويل الـ ID إلى نص نظيف يحتوي على أرقام فقط لحماية السكربت من التوقف
    local cleanId = tostring(audioId):match("%d+")
    if not cleanId then
        redzlib:Notification("تنبيه", "الـ ID المدخل غير صالح!", "error", 3)
        return
    end

    -- البحث عن أداة الراديو في حقيبة اللاعب أو شخصيته
    local radio = LocalPlayer.Backpack:FindFirstChild("Radio") or LocalPlayer.Character:FindFirstChild("Radio") 
               or LocalPlayer.Backpack:FindFirstChild("Boombox") or LocalPlayer.Character:FindFirstChild("Boombox")
    
    if radio then
        -- البحث عن الريموت المسؤول عن تشغيل الصوت في أداة الراديو
        local remote = radio:FindFirstChild("Remote") or radio:FindFirstChild("Server") or radio:FindFirstChildOfClass("RemoteEvent")
        if remote and remote:IsA("RemoteEvent") then
            remote:FireServer(cleanId)
            redzlib:Notification("Tax gg hub", "تم تشغيل الصوت عبر الراديو لكي يسمعه الجميع!", "success", 3)
        else
            redzlib:Notification("تنبيه", "تم العثور على الراديو ولكن لم يتم ربطه تلقائياً.", "warning", 3)
        end
    else
        -- تشغيل الصوت محلياً للاعب فقط في حال عدم امتلاك راديو
        local localSound = game:GetService("Workspace"):FindFirstChild("TaxGGLocalSound")
        if not localSound then
            localSound = Instance.new("Sound", game:GetService("Workspace"))
            localSound.Name = "TaxGGLocalSound"
        end
        localSound.SoundId = "rbxassetid://" .. cleanId
        localSound.Volume = 2
        localSound:Play()
        redzlib:Notification("Tax gg hub", "تنبيه: تم التشغيل محلياً (أنت فقط من يسمع) لعدم توفر راديو بيدك.", "warning", 4)
    end
end

SongsTab:AddSection({"التحكم بالتشغيل (by 7zn)"})

-- إدخال كود يدوي
local customTrackID = ""
SongsTab:AddTextBox({
    Name = "ضع ID مخصص هنا",
    Default = "",
    TextDisappear = false,
    Callback = function(value)
        customTrackID = value
    end
})

SongsTab:AddButton({
    Name = "تشغيل الـ ID اليدوي 🌐",
    Callback = function()
        if customTrackID ~= "" then
            playForEveryone(customTrackID)
        else
            redzlib:Notification("تنبيه", "الرجاء كتابة ID أولاً", "error", 3)
        end
    end
})

SongsTab:AddSection({"قائمة الأكواد الخاصة بك (تبان للناس)"})

-- قائمة الأكواد الخاصة بك (تمت إزالة المعرف النصي الخاطئ لضمان استقرار السكربت)
local userTracks = {
    "95877137552489", "125861618879629", "134693931986753", "107273226047360", 
    "124123680327164", "73721014572224", "87920916682123", "126581313655066", 
    "12412368037164", "79193631928944", "85822106162452", "7984027399", 
    "129963257934687", "93297302504653", "98313375960954", "3230475415", 
    "71701207559451", "106330590409106", "71373562243752", "127666185347295", 
    "9108676586"
}

-- توليد الأزرار تلقائياً
for index, id in ipairs(userTracks) do
    SongsTab:AddButton({
        Name = "🎵 تشغيل الكود رقم [" .. tostring(index) .. "]",
        Callback = function()
            playForEveryone(id)
        end
    })
end

---------------------------------------------------------------------
-- [2] قسم المضادات والـ Anti
---------------------------------------------------------------------

AntiTab:AddSection({"حماية اللاعب (Anti-AFK)"})

local antiAFKEnabled = false
AntiTab:AddToggle({
    Name = "تفعيل مضاد الطرد الخامل",
    Default = false,
    Callback = function(state)
        antiAFKEnabled = state
        if antiAFKEnabled then
            redzlib:Notification("Tax gg hub", "مضاد الطرد يعمل الآن بنجاح!", "success", 3)
        end
    end
})

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if antiAFKEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

AntiTab:AddSection({"تخفيف اللاق وزيادة الفريمات (Anti-Lag)"})

AntiTab:AddButton({
    Name = "تنظيف الخريطة (إزالة التأثيرات المسببة لللاق)",
    Callback = function()
        local cleared = 0
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
                cleared = cleared + 1
            elseif obj:IsA("PostEffect") then
                obj.Enabled = false
                cleared = cleared + 1
            end
        end
        redzlib:Notification("Tax gg hub", "تم تنظيف " .. tostring(cleared) .. " تأثير لاق بنجاح!", "success", 4)
    end
})

AntiTab:AddButton({
    Name = "نمط البطاطس (أعلى فريمات ممكنة للجميع)",
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("MeshPart") then
                v.TextureID = ""
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        redzlib:Notification("Tax gg hub", "تم تفعيل نمط الفريمات العالية والمظهر المبسط!", "success", 4)
    end
})

---------------------------------------------------------------------
-- [3] تبويب الحقوق والمطور
---------------------------------------------------------------------

CreditsTab:AddSection({"معلومات السكربت"})

CreditsTab:AddButton({
    Name = "اسم السكربت: Tax gg hub",
    Callback = function() end
})

CreditsTab:AddButton({
    Name = "المطور الرئيسي: 7zn",
    Callback = function() end
})

CreditsTab:AddSection({"التواصل والدعم"})

CreditsTab:AddButton({
    Name = "حساب التيك توك: 9z_e.1",
    Callback = function() 
        setclipboard("9z_e.1")
        redzlib:Notification("Tax gg hub", "تم نسخ حساب التيك توك 9z_e.1 إلى الحافظة!", "success", 3)
    end
})
