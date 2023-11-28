local Players = game:GetService("Players")

local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.RegisterObbyCheckpoint( CheckpointInstace )

end

function Module.UnregisterObbyCheckpoint( CheckpointInstace )

end

function Module.CharacterAdded( LocalPlayer, Character )
	if not Character then
		return
	end

	print('Character Respawned: ', LocalPlayer.Name, Character.Name)
end

function Module.PlayerAdded( LocalPlayer )

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
