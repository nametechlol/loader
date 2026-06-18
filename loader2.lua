if (cloneref == nil or getrawmetatable == nil or hookmetamethod == nil) then
    game:GetService("Players").LocalPlayer:Kick("Unsupported executor");
end

local available_nicks = {"ScrathWatch", "extrapolated2323"}

local can_continue = false;

local gamecl = cloneref(game)

local plr = gamecl:GetService("Players").LocalPlayer


if (table.find(available_nicks, plr.Name)) then can_continue = true end

if (not can_continue) then gamecl:GetService("Players").LocalPlayer:Kick("You don't have access to do this") end

local UserInputService = gamecl:GetService("UserInputService")
local RunService = gamecl:GetService("RunService")

if (not UserInputService.KeyboardEnabled) then
    plr:Kick("Unsupported device")
end

local Library = loadstring(gamecl:HttpGet("https://raw.githubusercontent.com/gg3333ofk/loader/refs/heads/main/revenant_protected.lua", true))()

local Watermark = Library:Window({
   Text = "NETCORE GLOBAL [BETA]"
})

local Player = Library:Window({
   Text = "Player"
})
local Fly_tab = Library:Window({
   Text = "Fly"
})

local Disable = Library:Window({
   Text = "Disable (UNSAFE)"
})

local Movement = Library:Window({
   Text = "Movement"
})
local ESP = Library:Window({
   Text = "Visuals"
})

local Unsafe = Library:Window({
   Text = "Fun (UNSAFE)"
})


local delay = 0.0001

local CurrentInputKey = nil

getgenv().velocityjump = true;
getgenv().velocityfly = true;
getgenv().hook_kick = true;
getgenv().walkspeed = true;
getgenv().jump = true;
getgenv().noclip = true;
getgenv().esp = true;
getgenv().antitp = true;
getgenv().flinger = true;
getgenv().clientgodmode = true;

getgenv().whitelist = false;

local freefalling = false;
local function InputSystem(key)
    
    CurrentInputKey = key

end


if (not UserInputService.KeyboardEnabled) then
    gamecl:GetService("Players").LocalPlayer:Kick("Unsupported device")
end

local oldNamecalls = {

}
local oldValues_namecall = {

}


local function namecallHookSystem(obj, method, oldValue, state)

    obj = getrawmetatable(obj)

    if (oldNamecalls[obj] == nil) then

        oldNamecalls[obj] = obj.__namecall 

    end

    if (oldValues_namecall[obj] == nil) then

        oldValues_namecall[obj] = {};

    end

    if (oldValues_namecall[obj][method] == nil) then
        oldValues_namecall[obj][method] = oldValue;
    end

    setreadonly(obj, false)

    if (state) then

        obj.__namecall = newcclosure(function(t, ...)

            local namecallMethod = getnamecallmethod();

            local mt = getrawmetatable(t);

            if (getgenv().whitelist == false and oldValues_namecall[mt] ~= nil and oldValues_namecall[mt][namecallMethod] ~= nil) then
                return oldValues_namecall[mt][namecallMethod](t, ...);
            end

            return oldNamecalls[mt](t, ...);
        end)

    end

    if (not state) then

        obj.__namecall = oldNamecalls[obj];

        oldNamecalls[obj] = nil

        oldValues_namecall[obj] = nil;
    end

    setreadonly(obj, true)
end

local oldIndexes = {

}

local oldNewIndexes = {

}

local oldValues = {

}

local function indexHookSystem(obj, key, oldValue, state)
    

    obj = getrawmetatable(obj)

    if (oldIndexes[obj] == nil) then

        oldIndexes[obj] = obj.__index 

    end

    if (oldNewIndexes[obj] == nil) then
        oldNewIndexes[obj] = obj.__newindex 
    end

    if (oldValues[obj] == nil) then

        oldValues[obj] = {};

    end

    if (oldValues[obj][key] == nil) then
        oldValues[obj][key] = oldValue;
    end

    setreadonly(obj, false)

    if (state) then

        obj.__index = newcclosure(function(t, prm)
            local mt = getrawmetatable(t);

            if (getgenv().whitelist == false and oldValues[mt] ~= nil and oldValues[mt][prm] ~= nil) then
                return oldValues[mt][prm];
            end

            return oldIndexes[mt](t, prm);
        end)

        obj.__newindex = newcclosure(function(t, prm, value)
            local mt = getrawmetatable(t)
            if (getgenv().whitelist == false and oldValues[mt] ~= nil and oldValues[mt][prm] ~= nil) then
                oldValues[mt][prm] = value;
                return true;
            end

            return oldNewIndexes[mt](t, prm, value);

        end)
    end

    if (not state) then

        obj.__index = oldIndexes[obj];
        obj.__newindex = oldNewIndexes[obj];

        oldIndexes[obj] = nil
        oldNewIndexes[obj] = nil
        oldValues[obj][key] = nil
    end

    setreadonly(obj, true)

