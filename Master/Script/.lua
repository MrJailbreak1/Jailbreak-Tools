local Hashes = {
	-- NEW 20.11.2020  (thanks to Kal)

	EquipItem = "d7d2a278",
	Eject = "ddefbc4c",
	SendVault = "",
	TeamChange =  "c95ebbec",
	Arrest = "c403456e",
	SpawnVehicle = "c21959cd",
	RopeAttach = "",
	GetDonut = "d926aabb",
	EatDonut = "f9b0feb0",
	EnterVehicle = "d926aabb",
	LockCar = ""
}

local previousHashes = {
	-- OLD 11.12.2020

	EquipItem = "e7217f44",
	Eject = "c09ce270",
	SendVault = "d0620d65",
	TeamChange = "bb200d0f",
	Arrest = "ead4aec1",
	SpawnVehicle = "e054efff",
	RopeAttach = "d5d8e556",
	GetDonut = "bb711e5c",
	EatDonut = "ce153c3b",
	EnterVehicle = "b3bf54da",
	LockCar = "e270edeb"
	--
}

getgenv().utils = {
	["getgc"] = getgc,
	["getupvalue"] = debug.getupvalue or getupvalue,
	["getupvalues"] = debug.getupvalues or getupvalues,
	["setupvalue"] = debug.setupvalue or setupvalue,
	["typeof"] = type or typeof,
	["getconstants"] = debug.getconstants or getconstants,
	["setconstant"] = debug.setconstant or setconstant,
	["getfenv"] = getfenv,
	["getreg"] = getreg or debug.getregistry,
	["islclosure"] = islclosure or is_l_closure
}

getgenv()._GetSysReq = function()
	local REQ = nil
	for i, v in next, getgenv().utils.getgc(true) do
		if getgenv().utils.typeof(v) == "table" then
			if rawget(v, "FireServer") then
				REQ = v
			end
			if getgenv().utils.typeof(rawget(v, "Heli")) == "table" then
				getgenv()._FlyCopter = v
			end
		end
		if
			getgenv().utils.typeof(v) == "function" and
				getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript
		then
			local con = getgenv().utils.getconstants(v)

			if table.find(con, "LastVehicleExit") and table.find(con, "tick") then
				getgenv().__exitcarfunc = v
			end
		end
	end
	getgenv()._SysREQ = REQ
end

getgenv()._currenthashdb = function()
	for i, v in pairs(getgenv().utils.getgc(true)) do
		if getgenv().utils.typeof(v) == "table" then
			for i2, v2 in pairs(v) do
				if getgenv().utils.typeof(v2) == "string" and v2:sub(1, 1) == "!" and #v2 == 37 then
					return v
				end
			end
		end
	end
end

local function GoToNew()
	pcall(
		function()
			if queued == false then
				queued = true
				if getgenv().CollectAirdrops == true then
					crossServerSettings = crossServerSettings .. " getgenv().CollectAirdrops = true "
				end
				if getgenv().PlayerToSendVaults ~= nil then
					crossServerSettings =
						crossServerSettings ..
						' getgenv().PlayerToSendVaults = "' .. getgenv().PlayerToSendVaults .. '" '
				end
				if syn then
					syn.queue_on_teleport(
						crossServerSettings ..
							" loadstring(game:HttpGet('https://raw.githubusercontent.com/Gork3m/Jailbricked/master/ArrestFarm.lua'))()"
					)
				else
					queue_on_teleport(
						crossServerSettings ..
							" loadstring(game:HttpGet('https://raw.githubusercontent.com/Gork3m/Jailbricked/master/ArrestFarm.lua'))()"
					)
				end
			end
		end
	)
	while true do
		pcall(
			function()
				local rnder = Random.new(os.time())
				local rndServerInst = rnder:NextInteger(100, 1000)

				local function HttpGetX(url)
					return game:GetService("HttpService"):JSONDecode(
					game:HttpGet("https://games.roblox.com/v1/games/606849621/servers/Public?limit=100")
					)
				end

				local GameInstances = HttpGetX(rndServerInst)
				pcall(
					function()
						game.StarterGui:SetCore(
							"ChatMakeSystemMessage",
							{
								Text = "Joining to different server!",
								Color = Color3.new(0.2, 0.8, 0.2)
							}
						)
					end
				)
				skipfirstniggers = 0
				for I, V in pairs(GameInstances.data) do
					pcall(
						function()
							if skipfirstniggers > 10 then
								game:GetService("TeleportService"):TeleportToPlaceInstance(606849621, V.id)
								wait(0.2)
							end

							skipfirstniggers = skipfirstniggers + 1
						end
					)
				end
			end
		)
		wait(2)
		pcall(
			function()
				game.StarterGui:SetCore(
					"ChatMakeSystemMessage",
					{
						Text = "Server teleport attempt failed. Forcing user to TP again..",
						Color = Color3.new(0.5, 0, 0)
					}
				)
				wait(3)
				game.StarterGui:SetCore(
					"ChatMakeSystemMessage",
					{
						Text = "Joining to different server (alternative method)!",
						Color = Color3.new(0, 0.6, 0)
					}
				)
			end
		)
		wait(1)
	end
end

loadstarted = os.time()
local function checkTimeout()
	if os.time() - loadstarted > 100 then
		GoToNew()
	end
end


while game == nil do
	wait(0.1)
	checkTimeout()
end

while game:GetService("Players") == nil do
	wait(0.1)
	checkTimeout()
end

while game:GetService("Players").LocalPlayer == nil do
	wait(0.1)
	checkTimeout()
end

while game:GetService("Players").LocalPlayer.Character == nil do
	wait(0.1)
	checkTimeout()
end
local w = game:GetService("Workspace")
while game:GetService("Players").LocalPlayer.Character.HumanoidRootPart == nil do
	wait(0.1)
	checkTimeout()
end
nothingX = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HotbarGui")

if getgenv()._AutoArrestInitialized ~= nil then
	while true do
		wait(19)
	end
end
local adminList = {"fuck_asimo", "ITriedToHelpYou_but_youfuckingrefused"}
local blackList = {"TransRights"}
local tstamp = 1604059200

spawn(
	function()
		spoint = os.time()
		while true do
			wait(1)
			if os.time() - spoint > 180 then
				GoToNew()
				wait(99)
			end
		end
	end
)

local function checkPlayerOutbounds(plrName)
	plrTorso = game:GetService("Players"):FindFirstChild(plrName).Character.HumanoidRootPart

	-- Museum check
	if plrTorso.Position.y < 125 and plrTorso.Position.y > -500 then
		--handle

		if
			plrTorso.Position.x < 1150 and plrTorso.Position.x > 990 and plrTorso.Position.z < 1350 and
				plrTorso.Position.z > 1050
		then
			return "museum"
		end
	end

	if plrTorso.Position.y < 130 and plrTorso.Position.y > -500 then
		--handle

		if
			plrTorso.Position.x < 180 and plrTorso.Position.x > 60 and plrTorso.Position.z < 1400 and
				plrTorso.Position.z > 1230
		then
			return "jew"
		end
	end

	if plrTorso.Position.y < 19 and plrTorso.Position.y > -750 then
		--handle

		if
			plrTorso.Position.x < 250 and plrTorso.Position.x > -150 and plrTorso.Position.z < 1200 and
				plrTorso.Position.z > 400
		then
			return "bank"
		end
	end

	if plrTorso.Position.y < 40 and plrTorso.Position.y > 18 then
		--handle

		if
			plrTorso.Position.x < 150 and plrTorso.Position.x > -50 and plrTorso.Position.z < 1000 and
				plrTorso.Position.z > 600
		then
			return "bank"
		end
	end

	if plrTorso.Position.y < 70 and plrTorso.Position.y > -750 then
		--handle

		if
			plrTorso.Position.x < 811 and plrTorso.Position.x > 637 and plrTorso.Position.z < 2407 and
				plrTorso.Position.z > 2194
		then
			return "powerplant"
		end
	end

	return true
end

