local HttpService = game:GetService('HttpService')
local TweenService = game:GetService('TweenService')
local Lighting = game:GetService('Lighting')

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedAssets = ReplicatedStorage:WaitForChild('Assets')

local SoftShutdownUI = ReplicatedAssets:FindFirstChild('SoftShutdown')
assert(SoftShutdownUI, 'SoftShutdown UI could not be found.')
local MaintenanceUI = ReplicatedAssets:FindFirstChild('Maintenance')
assert(MaintenanceUI, 'Maintenance UI could not be found.')

local SystemsContainer = {}

local HasShutdown = false
local HasTimerStarted = false
local LastWidgetPrompt = false

local ReminderTimeValues = { 300, 600, 1800, 3600 } -- countdown 3m, 10m, 30m, 1hr

local function GetHrsMinSec(seconds)
	local hrs = math.floor(seconds / 360)
	seconds -= (hrs * 360)
	local minutes = math.floor(seconds / 60)
	seconds -= (minutes * 60)
	return hrs, minutes, math.floor(seconds)
end

local function FormatTimerSplice(seconds)
	local hrs, min, sec = GetHrsMinSec(seconds)
	local hrtxt = hrs>0 and hrs..'hr' or '0h'
	local mtxt = min>0 and min..'m' or '0m'
	local stxt = sec>0 and sec..'s' or '0s'
	return hrs>0 and hrtxt..' '..mtxt or mtxt..' '..stxt
end

-- // Module // --
local Module = {}

function Module.OnSoftShutdown()
	local PlayerGui = LocalPlayer:WaitForChild('PlayerGui')
	for _, UIInstance in ipairs( PlayerGui:GetChildren() ) do
		UIInstance.Enabled = false
	end

	local Item = SoftShutdownUI:Clone()
	Item.Parent = PlayerGui

	local ResultSize = Item.ShutdownBlur.Size
	Item.ShutdownBlur.Size = 0
	Item.ShutdownBlur.Enabled = true
	TweenService:Create(Item.ShutdownBlur, TweenInfo.new(1), {Size = ResultSize}):Play()
	Item.ShutdownBlur.Parent = Lighting

	Item.Notification:Play()
	task.delay(0.5, function()
		Item.Piano:Play()
	end)

	Item.Enabled = true
end

function Module.CheckSoftShutdownState()
	if HasShutdown or not workspace:GetAttribute('SoftShutdownEnabled') then
		return
	end
	HasShutdown = true
	print('SoftShutdown has occured.')

	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

	local Sound = SystemsContainer.ParentSystems.Gameplay.MusicClient.MusicSoundInstance
	local Tween = TweenService:Create( Sound, TweenInfo.new(1.5), {Volume = 0} )
	Tween.Completed:Connect(function()
		Sound:Destroy()
	end)
	Tween:Play()

	Module.OnSoftShutdown()
end

local ActiveMaintenanceUI = false
local UUID = HttpService:GenerateGUID(false)

function Module.ForceMaintenancePrompt(message)
	print('perm')
	if not ActiveMaintenanceUI then
		ActiveMaintenanceUI = MaintenanceUI:Clone()
		ActiveMaintenanceUI.Enabled = true
		ActiveMaintenanceUI.Notification:Play()
		ActiveMaintenanceUI.Parent = LocalPlayer.PlayerGui
	end
	ActiveMaintenanceUI.Frame.Description.Text = message
	UUID = HttpService:GenerateGUID(false)
end

function Module.TemporaryMaintenancePrompt(message)
	if not ActiveMaintenanceUI then
		ActiveMaintenanceUI = MaintenanceUI:Clone()
		ActiveMaintenanceUI.Enabled = true
		ActiveMaintenanceUI.Parent = LocalPlayer.PlayerGui
	end
	ActiveMaintenanceUI.Notification:Play()
	ActiveMaintenanceUI.Frame.Description.Text = message
	local ID = HttpService:GenerateGUID(false)
	UUID = ID
	task.delay(5, function()
		if UUID ~= ID then
			return
		end
		ActiveMaintenanceUI:Destroy()
		ActiveMaintenanceUI = nil
	end)
end

function Module.UpdateSoftShutdownTimer()
	local timeUntil = workspace:GetAttribute('TimedShutdownTime') - tick()
	local message = 'A soft shutdown will occur in '..FormatTimerSplice(timeUntil)

	if timeUntil < ReminderTimeValues[1] then
		Module.ForceMaintenancePrompt(message)
		return
	end

	for _, value in ipairs( ReminderTimeValues ) do
		print( timeUntil, value, LastWidgetPrompt )
		if timeUntil < value then
			if value ~= LastWidgetPrompt then
				LastWidgetPrompt = value
				Module.TemporaryMaintenancePrompt(message)
			end
			break
		end
	end
end

function Module.CheckTimedSoftShutdownState()
	if not workspace:GetAttribute('TimedShutdownTime') or HasTimerStarted then
		return
	end
	HasTimerStarted = true

	task.spawn(function()
		while HasTimerStarted and workspace:GetAttribute('TimedShutdownTime') do
			task.wait(1)
			Module.UpdateSoftShutdownTimer()
		end
	end)
end

function Module.Start()
	task.defer(function()
		Module.CheckSoftShutdownState()
		Module.CheckTimedSoftShutdownState()
	end)

	workspace:GetAttributeChangedSignal('TimedShutdownTime'):Connect(Module.CheckTimedSoftShutdownState)
	workspace:GetAttributeChangedSignal('SoftShutdownEnabled'):Connect(Module.CheckSoftShutdownState)
end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
