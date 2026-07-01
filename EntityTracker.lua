local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local guiRoot = player:WaitForChild("PlayerGui")

local announcementText = "Currently supported game: Rooms: Low Detailed Redux, Interminable Rooms Reback, Interminable Rooms Expanded, Rooms:Re-Established, Rooms:Found Footage:Renovated"
local monitoredFolderPath = "workspace.Entities"

local gameId = game.GameId
if gameId == 7877609621 or gameId == 7117758812 or gameId == 6488714954 or gameId == 7629117231 then
    monitoredFolderPath = "workspace.Entities"
elseif gameId == 7288050875 then
    monitoredFolderPath = "workspace.SpawnedEntities"
end

local function getMonitoredFolder()

local function getMonitoredFolder()
    local folder = monitoredFolderPath
    return folder
end

local entities = getMonitoredFolder()

local gui = Instance.new("ScreenGui")
gui.Name = "EntityTracker"
gui.Parent = guiRoot
gui.ResetOnSpawn = false

local announcementFrame = Instance.new("Frame")
announcementFrame.Size = UDim2.new(0, 450, 0, 200)
announcementFrame.Position = UDim2.new(0.5, -225, 1.2, 0)
announcementFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
announcementFrame.BackgroundTransparency = 0.1
announcementFrame.BorderSizePixel = 0
announcementFrame.ClipsDescendants = true
announcementFrame.Parent = gui

local announceDragHandle = Instance.new("Frame")
announceDragHandle.Size = UDim2.new(1, 0, 0, 30)
announceDragHandle.Position = UDim2.new(0, 0, 0, 0)
announceDragHandle.BackgroundTransparency = 1
announceDragHandle.Parent = announcementFrame

local closeAnnounce = Instance.new("TextButton")
closeAnnounce.Size = UDim2.new(0, 30, 0, 30)
closeAnnounce.Position = UDim2.new(1, -35, 0, 0)
closeAnnounce.BackgroundTransparency = 1
closeAnnounce.Text = "✕"
closeAnnounce.TextColor3 = Color3.new(1,1,1)
closeAnnounce.TextSize = 20
closeAnnounce.Font = Enum.Font.Gotham
closeAnnounce.Parent = announceDragHandle

local announceScroll = Instance.new("ScrollingFrame")
announceScroll.Size = UDim2.new(1, -10, 1, -40)
announceScroll.Position = UDim2.new(0, 5, 0, 35)
announceScroll.BackgroundTransparency = 1
announceScroll.BorderSizePixel = 0
announceScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
announceScroll.ScrollBarThickness = 6
announceScroll.ScrollBarImageColor3 = Color3.fromRGB(150,150,150)
announceScroll.Parent = announcementFrame

local announceLayout = Instance.new("UIListLayout")
announceLayout.Padding = UDim.new(0, 8)
announceLayout.SortOrder = Enum.SortOrder.LayoutOrder
announceLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
announceLayout.Parent = announceScroll

local announceLabel = Instance.new("TextLabel")
announceLabel.Size = UDim2.new(1, -20, 0, 50)
announceLabel.BackgroundTransparency = 1
announceLabel.Text = announcementText
announceLabel.TextColor3 = Color3.new(1,1,1)
announceLabel.TextSize = 18
announceLabel.Font = Enum.Font.GothamBold
announceLabel.TextWrapped = true
announceLabel.TextXAlignment = Enum.TextXAlignment.Center
announceLabel.Parent = announceScroll

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 280, 0, 35)
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
copyBtn.BackgroundTransparency = 0.3
copyBtn.BorderSizePixel = 0
copyBtn.Text = "获取脚本作者QQ和RobloxID"
copyBtn.TextColor3 = Color3.new(1,1,1)
copyBtn.TextSize = 14
copyBtn.Font = Enum.Font.GothamBold
copyBtn.Parent = announceScroll

copyBtn.MouseButton1Click:Connect(function()
    local textToCopy = "QQ号:3758837896 Roblox:ROOMS_highigh2355"
    local copied = false
    if setclipboard then
        setclipboard(textToCopy)
        copied = true
    elseif toclipboard then
        toclipboard(textToCopy)
        copied = true
    else
        local success, err = pcall(function()
            UserInputService:SetClipboard(textToCopy)
        end)
        if success then copied = true end
    end
    if copied then
        StarterGui:SetCore("SendNotification", {
            Title = "Copied!",
            Text = "Author info copied to clipboard.",
            Duration = 3
        })
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Failed to copy. Try manually.",
            Duration = 3
        })
    end
end)

local function updateAnnounceCanvas()
    task.defer(function()
        announceScroll.CanvasSize = UDim2.new(0, 0, 0, announceLayout.AbsoluteContentSize.Y + 20)
    end)
end
announceLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateAnnounceCanvas)
updateAnnounceCanvas()

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0, 20, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = gui

