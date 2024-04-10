local plr = game.Players.LocalPlayer
local localplayer = plr
local mouse = plr:GetMouse()

if workspace:FindFirstChild("Core") then
    workspace.Core:Destroy()
end

local Core = Instance.new("Part")
Core.Name = "Core"
Core.Size = Vector3.new(0.05, 0.05, 0.05)

spawn(function()
    Core.Parent = workspace
    local Weld = Instance.new("Weld", Core)
    Weld.Part0 = Core
    Weld.Part1 = localplayer.Character.LowerTorso
    Weld.C0 = CFrame.new(0, 0, 0)
end)

workspace:WaitForChild("Core")

local torso = workspace.Core
local flying = true
local keys = {a = false, d = false, w = false, s = false}
local e1
local e2

local function start(speed)
    local pos = Instance.new("BodyPosition", torso)
    local gyro = Instance.new("BodyGyro", torso)
    pos.Name = "EPIXPOS"
    pos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.Position = torso.Position
    gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.CFrame = torso.CFrame
    repeat
        wait()
        localplayer.Character.Humanoid.PlatformStand = true
        local new = gyro.CFrame - gyro.CFrame.p + pos.Position
        if not keys.w and not keys.s and not keys.a and not keys.d then
            speed = 5
        end
        if keys.w then
            new = new + workspace.CurrentCamera.CoordinateFrame.LookVector * speed
            speed = speed + 0
        end
        if keys.s then
            new = new - workspace.CurrentCamera.CoordinateFrame.LookVector * speed
            speed = speed + 0
        end
        if keys.d then
            new = new * CFrame.new(speed, 0, 0)
            speed = speed + 0
        end
        if keys.a then
            new = new * CFrame.new(-speed, 0, 0)
            speed = speed + 0
        end
        if speed > 10 then
            speed = 5
        end
        pos.Position = new.p
        if keys.w then
            gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad(speed * 0), 0, 0)
        elseif keys.s then
            gyro.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(speed * 0), 0, 0)
        else
            gyro.CFrame = workspace.CurrentCamera.CoordinateFrame
        end
    until not flying -- Stop flying when 'flying' is false
    if gyro then
        gyro:Destroy()
    end
    if pos then
        pos:Destroy()
    end
    localplayer.Character.Humanoid.PlatformStand = false
end

local function stopFlying()
    flying = false
end

e1 = mouse.KeyDown:Connect(function(key)
    if not torso or not torso.Parent then
        flying = false
        e1:Disconnect()
        e2:Disconnect()
        return
    end
    if key == "w" then
        keys.w = true
    elseif key == "s" then
        keys.s = true
    elseif key == "a" then
        keys.a = true
    elseif key == "d" then
        keys.d = true
    end
end)

e2 = mouse.KeyUp:Connect(function(key)
    if key == "w" then
        keys.w = false
    elseif key == "s" then
        keys.s = false
    elseif key == "a" then
        keys.a = false
    elseif key == "d" then
        keys.d = false
    end
end)

start(5)

return stopFlying -- Return function to stop flying
