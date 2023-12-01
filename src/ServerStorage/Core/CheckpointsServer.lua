local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))

local ReplicatedData = ReplicatedModules.Services.ReplicatedData

local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.RegisterCheckpoint( CheckpointInstace )

end

function Module.UnregisterCheckpoint( CheckpointInstace )

end

function Module.CharacterAdded( LocalPlayer, Character )
	if not Character then
		return
	end

	print('Character Respawned: ', LocalPlayer.Name, Character.Name)
end

function Module.PlayerAdded( LocalPlayer )

	local Profile = SystemsContainer.DataServer.LoadPlayerInstance( LocalPlayer )
	if not Profile then
		warn('Failed to load the target players data: ' .. LocalPlayer.Name)
		return
	end
	ReplicatedData.SetData("PlayerData", Profile.Data, { LocalPlayer })

	task.spawn(Module.CharacterAdded, LocalPlayer, LocalPlayer.Character)
	LocalPlayer.CharacterAdded:Connect(function( Character )
		Module.CharacterAdded( LocalPlayer, Character )
	end)

end

function Module.PlayerRemoving( LocalPlayer )

end

function Module.Start()

	Players.PlayerAdded:Connect(Module.PlayerAdded)
	Players.PlayerRemoving:Connect(Module.PlayerRemoving)

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