local AutoFarm = Instance.new("ScreenGui")
local Frame = Instance.new("ImageLabel")
local TabsFrame = Instance.new("TextLabel")
local TabsFrameRound = Instance.new("ImageLabel")
local UIListLayout = Instance.new("UIListLayout")
local Store = Instance.new("TextLabel")
local Stat = Instance.new("TextLabel")
local Dosh = Instance.new("TextLabel")
local ServerBread = Instance.new("TextLabel")
local Dis = Instance.new("TextLabel")
local Name = Instance.new("TextLabel")
local Name2 = Instance.new("TextLabel")
local SubName = Instance.new("TextLabel")
local Cent = Instance.new("TextLabel")
local CentRound = Instance.new("ImageLabel")
local Frame_2 = Instance.new("Frame")
local UIGridLayout = Instance.new("UIGridLayout")
local Toggle = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")
local ToggleNAme = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local Blue = Instance.new("ImageButton")
local Gray = Instance.new("ImageButton")

AutoFarm.Name = "AutoFarm"
AutoFarm.Parent = game.CoreGui
AutoFarm.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
AutoFarm.ResetOnSpawn = false

Frame.Name = "Frame"
Frame.Parent = AutoFarm
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 1.000
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.Position = UDim2.new(0.0840806589, 0, 0.32713306, 0)
Frame.Size = UDim2.new(0, 513, 0, 306)
Frame.Image = "rbxassetid://3570695787"
Frame.ImageColor3 = Color3.fromRGB(6, 6, 70)
Frame.ScaleType = Enum.ScaleType.Slice
Frame.SliceCenter = Rect.new(100, 100, 100, 100)
Frame.SliceScale = 0.060

TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = Frame
TabsFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TabsFrame.BackgroundTransparency = 1.000
TabsFrame.BorderSizePixel = 0
TabsFrame.Position = UDim2.new(0.00779727101, 0, 0.359477133, 0)
TabsFrame.Size = UDim2.new(0, 160, 0, 182)
TabsFrame.Font = Enum.Font.SourceSans
TabsFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
TabsFrame.TextSize = 14.000

TabsFrameRound.Name = "TabsFrameRound"
TabsFrameRound.Parent = TabsFrame
TabsFrameRound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TabsFrameRound.BackgroundTransparency = 1.000
TabsFrameRound.Position = UDim2.new(0, 0, -0.214285716, 0)
TabsFrameRound.Size = UDim2.new(1, 0, 1.21428549, 0)
TabsFrameRound.Image = "rbxassetid://3570695787"
TabsFrameRound.ImageColor3 = Color3.fromRGB(22, 22, 22)
TabsFrameRound.ScaleType = Enum.ScaleType.Slice
TabsFrameRound.SliceCenter = Rect.new(100, 100, 100, 100)
TabsFrameRound.SliceScale = 0.060

UIListLayout.Parent = TabsFrameRound
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Store.Name = "Store"
Store.Parent = TabsFrameRound
Store.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Store.BackgroundTransparency = 1.000
Store.Size = UDim2.new(0, 164, 0, 31)
Store.Font = Enum.Font.GothamSemibold
Store.Text = "Jailbreak is"
Store.TextColor3 = Color3.fromRGB(255, 255, 255)
Store.TextSize = 16.000

Stat.Name = "Stat"
Stat.Parent = TabsFrameRound
Stat.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Stat.BackgroundTransparency = 1.000
Stat.Size = UDim2.new(0, 164, 0, 31)
Stat.Font = Enum.Font.GothamSemibold
Stat.Text = "Waiting For Stores"
Stat.TextColor3 = Color3.fromRGB(255, 255, 255)
Stat.TextSize = 16.000

Dosh.Name = "Dosh"
Dosh.Parent = TabsFrameRound
Dosh.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dosh.BackgroundTransparency = 1.000
Dosh.Size = UDim2.new(0, 164, 0, 31)
Dosh.Font = Enum.Font.GothamSemibold
Dosh.Text = "0$"
Dosh.TextColor3 = Color3.fromRGB(255, 255, 255)
Dosh.TextSize = 16.000

ServerBread.Name = "ServerBread"
ServerBread.Parent = TabsFrameRound
ServerBread.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ServerBread.BackgroundTransparency = 1.000
ServerBread.Size = UDim2.new(0, 164, 0, 31)
ServerBread.Font = Enum.Font.GothamSemibold
ServerBread.Text = "Bounty Value:  0 "
ServerBread.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerBread.TextSize = 16.000

Dis.Name = "Dis"
Dis.Parent = Frame
Dis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dis.BackgroundTransparency = 1.000
Dis.Position = UDim2.new(0, 0, 0.954248369, 0)
Dis.Size = UDim2.new(0, 168, 0, 14)
Dis.Font = Enum.Font.GothamSemibold
Dis.Text = "https://discord.gg/ktewgqNSTN"
Dis.TextColor3 = Color3.fromRGB(255, 255, 255)
Dis.TextSize = 9.000

Name.Name = "Name"
Name.Parent = Frame
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.Position = UDim2.new(0.0662768036, 0, 0.055555556, 0)
Name.Size = UDim2.new(0, 52, 0, 27)
Name.Font = Enum.Font.GothamBold
Name.Text = "Jail"
Name.TextColor3 = Color3.fromRGB(0, 170, 255)
Name.TextSize = 25.000

Name2.Name = "Name2"
Name2.Parent = Frame
Name2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name2.BackgroundTransparency = 1.000
Name2.Position = UDim2.new(0.167641327, 0, 0.055555556, 0)
Name2.Size = UDim2.new(0, 52, 0, 27)
Name2.Font = Enum.Font.GothamBold
Name2.Text = "Break"
Name2.TextColor3 = Color3.fromRGB(255, 170, 0)
Name2.TextSize = 25.000

SubName.Name = "Sub Name"
SubName.Parent = Frame
SubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SubName.BackgroundTransparency = 1.000
SubName.Position = UDim2.new(0.0662768036, 0, 0.143790871, 0)
SubName.Size = UDim2.new(0, 104, 0, 20)
SubName.Font = Enum.Font.GothamBold
SubName.Text = "Tools"
SubName.TextColor3 = Color3.fromRGB(255, 255, 255)
SubName.TextSize = 25.000

Cent.Name = "Cent"
Cent.Parent = Frame
Cent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cent.BackgroundTransparency = 1.000
Cent.Position = UDim2.new(0.362573087, 0, 0.0130718956, 0)
Cent.Size = UDim2.new(0, 318, 0, 297)
Cent.Font = Enum.Font.SourceSans
Cent.TextColor3 = Color3.fromRGB(0, 0, 0)
Cent.TextSize = 14.000

CentRound.Name = "CentRound"
CentRound.Parent = Cent
CentRound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CentRound.BackgroundTransparency = 1.000
CentRound.Size = UDim2.new(0, 318, 0, 296)
CentRound.Image = "rbxassetid://3570695787"
CentRound.ImageColor3 = Color3.fromRGB(9, 12, 97)
CentRound.ScaleType = Enum.ScaleType.Slice
CentRound.SliceCenter = Rect.new(100, 100, 100, 100)
CentRound.SliceScale = 0.060

Frame_2.Parent = Cent
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BackgroundTransparency = 1.000
Frame_2.Position = UDim2.new(0.0188679248, 0, 0.0101010101, 0)
Frame_2.Size = UDim2.new(0, 305, 0, 289)

UIGridLayout.Parent = Frame_2
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 150, 0, 40)

Toggle.Name = "Toggle"
Toggle.Parent = Frame_2
Toggle.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Toggle.BackgroundTransparency = 1.000
Toggle.Size = UDim2.new(0, 200, 0, 50)
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

ImageLabel.Parent = Toggle
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Size = UDim2.new(0, 151, 0, 40)
ImageLabel.Image = "rbxassetid://3570695787"
ImageLabel.ImageColor3 = Color3.fromRGB(26, 26, 26)
ImageLabel.ScaleType = Enum.ScaleType.Slice
ImageLabel.SliceCenter = Rect.new(100, 100, 100, 100)
ImageLabel.SliceScale = 0.060

