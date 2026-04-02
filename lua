print("successfully loaded")

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player           = Players.LocalPlayer

local TRADE_PROMPT_TEXT    = "Trade Request"
local INITIAL_DELAY        = 5
local TRADE_CHECK_INTERVAL = 0.5

-- ══════════════════════════════════════════════════════
-- 67 HUB GUI
-- ══════════════════════════════════════════════════════

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "67HUB_AutoTrade"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn   = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent         = player:WaitForChild("PlayerGui")

-- ── MAIN CARD ─────────────────────────────────────────
local Card = Instance.new("Frame", ScreenGui)
Card.Size             = UDim2.new(0,220,0,0)
Card.Position         = UDim2.new(0,14,0,80)
Card.BackgroundColor3 = Color3.fromRGB(5,10,20)
Card.BackgroundTransparency = 0.06
Card.BorderSizePixel  = 0
Card.ZIndex           = 2
Card.ClipsDescendants = true
Instance.new("UICorner", Card).CornerRadius = UDim.new(0,12)

local CardStroke = Instance.new("UIStroke", Card)
CardStroke.Thickness = 1.4
CardStroke.Color     = Color3.fromRGB(0,150,255)
task.spawn(function()
    while Card.Parent do
        TweenService:Create(CardStroke,TweenInfo.new(1.4,Enum.EasingStyle.Sine),
            {Color=Color3.fromRGB(0,230,255),Transparency=0}):Play()
        task.wait(1.4)
        TweenService:Create(CardStroke,TweenInfo.new(1.4,Enum.EasingStyle.Sine),
            {Color=Color3.fromRGB(0,60,180),Transparency=0.45}):Play()
        task.wait(1.4)
    end
end)

-- Corner brackets
local function mkBracket(parent, ax, ay)
    local f = Instance.new("Frame", parent)
    f.Size        = UDim2.new(0,10,0,10)
    f.AnchorPoint = Vector2.new(ax,ay)
    f.Position    = UDim2.new(ax, ax==0 and 6 or -6, ay, ay==0 and 6 or -6)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0; f.ZIndex = 6
    local h = Instance.new("Frame",f)
    h.Size=UDim2.new(1,0,0,2)
    h.Position=UDim2.new(0,0,ay==0 and 0 or 1,ay==0 and 0 or -2)
    h.BackgroundColor3=Color3.fromRGB(0,210,255); h.BorderSizePixel=0; h.ZIndex=6
    local v = Instance.new("Frame",f)
    v.Size=UDim2.new(0,2,1,0)
    v.Position=UDim2.new(ax==0 and 0 or 1,ax==0 and 0 or -2,0,0)
    v.BackgroundColor3=Color3.fromRGB(0,210,255); v.BorderSizePixel=0; v.ZIndex=6
end
mkBracket(Card,0,0); mkBracket(Card,1,0)
mkBracket(Card,0,1); mkBracket(Card,1,1)

-- ── HEADER ─────────────────────────────────────────
local Header = Instance.new("Frame", Card)
Header.Size             = UDim2.new(1,0,0,46)
Header.BackgroundColor3 = Color3.fromRGB(0,90,190)
Header.BackgroundTransparency = 0.78
Header.BorderSizePixel  = 0
Header.ZIndex           = 3
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,12)

local HeaderMask = Instance.new("Frame", Header)
HeaderMask.Size             = UDim2.new(1,0,0,12)
HeaderMask.Position         = UDim2.new(0,0,1,-12)
HeaderMask.BackgroundColor3 = Color3.fromRGB(0,90,190)
HeaderMask.BackgroundTransparency = 0.78
HeaderMask.BorderSizePixel  = 0

