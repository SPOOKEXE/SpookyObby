
local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.RegisterCheckpoint( CheckpointInstace )

end

function Module.UnregisterCheckpoint( CheckpointInstace )

end

function Module.Start()

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