local dragHandle = Instance.new("Frame")
dragHandle.Size = UDim2.new(1, 0, 0, 32)
dragHandle.Position = UDim2.new(0, 0, 0, 0)
dragHandle.BackgroundTransparency = 1
dragHandle.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 32)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Entity List"
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = dragHandle

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -65, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextSize = 22
closeBtn.Font = Enum.Font.Gotham
closeBtn.Parent = dragHandle

local destroyBtn = Instance.new("TextButton")
destroyBtn.Size = UDim2.new(0, 30, 0, 30)
destroyBtn.Position = UDim2.new(1, -35, 0, 0)
destroyBtn.BackgroundTransparency = 1
destroyBtn.Text = "⛔"
destroyBtn.TextColor3 = Color3.new(1,0.3,0.3)
destroyBtn.TextSize = 20
destroyBtn.Font = Enum.Font.Gotham
destroyBtn.Parent = dragHandle

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -40)
scroll.Position = UDim2.new(0, 5, 0, 40)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 8
scroll.ScrollBarImageColor3 = Color3.fromRGB(150,150,150)
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local itemMap = {}
local childAddedConn, childRemovedConn, heartbeatConn
local isUIVisible = true
local isDestroyed = false

local function getEntityPosition(obj)
    if obj:IsA("BasePart") then
        return obj.Position
    elseif obj:IsA("Model") then
        local primary = obj.PrimaryPart
        if primary then return primary.Position end
        local success, cframe = pcall(function() return obj:GetBoundingBox() end)
        if success then return cframe.Position end
    end
    return nil
end

local function updateDistance(obj, label)
    local char = player.Character
    if not char then
        label.Text = obj.Name .. " - ? studs"
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if not root then
        label.Text = obj.Name .. " - ? studs"
        return
    end
    local pos = getEntityPosition(obj)
    if not pos then
        label.Text = obj.Name .. " - ? studs"
        return
    end
    local dist = (pos - root.Position).Magnitude
    label.Text = obj.Name .. " - " .. string.format("%.1f", dist) .. " studs"
end

