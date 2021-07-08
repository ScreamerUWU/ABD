if not game.IsLoaded then game.Loaded:Wait() end

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

if not FrogFound then
   while true do wait() pcall(function() loadstring(Hop)() end) end
else
    local Module = (loadstring(game:HttpGetAsync('https://pastebin.com/raw/edJT9EGX'))())
    local ModuleWindow = Module:CreateWindow("Server Hop")
    local ModuleButton = ModuleWindow:AddButton({text = "Start", callback = function() loadstring(Hop)() end})

    Module:Init()
end
