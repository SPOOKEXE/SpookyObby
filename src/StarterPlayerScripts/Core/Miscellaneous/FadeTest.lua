local TweenService = game:GetService('TweenService')
local ReplicatedFirst = game:GetService('ReplicatedFirst')

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local Interface = LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('Interface')

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedAssets = ReplicatedStorage:WaitForChild('Assets')

local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))
local ReplicatedData = ReplicatedModules.Services.ReplicatedData

local SystemsContainer = {}

-- // Module // --
local Module = {}

-- fade the black in
function Module.FadeInBlack( duration : number? )
	TweenService:Create(Interface.Fade, TweenInfo.new(duration or 1), {BackgroundTransparency = 0}):Play()
end

-- fade the black out
function Module.FadeOutBlack( duration : number? )
	TweenService:Create(Interface.Fade, TweenInfo.new(duration or 1), {BackgroundTransparency = 1}):Play()
end

function Module.Start()

	task.spawn(function()
		Interface.Fade.BackgroundTransparency = 0
		ReplicatedFirst:RemoveDefaultLoadingScreen()
		task.wait(3)
		ReplicatedData.GetData("PlayerData", true)
		Module.FadeOutBlack()
	end)

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module