local function createItem(obj)
    if itemMap[obj] then return end
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 26)
    frame.BackgroundTransparency = 1
    frame.Parent = scroll

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = obj.Name .. " - loading..."
    label.TextColor3 = Color3.new(1,1,1)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    updateDistance(obj, label)
    itemMap[obj] = {label = label, frame = frame}
    task.defer(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end

local function removeItem(obj)
    local data = itemMap[obj]
    if data then
        data.frame:Destroy()
        itemMap[obj] = nil
        task.defer(function()
            scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
    end
end

local function playSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://123768108281416"
    sound.Volume = 1.5
    sound.Parent = gui
    local echo = Instance.new("EchoSoundEffect")
    echo.DryLevel = 0
    echo.WetLevel = 0.8
    echo.Feedback = 0.5
    echo.Delay = 0.3
    echo.Parent = sound
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function showNotification(titleText, bodyText)
    if not isDestroyed then
        StarterGui:SetCore("SendNotification", {
            Title = titleText,
            Text = bodyText,
            Duration = 4
        })
    end
end

local function refreshAllDistances()
    for obj, data in pairs(itemMap) do
        updateDistance(obj, data.label)
    end
end

local function onChildAdded(child)
    createItem(child)
    if not isDestroyed then
        playSound()
        showNotification("Entity Spotted", child.Name .. " has arrived!")
    end
end

local function onChildRemoved(child)
    removeItem(child)
    if not isDestroyed then
        showNotification("Entity Left", child.Name .. " has disappeared.")
    end
end

for _, child in ipairs(entities:GetChildren()) do
    createItem(child)
end

childAddedConn = entities.ChildAdded:Connect(onChildAdded)
childRemovedConn = entities.ChildRemoved:Connect(onChildRemoved)
heartbeatConn = RunService.Heartbeat:Connect(refreshAllDistances)

local function destroyUI()
    if isDestroyed then return end
    isDestroyed = true
    isUIVisible = false
    childAddedConn:Disconnect()
    childRemovedConn:Disconnect()
    heartbeatConn:Disconnect()
    for obj, data in pairs(itemMap) do
        data.frame:Destroy()
    end
    itemMap = {}
    local fadeOut = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(mainFrame, fadeOut, {BackgroundTransparency = 1})
    tween:Play()
    tween.Completed:Connect(function()
        gui:Destroy()
    end)
end

local function createConfirmDialog()
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.BackgroundColor3 = Color3.new(0,0,0)
    overlay.BorderSizePixel = 0
    overlay.Parent = gui

    local dialog = Instance.new("Frame")
    dialog.Size = UDim2.new(0, 260, 0, 120)
    dialog.Position = UDim2.new(0.5, -130, 0.5, -60)
    dialog.BackgroundColor3 = Color3.fromRGB(40,40,45)
    dialog.BorderSizePixel = 0
    dialog.Parent = overlay

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -20, 0, 50)
    text.Position = UDim2.new(0, 10, 0, 10)
    text.BackgroundTransparency = 1
    text.Text = "Destroy the entity list?\nThis cannot be undone."
    text.TextColor3 = Color3.new(1,1,1)
    text.TextSize = 16
    text.Font = Enum.Font.Gotham
    text.TextWrapped = true
    text.Parent = dialog

    local confirm = Instance.new("TextButton")
    confirm.Size = UDim2.new(0, 80, 0, 30)
    confirm.Position = UDim2.new(0.5, -90, 1, -40)
    confirm.BackgroundColor3 = Color3.fromRGB(200,50,50)
    confirm.Text = "Confirm"
    confirm.TextColor3 = Color3.new(1,1,1)
    confirm.TextSize = 14
    confirm.Font = Enum.Font.GothamBold
    confirm.Parent = dialog

    local cancel = Instance.new("TextButton")
    cancel.Size = UDim2.new(0, 80, 0, 30)
    cancel.Position = UDim2.new(0.5, 10, 1, -40)
    cancel.BackgroundColor3 = Color3.fromRGB(60,60,70)
    cancel.Text = "Cancel"
    cancel.TextColor3 = Color3.new(1,1,1)
    cancel.TextSize = 14
    cancel.Font = Enum.Font.GothamBold
    cancel.Parent = dialog

    confirm.MouseButton1Click:Connect(function()
        overlay:Destroy()
        destroyUI()
    end)
    cancel.MouseButton1Click:Connect(function()
        overlay:Destroy()
    end)
end

destroyBtn.MouseButton1Click:Connect(createConfirmDialog)

local function setupDragging(frame, handle)
    local dragging = false
    local dragStartPos = nil
    local dragStartFramePos = nil

    local function updateDrag(input)
        if not dragging then return end
        local delta = input.Position - dragStartPos
        frame.Position = UDim2.new(
            dragStartFramePos.X.Scale,
            dragStartFramePos.X.Offset + delta.X,
            dragStartFramePos.Y.Scale,
            dragStartFramePos.Y.Offset + delta.Y
        )
    end

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStartPos = input.Position
            dragStartFramePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

setupDragging(announcementFrame, announceDragHandle)
setupDragging(mainFrame, dragHandle)

local isVisible = true
local fadeTween

local function fadeUI(targetTransparency, callback)
    if fadeTween and fadeTween.PlaybackState == Enum.PlaybackState.Playing then
        fadeTween:Cancel()
    end
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    fadeTween = TweenService:Create(mainFrame, tweenInfo, {BackgroundTransparency = targetTransparency})
    fadeTween:Play()
    fadeTween.Completed:Connect(function()
        if callback then callback() end
    end)
end

local hiddenButton = Instance.new("TextButton")
hiddenButton.Size = mainFrame.Size
hiddenButton.Position = mainFrame.Position
hiddenButton.BackgroundTransparency = 1
hiddenButton.Text = ""
hiddenButton.Visible = false
hiddenButton.ZIndex = 10
hiddenButton.Parent = gui

hiddenButton.MouseButton1Click:Connect(function()
    if not isVisible and not isDestroyed then
        isVisible = true
        isUIVisible = true
        mainFrame.Visible = true
        fadeUI(0.15)
        closeBtn.Visible = true
        destroyBtn.Visible = true
        hiddenButton.Visible = false
    end
end)

local function updateHiddenButton()
    if not isVisible and not isDestroyed then
        hiddenButton.Visible = true
        hiddenButton.Size = mainFrame.Size
        hiddenButton.Position = mainFrame.Position
    else
        hiddenButton.Visible = false
    end
end

mainFrame:GetPropertyChangedSignal("Position"):Connect(updateHiddenButton)
mainFrame:GetPropertyChangedSignal("Size"):Connect(updateHiddenButton)

closeBtn.MouseButton1Click:Connect(function()
    if isDestroyed then return end
    if isVisible then
        isVisible = false
        isUIVisible = false
        fadeUI(1, function()
            mainFrame.Visible = false
            updateHiddenButton()
        end)
        closeBtn.Visible = false
        destroyBtn.Visible = false
        updateHiddenButton()
    else
        isVisible = true
        isUIVisible = true
        mainFrame.Visible = true
        fadeUI(0.15)
        closeBtn.Visible = true
        destroyBtn.Visible = true
        hiddenButton.Visible = false
    end
end)

updateHiddenButton()

local announceTween = TweenService:Create(announcementFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -225, 0.3, 0)
})
announceTween:Play()

closeAnnounce.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(announcementFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -225, 1.2, 0)
    })
    closeTween:Play()
    closeTween.Completed:Connect(function()
        announcementFrame:Destroy()
        mainFrame.Visible = true
        mainFrame.BackgroundTransparency = 0.15
    end)
end)

player.CharacterAdded:Connect(function() end)
