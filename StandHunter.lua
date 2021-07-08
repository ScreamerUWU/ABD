local StandUserFound = false
local StandWanted = { 10, 25 }

--[[ 
WHITESNAKE = 30
STAR PLATINUM = 2
THE WORLD = 4
DOPPIO ( 1 ) = 10
]]--

local Hop = (game:HttpGet("https://raw.githubusercontent.com/ScreamerUWU/MISC/main/Hop.lua"))
local Notify;

if not game.IsLoaded then 
   game.Loaded:Wait(); 
   
   local Player = game.Players.LocalPlayer 

   Player.CharacterAdded:Wait()
   
   wait(5)
end

local ConfigName = ("ABDHCONFIG.JSON")
local ConfigDefault = ('["CurrentScript": "https://raw.githubusercontent.com/ScreamerUWU/ABD/main/StandHunter.lua"]')

local UpdateCurrent = function(Number)

   if isfile(ConfigName) then
       print("Is File")
   else
       writefile(ConfigName, ConfigDefault)
   end


   if (Number) == (1) then

      local Table = game:GetService("HttpService"):JSONDecode(File); Table.CurrentScript = ("https://raw.githubusercontent.com/ScreamerUWU/ABD/main/FrogHunter.lua")
      local NewTable = game:GetService("HttpService"):JSONEncode(File)

      writefile(ConfigName, NewTable)
  
   elseif (Number) == (2) then
      
      local Table = game:GetService("HttpService"):JSONDecode(File); Table.CurrentScript = ("https://raw.githubusercontent.com/ScreamerUWU/ABD/main/StandHunter.lua")
      local NewTable = game:GetService("HttpService"):JSONEncode(File)

      writefile(ConfigName, NewTable)
   end
end

Notify = function(Text, Duration)
   game.StarterGui:SetCore("SendNotification", {Title = "Stand Hunter:", Text = Text, Duration = Duration })
end

local HasStand = { }
local DamageYield = (game.ReplicatedStorage:WaitForChild("Damage"))

for x, y in pairs(game.Players:GetPlayers()) do
   if y:FindFirstChild("Data") then
 
      if y:FindFirstChild("Data"):FindFirstChild("Stand") then

         local StandData = tonumber(y:FindFirstChild("Data"):FindFirstChild("Stand").Value)

         if table.find(StandWanted, (StandData)) then
            StandUserFound = true
            table.insert(HasStand, y.Name)
            wait()
         end
      end
   end
end

if not StandUserFound then
   loadstring(Hop)()
else
   if StandUserFound then

      local BreakTradeLoop = false
     
      local Module = (loadstring(game:HttpGetAsync('https://pastebin.com/raw/edJT9EGX'))())
      local ModuleWindow = Module:CreateWindow("Server Hop")
      local ModuleButton = ModuleWindow:AddButton({text = "Start", callback = function() loadstring(Hop)() end})
      local ModuleButton = ModuleWindow:AddButton({text = "Break", callback = function() BreakTradeLoop = true end})
      local CW = Module:CreateWindow("Config")

      CW:AddButton({
        text = "Frog Hunter",
        callback = function() UpdateCurrent(1) end
      })

      CW:AddButton({
        text = "Stand Hunter",
        callback = function() UpdateCurrent(2) end
      }) 
      
      Module:Init()

      for i = 1,#HasStand do
         Notify(HasStand[i] .. " has your stand!", 10)
      end

      local RandomPlayer = HasStand[math.random(1, #HasStand)]

      wait(2)

      Notify(RandomPlayer .. " was sent a trade request", 5)

      
      if table.find(StandWanted, game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Stand").Value) then Notify("Stand already obtained! ( active )", 10) return end

      while wait() do
         game.Players:Chat("!trade " .. RandomPlayer);

         if BreakTradeLoop then 
            Notify("Broken the trade loop.", 10) 
            print("Reason:", "Broken the trade loop.")
            break; 
         end
         
         if table.find(StandWanted, game.Players.LocalPlayer:WaitForChild("Data"):WaitForChild("Stand").Value) then 
            Notify("Broken the trade loop due trade completed or stand obtained.", 10) 
            print("Reason:", "trade completed or stand obtained.")
            break;
         end

         if not game.Players:FindFirstChild(RandomPlayer) then 
            Notify("Broken the trade loop due to player leaving.", 10) 
            print("Reason:", "player leaving.")
            break; 
         end
         
         if game.Players:FindFirstChild(RandomPlayer) then
            if not table.find(StandWanted, tonumber(game.Players:FindFirstChild(RandomPlayer):FindFirstChild("Data"):FindFirstChild("Stand").Value)) then
               Notify("Broken the trade loop due to stand change.", 10)
               print("Reason:", "stand change.")
               break;
            end
         end

      end

      local CancelYield = 0
      
      repeat wait() game.Players:Chat("!cancel") until CancelYield == 50 or CancelYield > 50
   end
end