local LogoBadge = Instance.new("Frame", Header)
LogoBadge.Size             = UDim2.new(0,28,0,28)
LogoBadge.Position         = UDim2.new(0,10,0.5,-14)
LogoBadge.BackgroundColor3 = Color3.fromRGB(0,150,255)
LogoBadge.BorderSizePixel  = 0; LogoBadge.ZIndex = 4
Instance.new("UICorner",LogoBadge).CornerRadius = UDim.new(0,7)
task.spawn(function()
    while LogoBadge.Parent do
        TweenService:Create(LogoBadge,TweenInfo.new(1,Enum.EasingStyle.Sine),
            {BackgroundColor3=Color3.fromRGB(0,80,200)}):Play(); task.wait(1)
        TweenService:Create(LogoBadge,TweenInfo.new(1,Enum.EasingStyle.Sine),
            {BackgroundColor3=Color3.fromRGB(0,200,255)}):Play(); task.wait(1)
    end
end)

local LogoLbl = Instance.new("TextLabel", LogoBadge)
LogoLbl.Size=UDim2.new(1,0,1,0); LogoLbl.BackgroundTransparency=1
LogoLbl.Text="67"; LogoLbl.Font=Enum.Font.GothamBold
LogoLbl.TextSize=12; LogoLbl.TextColor3=Color3.fromRGB(255,255,255); LogoLbl.ZIndex=5

local TitleLbl = Instance.new("TextLabel", Header)
TitleLbl.Size=UDim2.new(1,-100,0,18); TitleLbl.Position=UDim2.new(0,46,0,6)
TitleLbl.BackgroundTransparency=1; TitleLbl.Text="67 HUB XoSh"
TitleLbl.Font=Enum.Font.GothamBold; TitleLbl.TextSize=13
TitleLbl.TextColor3=Color3.fromRGB(200,235,255)
TitleLbl.TextXAlignment=Enum.TextXAlignment.Left; TitleLbl.ZIndex=4

local SubLbl = Instance.new("TextLabel", Header)
SubLbl.Size=UDim2.new(1,-100,0,13); SubLbl.Position=UDim2.new(0,46,0,25)
SubLbl.BackgroundTransparency=1; SubLbl.Text="AUTO TRADE"
SubLbl.Font=Enum.Font.GothamBold; SubLbl.TextSize=9
SubLbl.TextColor3=Color3.fromRGB(0,190,255); SubLbl.TextTransparency=0.2
SubLbl.TextXAlignment=Enum.TextXAlignment.Left; SubLbl.ZIndex=4

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size=UDim2.new(0,22,0,22); MinBtn.Position=UDim2.new(1,-30,0.5,-11)
MinBtn.BackgroundColor3=Color3.fromRGB(0,80,160); MinBtn.BackgroundTransparency=0.4
MinBtn.BorderSizePixel=0; MinBtn.Text="—"
MinBtn.Font=Enum.Font.GothamBold; MinBtn.TextSize=11
MinBtn.TextColor3=Color3.fromRGB(150,210,255); MinBtn.ZIndex=5
Instance.new("UICorner",MinBtn).CornerRadius=UDim.new(1,0)

-- ── BODY ──────────────────────────────────────────────
local Body = Instance.new("Frame", Card)
Body.Name="Body"; Body.Size=UDim2.new(1,-20,0,0)
Body.Position=UDim2.new(0,10,0,52)
Body.BackgroundTransparency=1; Body.BorderSizePixel=0; Body.ZIndex=3

