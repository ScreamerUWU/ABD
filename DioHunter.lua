--[[ VARIABLES ]]--

local Hop = game:HttpGet("https://raw.githubusercontent.com/ScreamerUWU/MISC/main/Hop.lua")
local ServerHook = ("https://discord.com/api/webhooks/861402224383229973/ZhmsiuvqmpcQtuyWxt6W_mHJbQ6mqiRampqB01MFXAMA1PjpWIIub8QhxDAaNY052twX")

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

local AutoExecute = false
local WaitForDio = {
 On = true,
 Time = 50,
 TimeMax = 58,
 HourMax = 9,
 SmallerCheck = {
  Highest = 58,
  TimeWait = 53
 }
}

local Notif;
local Player;

--[[ GAME LOADED / AUTOEXECUTE CHECK ]]--

if not game.IsLoaded then
   game.Loaded:Wait()
   repeat wait() until game.Players.LocalPlayer; Player = game.Players.LocalPlayer
   AutoExecute = true
else
   repeat wait() until game.Players.LocalPlayer; Player = game.Players.LocalPlayer
end

--[[ NOTIFY FUNCTION ]]--

Notif = function(Title, Text, Duration)
   game.StarterGui:SetCore("SendNotification", {Title = Title, Text = Text, Duration = Duration })
end

--[[ CHARACTER ADDED ]]--

if AutoExecute then
   Player.CharacterAdded:Wait()
   Player.CharacterAdded:Wait()
else
   warn(" ~ Player Not AE ~")
end

--[[ SERVER LOG FUNCTION ]]--

local ServerTable = {
 content = "", 
 embeds = {{
   title = "Server Log",
   description = "**TEXT**",
   type = "rich",
   color = 8063733
 }} 
}

local CreateHopGUI = function()
   local Module = (loadstring(game:HttpGetAsync('https://pastebin.com/raw/edJT9EGX'))())
   local ModuleWindow = Module:CreateWindow("Server Hop")
   local ModuleButton = ModuleWindow:AddButton({text = "Start", callback = function() loadstring(Hop)() end})
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

local CheckJ = function(Table, JobID)

   local Temp = { }
   local Amnt = 0

   for i = 1,#Table do
      if Table[i] == JobID then
         print(i)
         table.insert(Temp, JobID)
      end
      if Table[i] == (JobID .. " (" .. tostring(i) .. ")") then
         table.insert(Temp, JobID)
      end
   end

   for i = 1,#Temp do
      Amnt = Amnt + 1
   end

   if Temp[1] ~= nil then
      return (JobID .. " (" .. tostring(Amnt) .. ")")
   else
      return JobID
   end
end