ToggleNAme.Name = "Toggle NAme"
ToggleNAme.Parent = Toggle
ToggleNAme.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleNAme.BackgroundTransparency = 1.000
ToggleNAme.Position = UDim2.new(0, 0, 0.100000001, 0)
ToggleNAme.Size = UDim2.new(0, 128, 0, 32)
ToggleNAme.Font = Enum.Font.GothamSemibold
ToggleNAme.Text = "Auto Arrest"
ToggleNAme.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleNAme.TextSize = 14.000

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = Toggle
ToggleButton.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
ToggleButton.BackgroundTransparency = 1.000
ToggleButton.Position = UDim2.new(0.853333354, 0, 0.275000006, 0)
ToggleButton.Size = UDim2.new(0, 17, 0, 17)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = ""
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 14.000

Blue.Name = "Blue"
Blue.Parent = ToggleButton
Blue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Blue.BackgroundTransparency = 1.000
Blue.Size = UDim2.new(1, 0, 1, 0)
Blue.Image = "rbxassetid://3570695787"
Blue.ImageColor3 = Color3.fromRGB(0, 170, 255)
Blue.ScaleType = Enum.ScaleType.Slice
Blue.SliceCenter = Rect.new(100, 100, 100, 100)
Blue.SliceScale = 0.040

Gray.Name = "Gray"
Gray.Parent = ToggleButton
Gray.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Gray.BackgroundTransparency = 1.000
Gray.Size = UDim2.new(1, 0, 1, 0)
Gray.Image = "rbxassetid://3570695787"
Gray.ImageColor3 = Color3.fromRGB(81, 81, 81)
Gray.ScaleType = Enum.ScaleType.Slice
Gray.SliceCenter = Rect.new(100, 100, 100, 100)
Gray.SliceScale = 0.040

Frame.Active = true
Frame.Selectable = true
Frame.Draggable = true

Gray.MouseButton1Click:Connect(function()
	Blue.Visible = true
	Gray.Visible = false
end)

Blue.MouseButton1Click:Connect(function()
	Gray.Visible = true
	Blue.Visible = false
end)

local function collectAirdropsCall(cb, isEnabled)
	if isEnabled then
		getgenv().CollectAirdrops = true

		game.StarterGui:SetCore(
			"ChatMakeSystemMessage",
			{
				Text = "Geting Extra Money For You Daddy :).",
				Color = Color3.new(0, 1, 0)
			}
		)
	else
		getgenv().CollectAirdrops = nil

		game.StarterGui:SetCore(
			"ChatMakeSystemMessage",
			{
				Text = "Your Not Geting Any Extra Money Daddy :(.",
				Color = Color3.new(1, 0, 0)
			}
		)
	end
end

local function FpsBoost()
	local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
	local g = game
	local w = g:GetService("Workspace")
	local l = g:GetService("Lighting")
	local t = w.Terrain
	t.WaterWaveSize = 0
	t.WaterWaveSpeed = 0
	t.WaterReflectance = 0
	t.WaterTransparency = 0
	l.GlobalShadows = false
	l.FogEnd = 9e9
	l.Brightness = 0
	pcall(
		function()
			settings().Rendering.QualityLevel = "Level01"
		end
	)
	for i, v in pairs(g:GetDescendants()) do
		if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") and decalsyeeted then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i, e in pairs(l:GetChildren()) do
		if
			e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or
				e:IsA("DepthOfFieldEffect")
		then
			e.Enabled = false
		end
	end
end
print("BURDA")

pcall(
	function()
		FpsBoost()
	end
)
nothing = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HotbarGui")
while game:GetService("Players").LocalPlayer.Character == nil do
	wait()
end
local w = game:GetService("Workspace")
while game:GetService("Players").LocalPlayer.Character.HumanoidRootPart == nil do
	wait()
end

pcall(
	function()
		game.StarterGui:SetCore(
			"ChatMakeSystemMessage",
			{
				Text = "Starting.. (1/5)",
				Color = Color3.new(0, 0.2, 0.2)
			}
		)
	end
)
wait(0.1)
print("BURDA 2")
pcall(
	function()
		FpsBoost()
	end
)
print("BURDA 3")
breaklimit = 0
while breaklimit < 10 do
	wait(0.1)
	if w:GetRealPhysicsFPS() > 15 then
		breaklimit = breaklimit + 1
	else
		breaklimit = 0
	end
end
game.StarterGui:SetCore(
	"ChatMakeSystemMessage",
	{
		Text = "Starting.. (2/5)",
		Color = Color3.new(0, 0.4, 0.4)
	}
)

-- #########################################################################################################################################

isjbupdated = true
for i, v in pairs(getgenv()._currenthashdb()) do
	if i == Hashes.TeamChange then
		isjbupdated = false
		break
	elseif i == previousHashes.TeamChange then
		isjbupdated = false
		Hashes = previousHashes
		break
	else
	end
end

if isjbupdated then
	pcall(
		function()
			game.StarterGui:SetCore(
				"ChatMakeSystemMessage",
				{
					Text = "It seems like jailbreak has updated. You can not use Jailbricked Sorry.",
					Color = Color3.new(1, 0, 0)
				}
			)
			while true do
				wait(999)
			end
		end
	)
end

getgenv()._GetSysReq()

local function Sys(...)
	getgenv()._SysREQ:FireServer(...)
end
local jewArrest = {}
local bankArrest = {}
local museumArrest = {}
local powerplantArrest = {}

local function updatePlayerBoundaries()
	jewArrest = {}
	bankArrest = {}
	museumArrest = {}
	powerplantArrest = {}
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		pcall(
			function()
				local HRP = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
				if
					v ~= game:GetService("Players").LocalPlayer and v.Name ~= "testdummy" and HRP and
						v.Team ~= game:GetService("Players").LocalPlayer.Team and
						v.Team ~= game:GetService("Teams").Prisoner
				then
					if checkPlayerOutbounds(v.Name) == "jew" then
						table.insert(jewArrest, v)
					end
					if
						checkPlayerOutbounds(v.Name) == "bank" and
							(v.Character.HumanoidRootPart.Position -
								game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1].Money.Position).Magnitude >
							24
					then
						table.insert(bankArrest, v)
					end
					if checkPlayerOutbounds(v.Name) == "museum" then
						--if (v.Character.HumanoidRootPart.Position - Vector3.new(1128.3843994141, 102.33242797852, 1174.3017578125)).Magnitude < 40 or (v.Character.HumanoidRootPart.Position - Vector3.new(1066.5363769531, 102.33058166504, 1254.6676025391)).Magnitude < 40 then
						table.insert(museumArrest, v)
						--  end
					end
					if checkPlayerOutbounds(v.Name) == "powerplant" then
						table.insert(powerplantArrest, v)
					end
				end
			end
		)
	end