end

local jumpboost = 50
local function onVelocityJump()
    getgenv().velocityjump = not getgenv().velocityjump
    task.spawn(newcclosure(function()
        while getgenv().velocityjump and task.wait(delay) do
            getgenv().whitelist = true
            

            if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and CurrentInputKey and CurrentInputKey.KeyCode == Enum.KeyCode.Space) then

                local root = plr.Character.HumanoidRootPart

                root.Velocity = Vector3.new(root.Velocity.X, jumpboost, root.Velocity.Z);

                CurrentInputKey = nil

            end
            getgenv().whitelist = false
        end
    end))
end

local function onHookKick()
    getgenv().hook_kick = not getgenv().hook_kick

    namecallHookSystem(gamecl:GetService("Players").LocalPlayer, "Kick", function() return nil end, getgenv().hook_kick);

end

local speed = 0;


local randomize_fly = "none";
local randomization = Vector3.new(0, 0, 0);
local fly_mode = "v2";
local summaryPosition = nil;
local rhythm_fly, groundt_fly = 0.5, 0.01
local function onVelocityFly()
    getgenv().whitelist = true
    getgenv().velocityfly = not getgenv().velocityfly;

    task.spawn(newcclosure(function()

        while task.wait() and getgenv().velocityfly do 
            if (fly_mode == "v2" or fly_mode == "v3") then
                
                
                summaryPosition = nil;
                if (randomize_fly == "Fly Randomization") then
                    
                    randomization = Vector3.new(math.random(-20, 20), math.random(0, 1), math.random(-20, 20))

                elseif (randomize_fly == "Fly Y Randomization") then

                    randomization = Vector3.new(0, math.random(-20, 20), 0)

                else

                    randomization = Vector3.new(0, 0, 0);

                end

                getgenv().whitelist = true

                local camera = gamecl:GetService("Workspace").CurrentCamera

                local summaryVelocity = Vector3.new(0, 0, 0);

                if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and camera and UserInputService:IsKeyDown(Enum.KeyCode.W)) then
                    
                    local lookVector = camera.CFrame.LookVector

                    summaryVelocity = summaryVelocity + lookVector * speed;
                end
                if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and camera and UserInputService:IsKeyDown(Enum.KeyCode.A)) then
                    
                    local rightVector = camera.CFrame.RightVector

                    summaryVelocity = summaryVelocity + -rightVector * speed;
                end
                if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and camera and UserInputService:IsKeyDown(Enum.KeyCode.D)) then
                    
                    local rightVector = camera.CFrame.RightVector

                    summaryVelocity = summaryVelocity + rightVector * speed;
                end
                if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and camera and UserInputService:IsKeyDown(Enum.KeyCode.S)) then
                    
                    local lookVector = camera.CFrame.LookVector;

                    summaryVelocity = summaryVelocity + -lookVector * speed;
                end
                
                if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart")) then
                    plr.Character.Humanoid.Jump = true;
                    plr.Character.HumanoidRootPart.Velocity = summaryVelocity + randomization + Vector3.new(0, (gamecl:GetService("Workspace").Gravity / 196.2), 0);
                end

            else

                getgenv().whitelist = true

                local camera = gamecl:GetService("Workspace").CurrentCamera

                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and summaryPosition == nil) then

                    plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                    summaryPosition = plr.Character.HumanoidRootPart.Position

                end
                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.W)) then

                    summaryPosition = summaryPosition + camera.CFrame.LookVector * (speed / 100);

                end
                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.A)) then

                    summaryPosition = summaryPosition + -camera.CFrame.RightVector * (speed / 100);

                end
                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.D)) then

                    summaryPosition = summaryPosition + camera.CFrame.RightVector * (speed / 100);

                end
                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.S)) then

                    summaryPosition = summaryPosition + -camera.CFrame.LookVector * (speed / 100);

                end
                
                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
                    local x,y,z = camera.CFrame:ToOrientation();

                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(summaryPosition, summaryPosition + camera.CFrame.LookVector);
                elseif (not plr.Character:FindFirstChild("Humanoid") or (plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)) then
                    summaryPosition = nil
                end

            end
            if (plr.Character and plr.Character:FindFirstChild("Humanoid")) then
                plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, freefalling)
            end

            getgenv().whitelist = false
        end
    
    end))
    task.spawn(newcclosure(function()
        while task.wait(0.001) and getgenv().velocityfly do
            while task.wait(rhythm_fly) and getgenv().velocityfly and fly_mode == "v3" do

                if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
                    local hrp = plr.Character.HumanoidRootPart

                    local raycastParams = RaycastParams.new();

                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist;

                    raycastParams.FilterDescendantsInstances = {plr.Character};
                    raycastParams.IgnoreWater = true;

                    local result = gamecl:GetService("Workspace"):Raycast(hrp.Position, Vector3.new(0, -100000, 0), raycastParams);

                    if (result) then
                        local savedpos = hrp.CFrame;
                        hrp.CFrame = CFrame.new(result.Position);
                        hrp.Velocity = Vector3.new(0, -math.abs(result.Position.Y - hrp.Position.Y), 0);
                        task.wait(groundt_fly)
                        hrp.Velocity = Vector3.new(0, math.abs(result.Position.Y - hrp.Position.Y), 0);
                        hrp.CFrame = savedpos;
                    end
                end
            end
        end
    end))
    
    namecallHookSystem(plr.Character.Humanoid, "GetStateEnabled", function() return nil end, getgenv().velocityfly);

    if (not getgenv().velocityfly) then
        plr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
    end

    getgenv().whitelist = false
