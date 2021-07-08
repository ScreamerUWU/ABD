if not game.IsLoaded then game.Loaded:Wait() end

local ConfigName = ("ABDHCONFIG.JSON")
local ConfigName = ("ABDHCONFIG.JSON")
local ConfigDefault = {
 CurrentScript = "https://raw.githubusercontent.com/ScreamerUWU/ABD/main/StandHunter.lua"
}
local ConfigFrog = {
 CurrentScript = "https://raw.githubusercontent.com/ScreamerUWU/ABD/main/FrogHunter.lua"
}
local ConfigStand = {
 CurrentScript = "https://raw.githubusercontent.com/ScreamerUWU/ABD/main/StandHunter.lua"
}
local ConfigDio = {
 CurrentScript = "https://raw.githubusercontent.com/ScreamerUWU/ABD/main/DioHunter.lua"
}

local UpdateCurrent = function(Number)

   if isfile(ConfigName) then
       print("Is File")
   else
       writefile(ConfigName, game:GetService("HttpService"):JSONEncode(ConfigDefault))
   end

   local File = (readfile(ConfigName))

   if (Number) == (1) then
       
      writefile(ConfigName, game:GetService("HttpService"):JSONEncode(ConfigFrog))
  
   elseif (Number) == (2) then

      writefile(ConfigName, game:GetService("HttpService"):JSONEncode(ConfigStand))
   elseif (Number) == (3) then
      
      writefile(ConfigName, game:GetService("HttpService"):JSONEncode(ConfigDio))
   end

end

local Hop = (game:HttpGet("https://raw.githubusercontent.com/ScreamerUWU/MISC/main/Hop.lua"))
local Player;

repeat wait() until game.Players.LocalPlayer; Player = game.Players.LocalPlayer
repeat wait() until Player.Character

local ItemFolder = workspace:WaitForChild("ItFolder", 30)

local DamageYield = game.ReplicatedStorage:WaitForChild("Damage")

Player.Character:BreakJoints(); Player.CharacterAdded:Wait()

local FrogFound = false

wait(.5)

for i, v in pairs(ItemFolder:GetChildren()) do
   if v.Name == ("Frog") then
       
      local NoHandle = false
      local PickedUp = false
      local YC = 0
      
      if not v:FindFirstChild("Handle") then NoHandle = true end
      if not FrogFound then FrogFound = true end
      
      local CFrame = v.Handle.CFrame
      
      game.Players.LocalPlayer.Character.ChildAdded:Connect(function(Child) if Child == v then PickedUp = true end end)
      game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(Child) if Child == v then PickedUp = true end end)
      
      if not NoHandle then repeat wait() YC = YC + 1; game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame until YC == 50 or YC > 50 or v.Handle.CFrame ~= CFrame or PickedUp end
   end
end

local Dop2 = function()
   game:GetService("ReplicatedStorage").DoppiotoDoppio2:FireServer()
end

local Dop3 = function()
   game:GetService("ReplicatedStorage").Doppio2toKC:FireServer() 
end

local UseFrog = function()
  
   local Humanoid;
 
   if game.Players.LocalPlayer.Character:FindFirstChild("Frog") then
      if game.Players.LocalPlayer.Data.Stand.Value == (10) then
         Dop2() 
      elseif game.Players.LocalPlayer.Data.Stand.Value == (25) then
         Dop3()
      end  
   end
 
   if game.Players.LocalPlayer.Backpack:FindFirstChild("Frog") and not game.Players.LocalPlayer.Character:FindFirstChild("Frog") then
      
      if game.Players.LocalPlayer.Character then
         
         if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            Humanoid = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
         else
            return
         end
   
         Humanoid:UnequipTools()
         wait()
         Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Frog"))
         
         if game.Players.LocalPlayer.Data.Stand.Value == (10) then
            Dop2() 
         elseif game.Players.LocalPlayer.Data.Stand.Value == (25) then
            Dop3()
         end
   
      end
   end
 
end

if not FrogFound then
   while true do wait() pcall(function() loadstring(Hop)() end) end
else
    local Module = (loadstring(game:HttpGetAsync('https://pastebin.com/raw/edJT9EGX'))())
    local ModuleWindow = Module:CreateWindow("Server Hop")
    local ModuleButton = ModuleWindow:AddButton({text = "Start", callback = function() loadstring(Hop)() end})
    local ModuleButton = ModuleWindow:AddButton({text = "Use Frog", callback = function() UseFrog() end})
   
    local CW = Module:CreateWindow("Config")

    CW:AddButton({
      text = "Frog Hunter",
      callback = function() UpdateCurrent(1) end
    })

    CW:AddButton({
      text = "Stand Hunter",
      callback = function() UpdateCurrent(2) end
    }) 
 
    CW:AddButton({
      text = "DIO Hunter",
      callback = function() UpdateCurrent(3) end
    }) 

    Module:Init()
end