local function mkRow(parent, ypos, icon, label)
    local row = Instance.new("Frame", parent)
    row.Size=UDim2.new(1,0,0,30); row.Position=UDim2.new(0,0,0,ypos)
    row.BackgroundColor3=Color3.fromRGB(0,60,130); row.BackgroundTransparency=0.72
    row.BorderSizePixel=0; row.ZIndex=3
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,8)
    local dot=Instance.new("Frame",row)
    dot.Size=UDim2.new(0,6,0,6); dot.Position=UDim2.new(0,9,0.5,-3)
    dot.BackgroundColor3=Color3.fromRGB(0,200,120); dot.BorderSizePixel=0; dot.ZIndex=4
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local icLbl=Instance.new("TextLabel",row)
    icLbl.Size=UDim2.new(0,20,1,0); icLbl.Position=UDim2.new(0,22,0,0)
    icLbl.BackgroundTransparency=1; icLbl.Text=icon
    icLbl.TextSize=13; icLbl.Font=Enum.Font.GothamBold; icLbl.ZIndex=4
    local lbl=Instance.new("TextLabel",row)
    lbl.Size=UDim2.new(0.5,0,1,0); lbl.Position=UDim2.new(0,44,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=label
    lbl.Font=Enum.Font.Code; lbl.TextSize=9
    lbl.TextColor3=Color3.fromRGB(100,160,220)
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=4
    local val=Instance.new("TextLabel",row)
    val.Size=UDim2.new(0,70,1,0); val.Position=UDim2.new(1,-72,0,0)
    val.BackgroundTransparency=1; val.Font=Enum.Font.GothamBold
    val.TextSize=10; val.TextColor3=Color3.fromRGB(255,255,255)
    val.TextXAlignment=Enum.TextXAlignment.Right; val.ZIndex=4
    return dot, val
end

local dot1, val1 = mkRow(Body, 0,  "🔄", "TRADE REQ")
local dot2, val2 = mkRow(Body, 34, "✅", "READY BTN")

local Div=Instance.new("Frame",Body)
Div.Size=UDim2.new(1,0,0,1); Div.Position=UDim2.new(0,0,0,68)
Div.BackgroundColor3=Color3.fromRGB(0,120,255); Div.BackgroundTransparency=0.65
Div.BorderSizePixel=0; Div.ZIndex=3

local MainStatus=Instance.new("TextLabel",Body)
MainStatus.Size=UDim2.new(1,0,0,18); MainStatus.Position=UDim2.new(0,0,0,74)
MainStatus.BackgroundTransparency=1; MainStatus.Text="STARTING UP..."
MainStatus.Font=Enum.Font.GothamBold; MainStatus.TextSize=11
MainStatus.TextColor3=Color3.fromRGB(0,200,255)
MainStatus.TextXAlignment=Enum.TextXAlignment.Center; MainStatus.ZIndex=3

local CounterLbl=Instance.new("TextLabel",Body)
CounterLbl.Size=UDim2.new(1,0,0,14); CounterLbl.Position=UDim2.new(0,0,0,94)
CounterLbl.BackgroundTransparency=1; CounterLbl.Text="TRADES ACCEPTED: 0"
CounterLbl.Font=Enum.Font.Code; CounterLbl.TextSize=9
CounterLbl.TextColor3=Color3.fromRGB(0,120,200)
CounterLbl.TextXAlignment=Enum.TextXAlignment.Center; CounterLbl.ZIndex=3

local CreditLbl=Instance.new("TextLabel",Body)
CreditLbl.Size=UDim2.new(1,0,0,12); CreditLbl.Position=UDim2.new(0,0,0,112)
CreditLbl.BackgroundTransparency=1; CreditLbl.Text="67HUB XoSh  •  ON TOP 👑"
CreditLbl.Font=Enum.Font.GothamBold; CreditLbl.TextSize=8
CreditLbl.TextColor3=Color3.fromRGB(0,90,160)
CreditLbl.TextXAlignment=Enum.TextXAlignment.Center; CreditLbl.ZIndex=3
task.spawn(function()
    while CreditLbl.Parent do
        TweenService:Create(CreditLbl,TweenInfo.new(1.8,Enum.EasingStyle.Sine),{TextTransparency=0.65}):Play(); task.wait(1.8)
        TweenService:Create(CreditLbl,TweenInfo.new(1.8,Enum.EasingStyle.Sine),{TextTransparency=0}):Play();   task.wait(1.8)
    end
end)

val1.Text="WATCHING"; val1.TextColor3=Color3.fromRGB(0,220,255)
val2.Text="SPAMMING"; val2.TextColor3=Color3.fromRGB(0,220,255)

local function blinkDot(dot)
    task.spawn(function()
        while dot.Parent do
            TweenService:Create(dot,TweenInfo.new(0.6,Enum.EasingStyle.Sine),{BackgroundTransparency=0.8}):Play(); task.wait(0.6)
            TweenService:Create(dot,TweenInfo.new(0.6,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play();   task.wait(0.6)
        end
    end)
end
blinkDot(dot1); blinkDot(dot2)

-- ── CARD SIZE + ENTRANCE ──────────────────────────────
local CARD_H = 52 + 10 + 125 + 10
Card.Size=UDim2.new(0,220,0,0); Card.BackgroundTransparency=1
TweenService:Create(Card,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    Size=UDim2.new(0,220,0,CARD_H), BackgroundTransparency=0.06
}):Play()

-- ── DRAG ────────────────────────────────────────────────
do
    local dragging, dragStart, startPos = false, nil, nil

    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragStart = inp.Position
            startPos  = Card.Position
        end
    end)

    Header.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (
            inp.UserInputType == Enum.UserInputType.MouseMovement or
            inp.UserInputType == Enum.UserInputType.Touch
        ) then
            local delta = inp.Position - dragStart
            Card.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ── MINIMIZE ──────────────────────────────────────────
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MinBtn.Text = "+"
        TweenService:Create(Card,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,220,0,46)
        }):Play()
    else
        MinBtn.Text = "—"
        TweenService:Create(Card,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
            Size=UDim2.new(0,220,0,CARD_H)
        }):Play()
    end
