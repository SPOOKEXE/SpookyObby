
local LocalPlayer = game:GetService('Players').LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))

local ReplicatedData = ReplicatedModules.Services.ReplicatedData
local TableUtility = ReplicatedModules.Utility.Table

local SystemsContainer = {}

local DataContainer = Instance.new('Folder')
DataContainer.Name = LocalPlayer.Name..'_DATA'
DataContainer.Parent = ReplicatedStorage

-- // Module // --
local Module = {}

function Module.OnPlayerDataUpdated( Data )
	DataContainer:ClearAllChildren()
	TableUtility.TableToObject(Data, DataContainer, {})
end

function Module.Start()
	task.spawn(function()
		Module.OnPlayerDataUpdated( ReplicatedData.GetData('PlayerData', true) )
	end)

	ReplicatedData.OnUpdated:Connect(function(Category, Data)
		if Category == 'PlayerData' then
			Module.OnPlayerDataUpdated( Data )
		end
	end)
end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