end

local walkspeed = 0;
local walkspeed_mode = "Change Value";

local walkspeed_default = plr.Character.Humanoid.WalkSpeed

local function onWalkSpeed()
    getgenv().walkspeed = not getgenv().walkspeed

    getgenv().whitelist = true
    task.spawn(newcclosure(function()

        while task.wait() and getgenv().walkspeed do 
            getgenv().whitelist = true
            if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart")) then 
                if (walkspeed_mode == "Change Velocity") then
                    local moveDirection = plr.Character.Humanoid.MoveDirection;

                    local velY = plr.Character.HumanoidRootPart.Velocity.Y;

                    if (moveDirection ~= Vector3.new(0, 0, 0)) then

                        plr.Character.HumanoidRootPart.Velocity = Vector3.new(moveDirection.X * walkspeed, velY, moveDirection.Z * walkspeed);

                    end
                else
                    plr.Character.Humanoid.WalkSpeed = walkspeed;
                end
            end
            getgenv().whitelist = false;
        end
    end))

    indexHookSystem(plr.Character.Humanoid, "WalkSpeed", walkspeed_default, getgenv().walkspeed)

    getgenv().whitelist = false
    

end


local function onForceNoclip()
    getgenv().noclip = not getgenv().noclip

    getgenv().whitelist = true;
    task.spawn(newcclosure(function()

        while task.wait() and getgenv().noclip do
            getgenv().whitelist = true;
            if (plr.Character and plr.Character:FindFirstChild("Humanoid")) then
                
                for _, i in pairs(plr.Character:GetDescendants()) do
                    
                    if (i:IsA("MeshPart") or i:IsA("BasePart") or i:IsA("Part")) then
                        i.CanCollide = false;
                    end

                end

            end
            getgenv().whitelist = false
        end

    end))

    for _, i in pairs(plr.Character:GetChildren()) do
                
        if (i:IsA("MeshPart") or i:IsA("BasePart") or i:IsA("Part")) then
            indexHookSystem(i, "CanCollide", true, getgenv().antitp);
        end

    end

    getgenv().whitelist = false
end
local esp_r = 255
local esp_g = 255
local esp_b = 255
local function onESP()
    getgenv().esp = not getgenv().esp;
    getgenv().whitelist = true
    task.spawn(newcclosure(function()
        
        while task.wait() and getgenv().esp do
            for _, i in pairs(gamecl:GetService("Players"):GetPlayers()) do
                getgenv().whitelist = true
                if (i.Character and i.Name ~= plr.Name) then
                    
                    if (not i.Character:FindFirstChildOfClass("Highlight")) then
                        local Highlight = Instance.new("Highlight", i.Character);
                        Highlight.Name = math.random(-12345678, 12345678);

                        Highlight.Enabled = true;
                        Highlight.FillColor = Color3.fromRGB(esp_r, esp_g, esp_b)
                    else
                        i.Character:FindFirstChildOfClass("Highlight").Enabled = true
                        i.Character:FindFirstChildOfClass("Highlight").FillColor = Color3.fromRGB(esp_r, esp_g, esp_b)
                    end
                end
                getgenv().whitelist = false
            end

        end
    
    end))

    local old;
    old = hookmetamethod(gamecl:GetService("Workspace"), "__namecall", newcclosure(function(self, ...)
        local args = {...};
        if (not getgenv().whitelist and getnamecallmethod() == "FindFirstChildOfClass" and args[1] == "Highlight" and self.Parent ~= nil and gamecl:GetService("Players"):FindFirstChild(self.Parent.Name)) then
            return nil;
        end
        return old(self, ...);
    
    end))


    if (not getgenv().esp) then

        hookmetamethod(gamecl:GetService("Workspace"), "__namecall", old);

        for _, i in pairs(gamecl:GetService("Players"):GetPlayers()) do

            if (i.Character and i.Name ~= plr.Name and i.Character:FindFirstChild("Highlight")) then
                
                i.Character:FindFirstChildOfClass("Highlight").Enabled = false

            end

        end

    end
    getgenv().whitelist = false