local ServerLog = function(JobID, Time)
   if isfile("DioFarm.JSON") then
      local Decode = (game:GetService("HttpService"):JSONDecode(readfile("DioFarm.JSON"))); table.insert(Decode, CheckJ(Decode, JobID)); writefile("DioFarm.JSON", game:GetService("HttpService"):JSONEncode(Decode))
       ServerTable.embeds[1].description = ServerTable.embeds[1].description:gsub("TEXT", ("ServerID: " .. JobID .. "\nTime: " .. Time.Hour .. " Hours, " .. Time.Minute .. " Minutes, " .. Time.Second .. " Seconds."))
       syn.request({Url = ServerHook, Method = "POST", Headers = {['Content-Type'] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode(ServerTable)})
   else
      local NewTable = {JobID}; local Encode = game:GetService("HttpService"):JSONEncode(NewTable); writefile("DioFarm.JSON", Encode)
   end
end 

--[[ SET REMOTE / ARGUMENT TABLE ]]--

local Remote;
local RemoteArgs;

Remote = game:GetService("ReplicatedStorage"):WaitForChild("Damage3")
RemoteArgs = {
    [1] = nil,
    [2] = CFrame.new(Vector3.new(-6279.55078125, 582.18225097656, -379.61291503906), Vector3.new(0.99393075704575, -0.092148125171661, 0.060085330158472)),
    [3] = 99,
    [4] = 0,
    [5] = nil,
    [6] = 0.1,
    [7] = "rbxassetid://7045722063",
    [8] = 1,
    [9] = 100 
}


--[[ SET FUNCTIONS ]]--

local noclip = false
local Noclip = function()
   
   local ToNC = { "Head", "Torso", "Left Leg", "Right Leg"}
  
   game:GetService("RunService").Stepped:Connect(function(...)
       if game:GetService("Players").LocalPlayer.Character then
          if noclip then
             for i = 1,#ToNC do game:GetService("Players").LocalPlayer.Character[ToNC[i]].CanCollide = false end
          end
       end
   end)
end

Noclip()

local GetRoot = function()
   if game:GetService("Players").LocalPlayer.Character then
      if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

         local HRP = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

         return { Root = HRP, CurrentCFrame = HRP.CFrame }
      end
   end
end

local FD = function()
   
   local EntityFolder = workspace:WaitForChild("Entities")
   local ReturnTable = {
    Found = true,
    Dio = nil
   }

   if EntityFolder:FindFirstChild("DIO") then
      ReturnTable.Found = true
      ReturnTable.Dio = EntityFolder:FindFirstChild("DIO")
   else
      ReturnTable.Found = false
      ReturnTable.Dio = nil
   end

   return ReturnTable
end

local KD = function()
   
   local DioInfo = (FD())

   if DioInfo.Dio ~= nil then

      local DioHumanoid = DioInfo.Dio:WaitForChild("Humanoid")
      local DioHRP = DioInfo.Dio:WaitForChild("HumanoidRootPart")
      local PlayerHRP = GetRoot().Root
      local PlayerCF = PlayerHRP.CFrame

      local DioArgs = RemoteArgs; DioArgs[1] = DioHumanoid; DioArgs[5] = DioHRP.Position
 
      local Killed = false

      DioHumanoid.Died:Connect(function(...)
          Killed = true
      end)
      
      noclip = true
      PlayerHRP.CFrame = DioHRP.CFrame
      wait(.1)
      for i = 1,200 do PlayerHRP.CFrame = DioHRP.CFrame; Remote:FireServer(unpack(DioArgs)) if Killed then break; end end
      repeat wait() if not Killed then PlayerHRP.CFrame = DioHRP.CFrame; Remote:FireServer(unpack(DioArgs)) end until Killed
      noclip = false
   end
end

local WebHook = ("https://discord.com/api/webhooks/860222666510041119/WMks8FoCkdPr9zGK_-bcvShyVVFF8grxqYD3xFJB_5OZrK1LjJ_4yqgJ_0kfwEtqP3Ar")
local WebHookTable = {
 content = "<@843901658320470020>", 
 embeds = {{
   title = "Item Obtained!",
   description = "",
   type = "rich",
   color = 8063733,
   image = {
    url = "http://www.roblox.com/Thumbs/Avatar.ashx?x=352&y=352&Format=Png&username=ROBLOX"
   }
 }} 
}

local Count;
local ReturningCFrame;

Count = 0
ReturningCFrame = CFrame.new(2098.68628, -214.699982, -939.409241, 0.999072194, 1.04759906e-07, 0.0430684164, -1.02432068e-07, 1, -5.62566527e-08, -0.0430684164, 5.17928704e-08, 0.999072194)

local IC = function()

   Notif("Item Collection", "Item Collection Executed!", 3)
  
   local Drops = {
    ["Camera"] = {
      "https://static.wikia.nocookie.net/a-bizarre-day-roblox/images/8/80/Camera.png/revision/latest/scale-to-width-down/310?cb=20210125013951",
      "Item Obtained! ( Camera )"
    },
    ["DIO's Diary"] = {
      "https://static.wikia.nocookie.net/a-bizarre-day-roblox/images/8/83/Dio_diary.jpg/revision/latest/scale-to-width-down/310?cb=20210214165322",
      "Item Obtained! ( DIO's Diary )"
    },
    ["Vampire Mask"] = {
      "https://static.wikia.nocookie.net/a-bizarre-day-roblox/images/9/9a/Vampire_Mask.png/revision/latest/scale-to-width-down/310?cb=20210214165431",
      "Item Obtained! ( Vampire Mask )"
    }
   }
   
   workspace.ChildAdded:Connect(function(Child)
       if Child:IsA("Tool") then
          if Drops[Child.Name] ~= nil then

             local Handle = Child:WaitForChild("Handle")
             local RootInfo = GetRoot()
             local HumanoidRootPart = RootInfo.Root
             local NewWHTable = WebHookTable
             local PickedUp = false

             NewWHTable.embeds[1].image.url = Drops[Child.Name][1]
             NewWHTable.embeds[1].title = Drops[Child.Name][2]

             local Success, Error = pcall(function()
                 syn.request({
                    Url = WebHook, 
                    Method = "POST", 
                    Headers = {
                     ['Content-Type'] = "application/json"
                    }, 
                    Body = game:GetService("HttpService"):JSONEncode(NewWHTable)
                 })
             end)
 
             if not Success then Notif("WebHook Error..", Error, 30) end

             game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(ChildT)
                 if ChildT.Name == (Child.Name) then
                    PickedUp = true
                 end
             end)
 
             game.Players.LocalPlayer.Character.ChildAdded:Connect(function(ChildC)
                 if ChildC.Name == (Child.Name) then
                    PickedUp = true
                 end
             end)

             local YieldTimer = 0

             repeat wait() HumanoidRootPart.CFrame = Handle.CFrame; YieldTimer = YieldTimer + 1; until PickedUp or YieldTimer == 125

             wait()
 
             repeat wait(.5) HumanoidRootPart.CFrame = ReturningCFrame until HumanoidRootPart.CFrame == ReturningCFrame
             Notif("Item Collected", ("Collected: " .. Child.Name), 15)
          end
       end
   end)

