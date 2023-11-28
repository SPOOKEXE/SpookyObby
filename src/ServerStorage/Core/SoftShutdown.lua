local TeleportService = game:GetService('TeleportService')
local Players = game:GetService('Players')

local ServerStorage = game:GetService("ServerStorage")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))

local ReplicatedData = ReplicatedModules.Services.ReplicatedData

local reservedCode = false

local SystemsContainer = {}

local function SoftShutdownTeleport(LocalPlayer)
	TeleportService:TeleportToPrivateServer(
		game.PlaceId,
		reservedCode,
		{LocalPlayer}
	)
end

local ACTIVE_SHUTDOWN_TIME = false

-- // Module // --
local Module = {}

function Module.IsTemporaryServer()
	return game.PrivateServerId ~= "" and game.PrivateServerOwnerId == 0
end

function Module.IsSoftShutdownEnabled()
	return workspace:GetAttribute('SoftShutdownEnabled')
end

function Module.OnSoftShutdown()
	if Module.IsSoftShutdownEnabled() then
		return
	end
	workspace:SetAttribute('SoftShutdownEnabled', true)

	-- stop data replication
	task.defer(function()
		ReplicatedData:RemoveAll( "PlayerData" )
	end)

	print('Teleport players out of server.')
	reservedCode = TeleportService:ReserveServer(game.PlaceId)
	for _, LocalPlayer in ipairs( Players:GetPlayers() ) do
		task.spawn(SoftShutdownTeleport, LocalPlayer)
	end
	Players.PlayerAdded:Connect(SoftShutdownTeleport)
end

function Module.IsTimerOutForSoftShutdown()
	return ACTIVE_SHUTDOWN_TIME and tick() > ACTIVE_SHUTDOWN_TIME
end

function Module.StartTimedSoftShutdown( timeUntil )
	local shutdownTime = tick() + timeUntil
	if (not ACTIVE_SHUTDOWN_TIME) or (shutdownTime < ACTIVE_SHUTDOWN_TIME) then
		ACTIVE_SHUTDOWN_TIME = shutdownTime
	end
	workspace:SetAttribute('TimedShutdownTime', shutdownTime)
end

function Module.SetupTestEvents()
	local a = Instance.new('RemoteEvent')
	a.Name = 'ForceSoftShutdown'
	a.OnServerEvent:Connect(function()
		Module.OnSoftShutdown()
	end)
	a.Parent = ReplicatedStorage

	local b = Instance.new('RemoteEvent')
	b.Name = 'TimedSoftShutdown'
	b.OnServerEvent:Connect(function(timer)
		assert(typeof(timer) == "number", "Passed value must be a number.")
		Module.StartTimedSoftShutdown(timer)
	end)
	b.Parent = ReplicatedStorage

	local d = Instance.new('BindableEvent')
	d.Name = 'ForceSoftShutdownEvent'
	d.Event:Connect(function()
		Module.OnSoftShutdown()
	end)
	d.Parent = ServerStorage

	local c = Instance.new('BindableEvent')
	c.Name = 'TimedSoftShutdownEvent'
	c.Event:Connect(function(timer)
		assert(typeof(timer) == "number", "Passed value must be a number.")
		Module.StartTimedSoftShutdown(timer)
	end)
	c.Parent = ServerStorage
end

-- game.ServerStorage.ForceSoftShutdownEvent:Fire()
-- game.ServerStorage.TimedSoftShutdownEvent:Fire(15)

function Module.Start()
	if Module.IsTemporaryServer() then
		print('Temporary Shutdown Server - Teleporting back')
		Players.PlayerAdded:Connect(function(player)
			local TeleportData = player:GetJoinData().TeleportData
			TeleportService:Teleport(game.PlaceId, player, TeleportData)
		end)
		for _, player in ipairs(Players:GetPlayers()) do
			local TeleportData = player:GetJoinData().TeleportData
			TeleportService:Teleport(game.PlaceId, player, TeleportData)
		end
		return
	end

	game:BindToClose(function()
		if #Players:GetPlayers() == 0 then
			return
		end
		Module.OnSoftShutdown()
	end)

	task.spawn(function()
		Module.SetupTestEvents()
		while true do
			if Module.IsTimerOutForSoftShutdown() then
				Module.OnSoftShutdown()
				break
			end
			task.wait(1)
		end
	end)
end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