end
local previous_player_position;
local write_player_position = true;
local previous_player_velocity;
local function onAntiTP()
    getgenv().antitp = not getgenv().antitp;

    local connection;
    connection = plr.Character.HumanoidRootPart.Changed:Connect(newcclosure(function(key, value)
        getgenv().whitelist = true
        if ((key == "Position" or key == "CFrame") and plr.Character:FindFirstChild("HumanoidRootPart") and getgenv().antitp and not white_anti_tp) then
            write_player_position = false;
            plr.Character.HumanoidRootPart.CFrame = previous_player_position
            plr.Character.HumanoidRootPart.Velocity = previous_player_velocity
        elseif (getgenv().antitp) then
            write_player_position = true;
        end
        getgenv().whitelist = false
    end))

    plr.CharacterAdded:Connect(newcclosure(function()
        
        connection:Disconnect();
        task.spawn(newcclosure(function()
            while task.wait() and getgenv().antitp do
                if (plr.Character:FindFirstChild("HumanoidRootPart")) then
                    connection = plr.Character.HumanoidRootPart.Changed:Connect(newcclosure(function(key, value)
                        getgenv().whitelist = true
                        if ((key == "Position" or key == "CFrame") and plr.Character:FindFirstChild("HumanoidRootPart") and getgenv().antitp and not white_anti_tp) then
                            write_player_position = false;
                            plr.Character.HumanoidRootPart.CFrame = previous_player_position
                            plr.Character.HumanoidRootPart.Velocity = previous_player_velocity
                        elseif (getgenv().antitp) then
                            write_player_position = true;
                        end
                        getgenv().whitelist = false
                    end))
                    break;
                end
            end
        end))
    end))

    local renderstepped = RunService.RenderStepped:Connect(newcclosure(function()
        getgenv().whitelist = true
        if (plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") and write_player_position and getgenv().antitp and not white_anti_tp) then
            
            previous_player_position = plr.Character.HumanoidRootPart.CFrame
            previous_player_velocity = plr.Character.HumanoidRootPart.Velocity
        end
        getgenv().whitelist = false
    end))

    if (not getgenv().antitp) then
        renderstepped:Disconnect();
    end

end
local sumPosition_flinger = nil
local flingspeed = 100;
local flingstrength = 2000;
local function onFlinger()
    getgenv().flinger = not getgenv().flinger
    task.spawn(newcclosure(function()
        while task.wait() and getgenv().flinger do
            
            getgenv().whitelist = true

            local camera = gamecl:GetService("Workspace").CurrentCamera

            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and sumPosition_flinger == nil) then

                plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
                sumPosition_flinger = plr.Character.HumanoidRootPart.Position

            end
            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.W)) then

                sumPosition_flinger = sumPosition_flinger + camera.CFrame.LookVector * (flingspeed / 100);

            end
            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.A)) then

                sumPosition_flinger = sumPosition_flinger + -camera.CFrame.RightVector * (flingspeed / 100);

            end
            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.D)) then

                sumPosition_flinger = sumPosition_flinger + camera.CFrame.RightVector * (flingspeed / 100);

            end
            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and UserInputService:IsKeyDown(Enum.KeyCode.S)) then

                sumPosition_flinger = sumPosition_flinger + -camera.CFrame.LookVector * (flingspeed / 100);
    
            elseif (not plr.Character:FindFirstChild("Humanoid") or (plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)) then
                summaryPosition = nil

            end
            
            if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")) then
                local x,y,z = camera.CFrame:ToOrientation();
                plr.Character.HumanoidRootPart.CFrame = CFrame.new(sumPosition_flinger, sumPosition_flinger + camera.CFrame.LookVector);
                
                for _, i in pairs(plr.Character:GetDescendants()) do
                    
                    if (i:IsA("BasePart") or i:IsA("Part")) then
                        i.CanCollide = true;
                        i.AssemblyLinearVelocity = Vector3.new(flingstrength, flingstrength, flingstrength);
                    end

                end
            else
                sumPosition_flinger = nil
            end

            getgenv().whitelist = false

        end
    end))

    if (not getgenv().flinger) then
        plr.Character.HumanoidRootPart.Velocity = Vector3.zero
    end