end)

-- ── STATUS HELPERS ────────────────────────────────────
local tradeCount = 0

local function setStatus(text, color)
    MainStatus.Text       = text
    MainStatus.TextColor3 = color or Color3.fromRGB(0,200,255)
end

local function flashDot(dot, color)
    dot.BackgroundColor3 = color
    task.delay(0.5, function()
        dot.BackgroundColor3 = Color3.fromRGB(0,200,120)
    end)
end

-- ══════════════════════════════════════════════════════
-- LOGIC (FIXED FOR CODEX)
-- ══════════════════════════════════════════════════════

task.delay(INITIAL_DELAY, function()

    setStatus("INITIALIZING...", Color3.fromRGB(255,200,0))

    local container = player.PlayerGui
        :WaitForChild("DuelsMachinePrompt", 15)
        :WaitForChild("DuelsMachinePrompt", 15)

    if not container then
        setStatus("GUI NOT FOUND!", Color3.fromRGB(255,60,60))
        return
    end

    setStatus("WAITING FOR TRADE...", Color3.fromRGB(0,200,255))

    -- Universal button clicker that works for both Yes and Ready buttons
    local function clickButton(button)
        if not button then return false end
        
        -- Method 1: Try firesignal (if available)
        pcall(function()
            if firesignal then
                firesignal(button.Activated)
            end
        end)
        
        -- Method 2: VirtualInputManager click (works on Codex)
        pcall(function()
            local pos = button.AbsolutePosition + (button.AbsoluteSize / 2)
            VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
        end)
        
        -- Method 3: Direct Fire
        pcall(function()
            button:Fire()
        end)
        
        return true
    end

    local function clickYes(prompt)
        local yesButton = prompt:FindFirstChild("Yes", true)
        if yesButton then
            clickButton(yesButton)
        end
    end

    local function Accept()
        pcall(function()
            local readyButton = player.PlayerGui.TradeLiveTrade.TradeLiveTrade.Other.ReadyButton
            if readyButton then
                clickButton(readyButton)
            end
        end)
    end

    -- Spam Ready button
    task.spawn(function()
        while task.wait(TRADE_CHECK_INTERVAL) do
            Accept()
        end
    end)

    -- Auto accept trade requests
    container.ChildAdded:Connect(function(child)
        if child.Name == "Prompt" then
            local label = child:FindFirstChild("Label", true)
            if label and label.Text == TRADE_PROMPT_TEXT then
                tradeCount = tradeCount + 1
                CounterLbl.Text = "TRADES ACCEPTED: " .. tradeCount
                flashDot(dot1, Color3.fromRGB(0,255,140))
                setStatus("TRADE ACCEPTED! ✅", Color3.fromRGB(0,255,140))
                clickYes(child)
                task.delay(3, function()
                    setStatus("WAITING FOR TRADE...", Color3.fromRGB(0,200,255))
                end)
            end
        end
    end)

    print("[67HUB] Auto trade running on Codex.")
    setStatus("READY & RUNNING ✅", Color3.fromRGB(0,255,100))
end)