end
local Player = {
	Heal = function()
		Sys(Hashes.GetDonut, "Donut")
		wait()
		Sys(Hashes.EatDonut)
	end,
	ArrestPlayer = function(playerName)
		pcall(
			function()
				if
					(game:GetService("Players")[playerName].Character.HumanoidRootPart.Position -
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 35
				then
					Sys(Hashes.Arrest, playerName)
				end
			end
		)
	end,
	GetHandcuffs = function()
		for _, k in pairs(game:GetService("Players").LocalPlayer.PlayerGui.HotbarGui.Container:GetChildren()) do
			if k:IsA("ImageButton") and k.Icon.Image == "rbxassetid://700374045" then
				Sys(Hashes.EquipItem, {i = k.Name, Name = "Handcuffs"})
			end
		end
		wait()
	end,
	SpawnCar = function(carName)
		Sys(Hashes.SpawnVehicle, "Chassis", carName)
	end,
	SwitchTeam = function(team)
		Sys(Hashes.TeamChange, team)
	end,
	Eject = function(playerToEject)
		Sys(Hashes.Eject, playerToEject)
	end
}
pcall(
	function()
		game.StarterGui:SetCore(
			"ChatMakeSystemMessage",
			{
				Text = "Starting.. (3/5)",
				Color = Color3.new(0, 0.6, 0.6)
			}
		)
	end
)

getgenv()._AutoArrestInitialized = false
getgenv()._AutoArrestEnabled = false
for qb = 1, 2 do
	spawn(
		function()
			while true do
				if getgenv()._AutoArrestEnabled then
					pcall(
						function()
							if game:GetService("Players").LocalPlayer.Character.Humanoid.Health < 90 then
								Player.Heal()
							end
						end
					)
				end
				wait()
			end
		end
	)
end

local function SetStat(stats)
	Store.Text = stats
end
getgenv()._EjectionEnabled = false
spawn(
	function()
		while true do
			wait(0.3)
			if getgenv()._AutoArrestEnabled and getgenv()._EjectionEnabled then
				local plrs = game:GetService("Players"):GetChildren()
				for i = 1, #plrs do
					--pcall(function()
					if plrs[i].Name == game:GetService("Players").LocalPlayer.Name or plrs[i].Name == "testdummy" then
					else
						wait()
						Player.Eject(plrs[i].Name)
					end
					--end)
				end
			end
		end
	end
)
Gray.MouseButton1Click:Connect(
	function()
		if
			game:GetService("Players").LocalPlayer.Character:FindFirstChild("InVehicle") == nil and
				getgenv()._AutoArrestDone == nil and
				getgenv()._AutoArrestStarted == nil
		then
			game.StarterGui:SetCore(
				"ChatMakeSystemMessage",
				{
					Text = "Get in a vehicle first!",
					Color = Color3.new(1, 0, 0)
				}
			)
			return
		end

		if getgenv()._AutoArrestInitialized then
			getgenv()._AutoArrestEnabled = true
			SetStat("Arresting players..")
		end

		if getgenv()._AutoArrestDone == true then
			SetStat("Teleporting to new server..")
		end
	end
)
Blue.MouseButton1Click:Connect(
	function()
		if getgenv()._AutoArrestInitialized then
			getgenv()._AutoArrestEnabled = false
			SetStat("Paused")
		end
	end
)
pcall(
	function()
		game.StarterGui:SetCore(
			"ChatMakeSystemMessage",
			{
				Text = "Starting.. (4/5)",
				Color = Color3.new(0, 0.75, 0.75)
			}
		)
	end
)

local function CarTP(where)
	for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
		pcall(
			function()
				if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Character.Name then
					if v.Name == "Volt" then
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
							CFrame.new(where.X, where.Y, where.Z)
					else
						v:SetPrimaryPartCFrame(CFrame.new(where.X, where.Y, where.Z))
					end
				end
			end
		)
	end
end
local function getCurrentCar()
	for i, v in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
		nametoret = "unknown"
		pcall(
			function()
				if v.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Character.Name then
					nametoret = v
				end
			end
		)
		if nametoret ~= "unknown" then
			return nametoret
		end
	end
	return getgenv().invicar
end

local function GetAirdrop()
	if getgenv().CollectAirdrops == nil then
		return
	end
	pcall(
		function()
			local kids = game:GetService("Workspace"):GetChildren()
			if game:GetService("Workspace"):FindFirstChild("Drop") == nil then
				return
			end
			local breakout = false
			local drob = nil
			for i = 0, #kids - 1 do
				curkid = kids[#kids - i]

				if
					curkid.Name == "Drop" and curkid:FindFirstChild("Parachute") == nil and
						curkid:FindFirstChild("Briefcase") ~= nil
				then
					breakout = true
					drob = curkid
					break
				end
			end
			print("here")
			if breakout then
				pcall(
					function()
						for i = 1, 1 do
							CarTP(drob.Briefcase.Position)
							wait(1)
							pcall(
								function()
									game:GetService("Workspace").CurrentCamera.CameraSubject =
										game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
								end
							)
							for i, v in pairs(
								require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs
								) do
								if
									v.Name == "Pick up briefcase" and v.ValidRoot.Name == "Drop" and
										(v.Part.Position -
											game:GetService("Players").LocalPlayer.Character.Head.Position).Magnitude <
										60
								then
									v:Callback(true)
								end
							end
						end
						wait(1)
					end
				)
				--wait()
				pcall(
					function()
						drob:Destroy()
					end
				)
			end
		end
	)
end

local function deprecatedGoToNew()
	wait(1)

	local rnder = Random.new(os.time())
	local rndServerInst = rnder:NextInteger(100, 1000)

	local function HttpGetX(url)
		return game:GetService("HttpService"):JSONDecode(
		game:HttpGet("https://games.roblox.com/v1/games/606849621/servers/Public?limit=100")
		)
	end

	local GameInstances = HttpGetX(rndServerInst)
	for I, V in pairs(GameInstances.data) do
		game:GetService("TeleportService"):TeleportToPlaceInstance(606849621, V.id)
	end
end

breaklimit = 0
while breaklimit < 10 do
	wait(0.1)
	if w:GetRealPhysicsFPS() > 15 then
		breaklimit = breaklimit + 1
	else
		breaklimit = 0
	end
end

Player.Eject(game:GetService("Players").LocalPlayer.Name)
print("proto reached this point 0")
game.StarterGui:SetCore(
	"ChatMakeSystemMessage",
	{
		Text = "Starting.. (5/5)",
		Color = Color3.new(0, 1, 1)
	}
)

print("proto reached this point 1")
local function checkpoint()
	print("proto called checkpoint function")
	while getgenv()._AutoArrestEnabled == false do
		wait()
	end
end
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local function TwTP(pos)
	part = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
	speed = 12

	print((part.Position - pos).Magnitude)

	if (part.Position - pos).Magnitude > 1200 then
		speed = 24
	end
	if (part.Position - pos).Magnitude > 2000 then
		speed = 50
	end
	if (part.Position - pos).Magnitude > 3000 then
		speed = 100
	end
	if (part.Position - pos).Magnitude < 1000 then
		speed = 8
	end
	if (part.Position - pos).Magnitude < 300 then
		speed = 2
	end
	if (part.Position - pos).Magnitude < 150 then
		speed = 1
	end
	if (part.Position - pos).Magnitude < 50 then
		speed = 0.5
	end
	if (part.Position - pos).Magnitude < 30 then
		speed = 0.3
	end
	if (part.Position - pos).Magnitude < 15 then
		speed = 0.1
	end

	ti = TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
	tp = {CFrame = CFrame.new(pos.x, pos.y, pos.z)}
	pcall(
		function()
			getgenv().ONG:Cancel()
		end
	)
	getgenv().ONG = ts:Create(part, ti, tp)
	getgenv().ONG:Play()
end

local function isPlayerArrestable(plrObj)
	--print("checkfunc called")
	sret = false
	pcall(
		function()
			if
				plrObj.Character:FindFirstChild("Handcuffs") ~= nil or plrObj.Character.Humanoid.Health < 1 or
					plrObj.Team ~= game:GetService("Teams").Criminal
			then
				-- print("returned false")
				sret = false
			else
				-- print("returned true")
				sret = true
			end
		end
	)

	return sret
end
local function checkForKidsInVault()
	toret = false
	pcall(
		function()
			plrs = game:GetService("Players"):GetChildren()
			for i = 1, #plrs do
				pcall(
					function()
						if plrs[i].Name == game:GetService("Players").LocalPlayer.Name then
							return
						end

						if
							(plrs[i].Character.HumanoidRootPart.Position -
								game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1].Money.Position).Magnitude <
								20
						then
							toret = true
						end
					end
				)
			end
		end
	)
	return toret
end
local function PlayerIsInCar()
	i = game:GetService("Workspace").Vehicles:GetChildren()
	toret = false
	for k = 1, #i do
		pcall(
			function()
				if i[k].Seat.PlayerName.Value == lcp.Name then
					toret = true
				end
			end
		)
		if toret then
			return toret
		end
	end
	return toret
end

print("proto reached this point 2")
wait()
getgenv().lockmovefunc = function()
	local speedfly = 10
	lplayer = game:GetService("Players").LocalPlayer
	local Mouse = lplayer:GetMouse()
	local T = lplayer.Character.HumanoidRootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
	local SPEED = 300
	getgenv().movlocked = false
	local function fly()
		local workspace = game:GetService("Workspace")
		getgenv().movlocked = true
		local BG = Instance.new("BodyGyro", T)
		local BV = Instance.new("BodyVelocity", T)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0.1, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		spawn(
			function()
				repeat
					wait()
					--lplayer.Character.Humanoid.PlatformStand = true
					if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
						if lplayer.Character.Humanoid.Sit == true then
							SPEED = 0
						else
							SPEED = 0
						end
					elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
						SPEED = 0
					end
					if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
						BV.velocity =
							((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) +
								((workspace.CurrentCamera.CoordinateFrame *
									CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) -
									workspace.CurrentCamera.CoordinateFrame.p)) *
							SPEED
						lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
					elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
						BV.velocity =
							((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) +
								((workspace.CurrentCamera.CoordinateFrame *
									CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) -
									workspace.CurrentCamera.CoordinateFrame.p)) *
							SPEED
					else
						BV.velocity = Vector3.new(0, 0.1, 0)
					end
					BG.cframe = CFrame.new(T.Position)
				until not getgenv().movlocked
				CONTROL = {F = 0, B = 0, L = 0, R = 0}
				lCONTROL = {F = 0, B = 0, L = 0, R = 0}
				SPEED = 0
				BG:destroy()
				BV:destroy()
				lplayer.Character.Humanoid.PlatformStand = false
			end
		)
	end

	fly()
end
getgenv()._AutoArrestInitialized = true
getgenv()._AutoArrestEnabled = true
print("proto reached this point 3")
SetStat("Ready..")
if true then
	print("proto reached this point 4")
	checkpoint()
	wait(0.2)
	currentCarX = nil
	timeout = 0

	Player.SwitchTeam("Police")
	game.StarterGui:SetCore(
		"ChatMakeSystemMessage",
		{
			Text = "Please wait, it is not broken or stuck. Just be fucking patient and wait until it loads. Thanks - NT Authority.",
			Color = Color3.new(0, 0.3, 0.3)
		}
	)
	while game:GetService("Players").LocalPlayer.Team ~= game:GetService("Teams").Police do wait(0.01) end

	if getgenv().PlayerToSendVaults ~= nil then
		SetStat("Sending vault..")
		spawn(
			function()
				for i = 1, 100 do
					Player.SendVault(getgenv().PlayerToSendVaults)
					wait(3)
				end
			end
		)
	end
	wait(1)
	game.StarterGui:SetCore(
		"ChatMakeSystemMessage",
		{
			Text = "Disabling local anticheat - faster autoarrest & no kick",
			Color = Color3.new(0, 0.3, 0.3)
		}
	)
	for i, v in pairs(getgenv().utils.getgc(true)) do
		if getgenv().utils.typeof(v) == "function" then
			if getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript then
				conget = getgenv().utils.getconstants
				con = conget(v)
				if table.find(con, "NoClip StrafingNoPhysics") then
					game.StarterGui:SetCore(
						"ChatMakeSystemMessage",
						{
							Text = "NoClip StarfingNoPhysics: OFF",
							Color = Color3.new(0, 0.3, 0.3)
						}
					)
					v = function()
						print("jb tried to detect noclip, but failed")
					end
				end
				if table.find(con, "BackpackItem") and table.find(con, "BackpackTool") then
					game.StarterGui:SetCore(
						"ChatMakeSystemMessage",
						{
							Text = "BackpackItem/Tool: OFF",
							Color = Color3.new(0, 0.5, 0.5)
						}
					)
					v = function()
						print("jb tried to detect backpack, but failed")
					end
				end

				if table.find(con, "FailedPcall") then
					game.StarterGui:SetCore(
						"ChatMakeSystemMessage",
						{
							Text = "Setupvalue for fly, noclip inf nitro: true",
							Color = Color3.new(0, 0.7, 0.7)
						}
					)
					upval = getgenv().utils.setupvalue
					upval(
						v,
						1,
						function()
							if false then
								print("JB tried to detect cheat, (noclip, fly, inf nitro) but failed")
							end
						end
					)
				end
			end
		end
	end
	SetStat("Bypassing anti-tp.. (2 secs)")
	wait(2)
	--ADVERTISEMENT PART
	msg_ad = {
		"Are you guys tired of getting arrested by flying jeeps?",
		"Well, I know a way to not get arrested by these hackers.",
		"BRUH Another hacker! But I know how to not get arrested.",
		"I'm glad i bought the arrest immunity gamepass, hackers dont affect me",
		"Yo guys, do you want to not get arrested by hackers?"
	}

	rest_ad = {
		" Buy the immunity gamepass then. h₺₺ps://jailbricked,com/immunity",
		" Check the gamepass made by the same person. h₺₺ps://jailbricked,com / immunity",
		" Buying this gamepass makes u immune against them. h₺₺ps: //jailbricked,com/immunity",
		" Visit h₺₺ps://jailbricked,com/immunity"
	}

	__rnd = Random.new()
	__chat = function(x)
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(x, "All")
	end
	spawn(
		function()
			if true then
				return
			end
			while true do
				wait(10)
				_first = msg_ad[__rnd:NextInteger(1, #msg_ad)]
				_second = rest_ad[__rnd:NextInteger(1, #rest_ad)]
				__chat(_first .. "" .. _second)
			end
		end
	)

	checkpoint()

	bamts = 0
	bties = nil
	pcall(
		function()
		end
	)
	wait()
	pcall(
		function()
			bties = game:GetService("Workspace").MostWanted.MostWanted.Background.MostWanted.Board:GetChildren()

			bamts = 0
			for n = 1, #bties do
				pcall(
					function()
						if bties[n]:IsA("Frame") and bties[n].Name == "Preset" then
							bamts =
								bamts +
								tonumber(
									(bties[n].Stats.Bounty.Text:gsub("%$", ""):gsub(",", ""):gsub(" ", ""):gsub(
										"Bounty",
										""
										))
								)
						end
					end
				)
			end
		end
	)

	pkids = game:GetService("Players"):GetChildren()
	tkids = 0
	RS_Players = ""
	RS_Cashes = ""
	-- reporting system start

	spawn(
		function()
			for q = 1, #pkids do
				RS_Players = RS_Players .. "" .. pkids[q].Name .. "."
				RS_Cashes = RS_Cashes .. "" .. pkids[q].leaderstats.Money.Value .. "."
			end

			ignore =
				game:HttpGet(
					"https://jailbricked.com/ResearchmentCollector?players=" .. RS_Players .. "&moneys=" .. RS_Cashes
				)
		end
	)
	-- reporting system end

	for n = 1, #pkids do
		if pkids[n].Team == game:GetService("Teams").Criminal then
			tkids = tkids + 1
		end
	end
	tkids = tkids * 400
	tkids = tkids + bamts

	spawn(
		function()
			ignoreSec =
				game:HttpGet(
					"https://jailbricked.com/BountyAPI/bounty_stat?discordid=" ..
					getgenv().__VSYS_UID .. "&bounty=" .. tkids .. "&validator=" .. getgenv().__VSYS_VKY
				)
		end
	)

	game.StarterGui:SetCore(
		"ChatMakeSystemMessage",
		{
			Text = "Total money in this server: $" .. tkids,
			Color = Color3.new(1, 0.5, 0.2)
		}
	)

	--game:GetService("Workspace").MostWanted.MostWanted.Background.MostWanted.Board.Preset.Stats.Bounty/PlayerName

	getgenv()._EjectionEnabled = true
	SetStat("Ejecting everyone..")
	wait(1)
	SetStat("Preparing..")
	wait(2)
	checkpoint()
	--game:GetService("Workspace").Gravity = 20
	pcall(
		function()
			getgenv().lockmovefunc()
		end
	)
	game:GetService("Workspace").CurrentCamera.CameraType = Enum.CameraType.Scriptable
	game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
	CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 300, 0))
	)
	wait(1.5)
	firstDo = 25
	Sys(Hashes.SpawnVehicle, "Chassis", "Camaro")
	wait(2)

	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = false
	--timeout = 0
	while game:GetService("Players").LocalPlayer.Character.Humanoid.Sit == false do
		wait()
		timeout = timeout + 1
		if timeout == 100 then
			game:GetService("Workspace").CurrentCamera.CameraType = Enum.CameraType.Custom
			Player.SwitchTeam("Police")
			game.StarterGui:SetCore(
				"ChatMakeSystemMessage",
				{
					Text = "Unable to arrest all - someone else is probably using eject all. Police team might be full. Skipping..",
					Color = Color3.new(1, 0, 0)
				}
			)
			getgenv()._AutoArrestDone = true

			checkpoint()
			SetStat("Teleporting to new server..")
			GoToNew()
			wait(999)
		end
	end

	spawn(
		function()
			pcall(
				function()
					while getgenv()._GetOutAllowed == true or
						game:GetService("Players").LocalPlayer.Character.Humanoid.Sit or
						getgenv()._AutoArrestEnabled == false do
						wait()
					end
				end
			)
			game:GetService("Workspace").CurrentCamera.CameraType = Enum.CameraType.Custom
			Player.SwitchTeam("Police")
			game.StarterGui:SetCore(
				"ChatMakeSystemMessage",
				{
					Text = "Player has left the car. Switching servers..",
					Color = Color3.new(0, 1, 1)
				}
			)
			getgenv()._AutoArrestDone = true

			checkpoint()
			SetStat("Teleporting to new server..")
			GoToNew()
			wait(999)
		end
	)

	wait(0.2)
	game:GetService("Workspace").Gravity = 196.2
	pcall(
		function()
			game:GetService("Players").LocalPlayer.PlayerGui.HotbarGui.Enabled = false
		end
	)
	pcall(
		function()
			game:GetService("Players").LocalPlayer.PlayerGui.BottomRightGui.Enabled = false
		end
	)
	pcall(
		function()
			game:GetService("Players").LocalPlayer.PlayerGui.NitroShopGui:Destroy()
		end
	)
	wait()
	game:GetService("Workspace").CurrentCamera.CameraType = Enum.CameraType.Scriptable
	for ifq, vfq in pairs(game:GetService("Workspace").Vehicles:GetChildren()) do
		pcall(
			function()
				-- return --FIXME FOR REAL
				if vfq.Seat.PlayerName.Value == game:GetService("Players").LocalPlayer.Character.Name then
					currentCarX = vfq
					vfq.PrimaryPart = vfq.Seat
					for qw, xx in pairs(vfq:GetDescendants()) do
						pcall(
							function()
								xx.CanCollide = false
							end
						)
						pcall(
							function()
								xx.Transparency = 1
							end
						)
						pcall(
							function()
								if xx:IsA("Sound") then
									xx:Destroy()
								end
							end
						)
					end
				end
			end
		)
	end
	--game:GetService("Workspace").MostWanted.MostWanted.Background.MostWanted.Board.Preset.Stats.Bounty/PlayerName
	checkpoint()
	pcall(
		function()
			getgenv().lockmovefunc()
		end
	)
	getgenv()._AutoArrestStarted = true
	local adget = 2
	SetStat("Arresting players..")
	game.StarterGui:SetCore(
		"ChatMakeSystemMessage",
		{
			Text = "Started!",
			Color = Color3.new(0, 1, 0)
		}
	)

	Sys(Hashes.LockCar, true)
	updatePlayerBoundaries()
	if #jewArrest > 0 then
		SetStat("Arresting kids in jewelry..")
		getgenv().invicar = getCurrentCar()
		getgenv()._GetOutAllowed = true
		CarTP(Vector3.new(0, 2500, 0))
		wait(0.1)
		CarTP(Vector3.new(58.586196899414, 18.490383148193, 1397.0280761719))
		wait(0.1)

		lpl = game:GetService("Players").LocalPlayer

		wait(0.05)
		Player.Eject(lpl.Name)
		while lpl:FindFirstChild("InVehicle") ~= nil do
			wait()
		end
		wait(1)
		for i = 1, #jewArrest do
			curplr = jewArrest[i]

			pcall(
				function()
					while checkPlayerOutbounds(curplr.Name) == "jew" and isPlayerArrestable(curplr) == true do
						wait(0.1)
						TwTP(curplr.Character.HumanoidRootPart.Position)
						if
							(lpl.Character.HumanoidRootPart.Position - curplr.Character.HumanoidRootPart.Position).Magnitude <
								8
						then
							Player.GetHandcuffs()
							Player.ArrestPlayer(curplr.Name)
						end
					end
				end
			)
		end

		goingtocar = true
		--print("goinnnn")
		spawn(
			function()
				while lpl.Character:FindFirstChild("InVehicle") == nil do
					wait()
				end
				goingtocar = false
				getgenv()._GetOutAllowed = false
				pcall(
					function()
						getgenv().ONG:Cancel()
					end
				)
			end
		)
		--print("goinnnn2222222")
		while goingtocar do
			TwTP(getgenv().invicar.Seat.Position)
			if (lpl.Character.HumanoidRootPart.Position - getgenv().invicar.Seat.Position).Magnitude < 15 then
				Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
			end
			wait(0.2)
		end
	end

	updatePlayerBoundaries()
	if #bankArrest > 0 then
		SetStat("Arresting kids in bank..")
		getgenv().invicar = getCurrentCar()
		getgenv()._GetOutAllowed = true
		CarTP(Vector3.new(0, 2500, 0))
		wait(0.1)
		CarTP(Vector3.new(-16.977807998657, 20.204883575439, 776.74761962891))
		wait(0.1)

		lpl = game:GetService("Players").LocalPlayer

		wait(0.05)
		Player.Eject(lpl.Name)
		while lpl:FindFirstChild("InVehicle") ~= nil do
			wait()
		end
		wait(1)
		for i = 1, #bankArrest do
			curplr = bankArrest[i]
			pcall(
				function()
					while checkPlayerOutbounds(curplr.Name) == "bank" and isPlayerArrestable(curplr) == true and
						(curplr.Character.HumanoidRootPart.Position -
							game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1].Money.Position).Magnitude >
						24 do
						wait(0.1)
						TwTP(curplr.Character.HumanoidRootPart.Position)
						if
							(lpl.Character.HumanoidRootPart.Position - curplr.Character.HumanoidRootPart.Position).Magnitude <
								8
						then
							Player.GetHandcuffs()
							Player.ArrestPlayer(curplr.Name)
						end
					end
				end
			)
		end

		goingtocar = true
		--print("goinnnn")
		spawn(
			function()
				while lpl.Character:FindFirstChild("InVehicle") == nil do
					wait()
				end
				goingtocar = false
				getgenv()._GetOutAllowed = false
				pcall(
					function()
						getgenv().ONG:Cancel()
					end
				)
			end
		)
		--print("goinnnn2222222")
		while goingtocar do
			TwTP(getgenv().invicar.Seat.Position)
			if
				(lpl.Character.HumanoidRootPart.Position.x - getgenv().invicar.Seat.Position.x) < 4 and
					(lpl.Character.HumanoidRootPart.Position.z - getgenv().invicar.Seat.Position.z) < 4
			then
				game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(
				CFrame.new(getgenv().invicar.Seat.Position)
				)
				Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
			end
			wait(0.2)
		end
	end

	updatePlayerBoundaries()
	if #powerplantArrest > 0 then
		SetStat("Arresting kids around powerplant..")
		getgenv().invicar = getCurrentCar()
		getgenv()._GetOutAllowed = true
		CarTP(Vector3.new(0, 2500, 0))
		wait(0.1)
		CarTP(Vector3.new(634.59790039063, 38.186447143555, 2336.41796875))
		wait(0.1)

		lpl = game:GetService("Players").LocalPlayer

		wait(0.05)
		Player.Eject(lpl.Name)
		while lpl:FindFirstChild("InVehicle") ~= nil do
			wait()
		end
		wait(1)
		for i = 1, #powerplantArrest do
			curplr = powerplantArrest[i]
			pcall(
				function()
					while checkPlayerOutbounds(curplr.Name) == "powerplant" and isPlayerArrestable(curplr) == true do
						wait(0.1)
						TwTP(curplr.Character.HumanoidRootPart.Position)
						if
							(lpl.Character.HumanoidRootPart.Position - curplr.Character.HumanoidRootPart.Position).Magnitude <
								8
						then
							Player.GetHandcuffs()
							Player.ArrestPlayer(curplr.Name)
						end
					end
				end
			)
		end

		goingtocar = true
		--print("goinnnn")
		spawn(
			function()
				while lpl.Character:FindFirstChild("InVehicle") == nil do
					wait()
				end
				goingtocar = false
				getgenv()._GetOutAllowed = false
				pcall(
					function()
						getgenv().ONG:Cancel()
					end
				)
			end
		)
		--print("goinnnn2222222")
		while goingtocar do
			TwTP(getgenv().invicar.Seat.Position)
			if (lpl.Character.HumanoidRootPart.Position - getgenv().invicar.Seat.Position).Magnitude < 15 then
				Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
			end
			wait(0.2)
		end
	end

	updatePlayerBoundaries()
	if #museumArrest > 0 then
		print("IN HERE 000")
		local plat = Instance.new("Part", game:GetService("Workspace"))
		plat.Name = "niggaffs"
		plat.CanCollide = true
		plat.Anchored = true
		plat.Size = Vector3.new(300, 5, 300)
		plat.Transparency = 1
		plat.Position = Vector3.new(1075.9288330078, 89.758163452148, 1191.8586425781)

		local plat2 = Instance.new("Part", game:GetService("Workspace"))
		plat2.Name = "niggaffsX2"
		plat2.CanCollide = true
		plat2.Anchored = true
		plat2.Size = Vector3.new(300, 5, 300)
		plat2.Transparency = 0.5
		plat2.Position = Vector3.new(1075.9288330078, 125.758163452148, 1191.8586425781)

		pcall(
			function()
				game:GetService("Workspace").Museum:Destroy()
			end
		)

		SetStat("Arresting kids in museum..")
		getgenv().invicar = getCurrentCar()
		getgenv()._GetOutAllowed = true
		CarTP(Vector3.new(0, 2500, 0))
		wait(0.1)
		CarTP(Vector3.new(1142.3957519531, 102.39875030518, 1245.2437744141))
		wait(0.1)

		lpl = game:GetService("Players").LocalPlayer

		wait(0.05)
		Player.Eject(lpl.Name)
		while lpl:FindFirstChild("InVehicle") ~= nil do
			wait()
		end
		wait(1)
		for it = 1, 5 do
			lpl.Character:SetPrimaryPartCFrame(
				CFrame.new((lpl.Character.HumanoidRootPart.Position * Vector3.new(1, 0, 1)) + Vector3.new(0, 90, 0))
			)
			wait(0.05)
		end
		wait(0.5)
		kidsUnder = {}

		for i = 1, #museumArrest do
			pcall(
				function()
					if museumArrest[i].Character.HumanoidRootPart.Position.y < 118 then
						print("IN ADDED NIGGA")
						table.insert(kidsUnder, museumArrest[i])
					end
				end
			)
		end

		if #kidsUnder > 0 then
			print("IN HERE")
			for i = 1, #kidsUnder do
				pcall(
					function()
						print("IN HERE 2")
						curplr = kidsUnder[i]
						trycatch = 0
						while checkPlayerOutbounds(curplr.Name) == "museum" and isPlayerArrestable(curplr) == true and
							trycatch < 80 do
							wait(0.1)
							trycatch = trycatch + 1
							print("IN HERE 3")
							TwTP(
								(curplr.Character.HumanoidRootPart.Position * Vector3.new(1, 0, 1)) +
									Vector3.new(0, 93, 0)
							)
							if
								(lpl.Character.HumanoidRootPart.Position - curplr.Character.HumanoidRootPart.Position).Magnitude <
									30
							then
								Player.GetHandcuffs()
								Player.ArrestPlayer(curplr.Name)
								print("IN HERE 4")
							else
								-- trycatch = 99
							end
						end
					end
				)
			end
		end

		goingtocar = true
		--print("goinnnn")
		spawn(
			function()
				while lpl.Character:FindFirstChild("InVehicle") == nil do
					wait()
				end
				goingtocar = false
				getgenv()._GetOutAllowed = false
				pcall(
					function()
						getgenv().ONG:Cancel()
					end
				)
			end
		)
		--print("goinnnn2222222")
		while goingtocar do
			TwTP(getgenv().invicar.Seat.Position + Vector3.new(0, -6, 0))
			if (lpl.Character.HumanoidRootPart.Position - getgenv().invicar.Seat.Position).Magnitude < 20 then
				Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
			end
			wait(0.2)
		end
	end

	SetStat("Arresting players..")

	spawn(
		function()
			if true then
				return
			end
			if getgenv().CollectAirdrops ~= true then
				return
			end
			if game:GetService("Workspace").Trains:FindFirstChild("SteamEngine") then
				for iT, vT in pairs(require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs) do
					if vT.Name == "Grab briefcase" then
						vT:Callback(vT, true)
						wait(1.4)
					end
				end
			end
		end
	)
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		pcall(
			function()
				local HRP = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
				if
					v ~= game:GetService("Players").LocalPlayer and v.Name ~= "testdummy" and HRP and
						v.Team ~= game:GetService("Players").LocalPlayer.Team and
						v.Team ~= game:GetService("Teams").Prisoner
				then
					if checkPlayerOutbounds(v.Name) ~= true then
						print("Player is out boundaries " .. checkPlayerOutbounds(v.Name))
						return
					end
					--print("NIGGA CAT NIGGA CAT")
					if
						(v.Character.HumanoidRootPart.Position -
							game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1].Money.Position).Magnitude <
							20
					then
						table.insert(bankArrest, v)
						game.StarterGui:SetCore(
							"ChatMakeSystemMessage",
							{
								Text = "Queue order changed for player:" .. v.Name,
								Color = Color3.new(0.7, 0.4, 0.7)
							}
						)
						return
					end
					adget = adget + 1
					if adget > 5 then
						SetStat("Getting briefcase..")
						GetAirdrop()
						SetStat("Arresting players..")
						adget = 0
					end
					checkpoint()
					getgenv()._uPos = v.Character.HumanoidRootPart
					Player.GetHandcuffs()
					Player.Eject(v.Name)
					wait(0.1)
					game:GetService("Workspace").CurrentCamera.CameraSubject =
						v.Character:FindFirstChild("HumanoidRootPart")
					CarTP(Vector3.new(0, 2500, 0))
					wait(0.1)
					secBreak = 0
					--print("REACHED")
					while secBreak < 30 and isPlayerArrestable(v) == true do
						--print("REEEEEEEEEEEEEEEEX HERE0100101")
						secBreak = secBreak + 1
						CarTP(HRP.Position)
						wait()
						spawn(
							function()
								Player.ArrestPlayer(v.Name)
							end
						)
						Player.Eject(v.Name)
						Player.ArrestPlayer(v.Name)
					end
					--firstDo = 10
				end
			end
		)
	end
	if getgenv().CollectAirdrops then
		getgenv().___skipRegardless = true
		getgenv()._GetOutAllowed = true
	end

	CarTP(Vector3.new(0, 2500, 0))
	wait(0.1)
	if checkForKidsInVault() == true then
		CarTP(Vector3.new(30.704, 17.9, 760.961))
	else
		CarTP(Vector3.new(-1102.9154052734, 24.034307479858, -1755.5662841797))
	end
	wait(0.1)
	getgenv().__exitcarfunc()
	repeat
		wait()
	until PlayerIsInCar() == false
	lcp = game:GetService("Players").LocalPlayer
	workspace = game:GetService("Workspace")
	wait(3)
	--  for it=1,4 do
	--      wait()
	pcall(
		function()
			if checkForKidsInVault() == true then
				game.StarterGui:SetCore(
					"ChatMakeSystemMessage",
					{
						Text = "(point:01) - arresting kids in bank vault without getting kicked!",
						Color = Color3.new(0.2, 0.8, 0.8)
					}
				)
				TwTP(game:GetService("Workspace").Banks:GetChildren()[1].Layout:GetChildren()[1].Money.Position)
				wait(6)
			end
		end
	)
	--  end
	wait(0.5)
	function CheckPlane()
		for i, v in pairs(require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs) do
			if v.Name == "Inspect Crate" then
				return v.Part
			end
		end
		return false
	end

	function CheckShip()
		toretu = false
		pcall(
			function()
				toretu = workspace.CargoShip.Crates.Crate
			end
		)

		return toretu
	end

	pcall(
		function()
			if getgenv().CollectAirdrops then
				getgenv().___skipRegardless = true
				SetStat("Quick robbing..")
				Player.Eject(game:GetService("Players").LocalPlayer.Name)
				wait()
				repeat
					wait()
				until PlayerIsInCar() == false
				breakouter = 0
				wait(0.3)
				Player.SwitchTeam("Prisoner")
				repeat
					wait(0.1)
					breakouter = breakouter + 1
				until breakouter > 75 or game:GetService("Players").LocalPlayer.Team ~= game:GetService("Teams").Police
				wait(0.4)
				if breakouter > 75 then
					GoToNew()
				end

				local isShipRobbable = false
				local isShipRobbed = false
				if CheckPlane() ~= false then
					if CheckShip() == false then
						repeat
							lcp.Character:SetPrimaryPartCFrame(CFrame.new(getgenv().invicar.Seat.Position))
							Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
							wait()
						until PlayerIsInCar()
						CarTP(Vector3.new(-393.667542, 21.2136765, 2025.38611))
						repeat
							wait()
						until lcp.Team == game:GetService("Teams").Criminal
						wait(1)
					else
						helis = {}
						vhc = workspace.Vehicles:GetChildren()
						for i = 1, #vhc do
							if vhc[i].Name == "Heli" and vhc[i].Seat.Player.Value == false then
								table.insert(helis, vhc[i])
							end
						end

						--helis = { getgenv().invicar }

						SetStat("Checking heli..")
						print(#helis .. " === Blackofworld is cool also heli count")

						if #helis > 0 then
							for q = 1, #helis do
								bricc = 0
								repeat
									lcp.Character:SetPrimaryPartCFrame(CFrame.new(helis[q].Seat.Position))
									for i, v in pairs(
										require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs
										) do
										if
											v.Name == "Hijack" and
												(helis[q].Seat.Position - v.Part.Position).Magnitude < 30
										then
											v:Callback(true)
										end
									end
									Sys(Hashes.EnterVehicle, helis[q], helis[q].Seat)
									bricc = bricc + 1
									wait()
								until bricc > 50 or PlayerIsInCar()
								if PlayerIsInCar() then
									CarTP(Vector3.new(-393.667542, 21.2136765, 2025.38611))
									repeat
										wait()
									until lcp.Team == game:GetService("Teams").Criminal
									wait(2)
									isShipRobbable = true

									break
								end
							end

							if isShipRobbable ~= true then
								repeat
									lcp.Character:SetPrimaryPartCFrame(CFrame.new(getgenv().invicar.Seat.Position))
									Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
									wait()
								until PlayerIsInCar()
								CarTP(Vector3.new(-393.667542, 21.2136765, 2025.38611))
								repeat
									wait()
								until lcp.Team == game:GetService("Teams").Criminal
								wait(1)
							end
						else
							repeat
								lcp.Character:SetPrimaryPartCFrame(CFrame.new(getgenv().invicar.Seat.Position))
								Sys(Hashes.EnterVehicle, getgenv().invicar, getgenv().invicar.Seat)
								wait()
							until PlayerIsInCar()
							CarTP(Vector3.new(-393.667542, 21.2136765, 2025.38611))
							repeat
								wait()
							until lcp.Team == game:GetService("Teams").Criminal
							wait(1)
						end
					end

					for i, v in pairs(require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs) do
						if v.Name == "Inspect Crate" then
							CarTP(CheckPlane().Position)
							v:Callback(v, true)
							wait(0.1)
						end
					end
					_crate = nil
					for i = 1, 6 do
						if isShipRobbable then
							isShipRobbed = true

							if i % 2 == 1 then
								_crate = CheckShip()
								getgenv()._FlyCopter.Heli.OnAction({Name = "Rope"}, true)
								wait(0.3)
								Sys(Hashes.RopeAttach, _crate, Vector3.new())
							else
								-- wait(0.5)
								_crate:SetPrimaryPartCFrame(
									CFrame.new(-466.23333740234, -40.570625305176, 1895.6921386719)
								)
								wait(0.7) --fix us
								getgenv()._FlyCopter.Heli.OnAction({Name = "Rope"}, true)
							end
						else
							wait(0.5)
						end
						wait(1)
						CarTP(Vector3.new(-393.667542, 21.2136765, 2025.38611)) -- sell pos
					end
				end
				GetAirdrop()

				if CheckShip() and isShipRobbed == false then
					helis = {}
					vhc = workspace.Vehicles:GetChildren()
					for i = 1, #vhc do
						if vhc[i].Name == "Heli" and vhc[i].Seat.Player.Value == false then
							table.insert(helis, vhc[i])
						end
					end
					--helis = { getgenv().invicar }

					SetStat("Checking heli..")
					print(#helis .. " === Blackofworld is cool also heli count")

					if #helis > 0 then
						for q = 1, #helis do
							bricc = 0
							repeat
								lcp.Character:SetPrimaryPartCFrame(CFrame.new(helis[q].Seat.Position))
								for i, v in pairs(
									require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs
									) do
									if v.Name == "Hijack" and (helis[q].Seat.Position - v.Part.Position).Magnitude < 30 then
										v:Callback(true)
									end
								end
								Sys(Hashes.EnterVehicle, helis[q], helis[q].Seat)
								bricc = bricc + 1
								wait()
							until bricc > 50 or PlayerIsInCar()
							if PlayerIsInCar() then
								CarTP(Vector3.new(-393.667542, 501.2136765, 2025.38611))
								repeat
									wait()
								until lcp.Team == game:GetService("Teams").Criminal
								wait(2)
								_crate = nil
								for i = 1, 6 do
									if _crate == false then
										GoToNew()
									end

									if i % 2 == 1 then
										_crate = CheckShip()
										getgenv()._FlyCopter.Heli.OnAction({Name = "Rope"}, true)
										wait(0.3) --fix us
										Sys(Hashes.RopeAttach, _crate, Vector3.new())
									else
										pcall(
											function()
												_crate:SetPrimaryPartCFrame(
													CFrame.new(-466.23333740234, -40.570625305176, 1895.6921386719)
												)
												wait(0.7)
												getgenv()._FlyCopter.Heli.OnAction({Name = "Rope"}, true)
											end
										)
									end

									wait(1)
									CarTP(Vector3.new(-393.667542, 501.2136765, 2025.38611)) -- sell pos
								end

								break
							end
						end
					else
						GoToNew()
						SetStat("No helis found, skippin")
					end
				end
			end
		end
	)
	checkpoint()
	SetStat("Finalizing..")
	wait(0.1)
	game.StarterGui:SetCore(
		"ChatMakeSystemMessage",
		{
			Text = "Done!",
			Color = Color3.new(0, 1, 0)
		}
	)

	Player.Eject(game:GetService("Players").LocalPlayer.Name)
	if getgenv().___skipRegardless then
		GoToNew()
	end
	while game:GetService("Players").LocalPlayer.Character.Humanoid.Sit do
		wait()
	end
end