end

local function onClientGodMode()
    getgenv().clientgodmode = not getgenv().clientgodmode
    local old;
    if (plr.Character:FindFirstChild("Humanoid")) then
        old = hookmetamethod(plr.Character.Humanoid, "__newindex", newcclosure(function(self, key, value)
            
            if (key == "Health" and not checkcaller() and getgenv().clientgodmode) then
                value = self.MaxHealth - 0.01
            end
            return old(self, key, value)
        end))

    end
end

UserInputService.InputBegan:Connect(InputSystem)

Watermark:Keybind({
   Text = "Toggle UI",
   Default = Enum.KeyCode.Insert,
   Callback = function()
       Library:Toggle()
   end
})

Player:Toggle({
   Text = "Noclip",
   Callback = newcclosure(onForceNoclip)
})
Player:Toggle({
   Text = "Anti Teleport",
   Callback = newcclosure(onAntiTP)
})

Movement:Toggle({
   Text = "Infinite Jump",
   Callback = newcclosure(onVelocityJump)
})
Movement:Slider({
   Text = "Jump Boost",
   Default = 60,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       jumpboost = value
   end)
})
Fly_tab:Toggle({
   Text = "Fly",
   Callback = newcclosure(onVelocityFly)
})
Fly_tab:Toggle({
   Text = "Freefall Enabled",
   Callback = newcclosure(function(val)

        freefalling = val;

   end)
})

Fly_tab:Dropdown({
   Text = "Mode",
   List = {"v1", "v2", "v3"},
   Callback = function(val)
        fly_mode = val;
   end
})
Fly_tab:Slider({
   Text = "Rhythm (v3)",
   Default = 50,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       rhythm_fly = (value / 100)
   end)
})
Fly_tab:Slider({
   Text = "Ground Time (v3)",
   Default = 1,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       groundt_fly = (value / 1000)
   end)
})

Fly_tab:Dropdown({
   Text = "Additional",
   List = {"None", "Fly Randomization", "Fly Y Randomization"},
   Callback = function(val)
        randomize_fly = val;
   end
})

Fly_tab:Slider({
   Text = "Speed",
   Default = 10,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       speed = value
   end)
})
Movement:Toggle({
   Text = "Walkspeed Changer",
   Callback = newcclosure(onWalkSpeed)
})
Movement:Dropdown({
   Text = "Changer Mode",
   List = {"Change Value", "Change Velocity"},
   Callback = function(val)
        walkspeed_mode = val;
   end
})
Movement:Slider({
   Text = "Speed",
   Default = 20,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       walkspeed = value
   end)
})
Disable:Toggle({
   Text = "Disable Client-Sided Kick",
   Callback = newcclosure(onHookKick)
})
Disable:Toggle({
   Text = "Disable Client-Sided Death",
   Callback = newcclosure(onClientGodMode)
})
ESP:Toggle({
   Text = "Player ESP",
   Callback = newcclosure(onESP)
})
ESP:Slider({
   Text = "Red",
   Default = 60,
   Minimum = 0,
   Maximum = 255,
   Callback = newcclosure(function(value)
       esp_r = value
   end)
})
ESP:Slider({
   Text = "Green",
   Default = 60,
   Minimum = 0,
   Maximum = 255,
   Callback = newcclosure(function(value)
       esp_b = value
   end)
})
ESP:Slider({
   Text = "Blue",
   Default = 60,
   Minimum = 0,
   Maximum = 255,
   Callback = newcclosure(function(value)
       esp_g = value
   end)
})
Unsafe:Toggle({
   Text = "Fling Mode",
   Callback = newcclosure(onFlinger)
})
Unsafe:Slider({
   Text = "Fling Strength",
   Default = 2000,
   Minimum = 0,
   Maximum = 10000,
   Callback = newcclosure(function(value)
       flingstrength = value
   end)
})
Unsafe:Slider({
   Text = "Fly Speed",
   Default = 100,
   Minimum = 0,
   Maximum = 500,
   Callback = newcclosure(function(value)
       flingspeed = value
   end)
})
