local plr = game.Players.LocalPlayer
local localplayer = plr
local mouse = plr:GetMouse()

local flying = false
local keys = {a = false, d = false, w = false, s = false}
local e1
local e2

local function start(speed)
    flying = true
    local torso = localplayer.Character:WaitForChild("HumanoidRootPart")
    local pos = Instance.new("BodyPosition", torso)
    local gyro = Instance.new("BodyGyro", torso)
    pos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    pos.Position = torso.Position
    gyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    gyro.CFrame = torso.CFrame
    repeat
        wait()
        local new = gyro.CFrame - gyro.CFrame.p + pos.Position
        if not keys.w and not keys.s and not keys.a and not keys.d then
            speed = 5
        end
        if keys.w then
            new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
            speed = speed + 0
        end
        if keys.s then
            new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
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
    until not flying
    pos:Destroy()
    gyro:Destroy()
end

local function stopFlying()
    flying = false
end

e1 = mouse.KeyDown:Connect(function(key)
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

return start, stopFlying