end 

--[[ SETUP ]]--

local FullServerAge = (nil)

if WaitForDio.On then

   local ServerAge = (Player:WaitForChild("PlayerGui"):WaitForChild("MenuGUI"):WaitForChild("ServerAge", 5))
   local ServerAge = (Player:WaitForChild("PlayerGui"):WaitForChild("MenuGUI"):WaitForChild("ServerAge", 5))

   repeat wait() until ServerAge.Text ~= ("Server Age: ") or ServerAge.Text ~= ("Server Age:")

   local ServerAgeText = ServerAge.Text:gsub("Server Age: ", "")

   local ServerAgeHour = ServerAgeText:sub(1,2)
   local ServerAgeMinute = ServerAgeText:sub(4,5)
   local ServerAgeSecond = ServerAgeText:sub(7,8)

   if ServerAgeSecond:sub(1) == ("0") then
      ServerAgeSecond = ServerAgeSecond:sub(2)
   end

   if ServerAgeMinute:sub(1) == ("0") then
      ServerAgeMinute = ServerAgeMinute:sub(2)
   end

   if ServerAgeHour:sub(1) == ("0") then
      ServerAgeHour = ServerAgeHour:sub(2)
   end

   FullServerAge = {
    Hour = ServerAgeHour,
    Minute = ServerAgeMinute,
    Second = ServerAgeSecond
   }
   
   local HourCheck = tonumber(ServerAgeHour) >= (WaitForDio.HourMax + 1)
   local MinuteCheck = tonumber(ServerAgeMinute) >= (WaitForDio.Time)
   local MaxCheck = tonumber(ServerAgeMinute) >= (WaitForDio.TimeMax)

   local SmallChecks = (WaitForDio.SmallerCheck)
   local SmallHour = (tonumber(ServerAgeHour) <= SmallChecks.Highest)
   local SmallTime = (tonumber(ServerAgeMinute) >= SmallChecks.TimeWait)

   if HourCheck and not FD().Found then
      Notif("Hour Check", "Over ( Hopping )", 10)
      ServerLog(game.JobId, FullServerAge)
      loadstring(Hop)()
   else
      if not HourCheck then
         if MinuteCheck and not MaxCheck and not SmallHour then
            
            Notif("Dio TimeOut", "Waiting for DIO to spawn!", 10)

            repeat
                  wait()
            until workspace:WaitForChild("Entities"):FindFirstChild("DIO")
         end
         if SmallHour and SmallTime then
            Notif("Dio TimeOut", "Waiting for DIO to spawn!", 10)

            repeat
                  wait()
            until workspace:WaitForChild("Entities"):FindFirstChild("DIO")
         end
      end
   end
end

IC()

if FD().Found then
   Notif("Dio Finder", "Dio Was Found!", 5)
   CreateHopGUI()
   KD()
   ServerLog(game.JobId, FullServerAge)
else
   if not FD().Found then
      Notif("Dio Finder", "Dio Wasn't Found!", 5)
      ServerLog(game.JobId, FullServerAge)
      loadstring(Hop)()
   end
end

