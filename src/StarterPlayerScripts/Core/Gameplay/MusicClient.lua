
local TweenService = game:GetService('TweenService')

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local LocalModules = require(LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Modules"))

local MusicData = LocalModules.Data.MusicData

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedModules = require(ReplicatedStorage:WaitForChild("Modules"))

local RegionHandler = ReplicatedModules.Services.RegionHandler

local SystemsContainer = {}

local MUSIC_FADE_TWEEN = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local MusicSoundInstance = Instance.new('Sound')
MusicSoundInstance.Name = 'MusicBackground'
MusicSoundInstance.Looped = true
MusicSoundInstance.Parent = workspace

local CurrentSoundId = false
local CurrentSoundData = false

local ActiveRegionId = false

local function SetProperties( Parent, Properties )
	for propName, propValue in pairs(Properties) do
		Parent[propName] = propValue
	end
end

-- // Module // --
local Module = { MusicSoundInstance = MusicSoundInstance }

function Module.GetRegionMusicList()
	local ActiveRegions = RegionHandler.GetActiveRegions()

	-- region is still existent, ignore update
	if table.find(ActiveRegions, ActiveRegionId) then
		return MusicData.RegionSongs[ ActiveRegionId ]
	end

	-- region changed
	local regionPlaylist = false
	for _, id in pairs( ActiveRegions ) do
		regionPlaylist = MusicData.RegionSongs[ id ]
		if regionPlaylist then
			ActiveRegionId = id
			break
		end
	end

	-- region playlist not found, use default playlist
	if not regionPlaylist then
		ActiveRegionId = 'Default'
		regionPlaylist = MusicData.RegionSongs.Default
	end

	return regionPlaylist
end

function Module.FadeSoundOut()
	local Tween = TweenService:Create(MusicSoundInstance, MUSIC_FADE_TWEEN, {Volume = 0})
	Tween:Play()
	Tween.Completed:Wait()
	MusicSoundInstance:Stop()
	MusicSoundInstance.Volume = 0
end

function Module.FadeSoundIn()
	MusicSoundInstance:Play()
	TweenService:Create(MusicSoundInstance, MUSIC_FADE_TWEEN, {Volume = CurrentSoundData.Properties.Volume}):Play()
end

function Module.AwaitSongCrossfadeTime()
	if not MusicSoundInstance.IsLoaded then
		MusicSoundInstance.Loaded:Wait()
	end
	task.wait( MusicSoundInstance.TimeLength - MUSIC_FADE_TWEEN.Time )
end

function Module.UpdateSongPlaylist()
	local SongIds = Module.GetRegionMusicList()

	-- if the playing song is in the region's playlist, ignore the music change
	if table.find(SongIds, CurrentSoundId) then
		return
	end

	-- if the song is playing, fade out
	if MusicSoundInstance.Volume > 0 then
		Module.FadeSoundOut()
	end

	-- change the song id
	local RandomId = SongIds[ Random.new():NextInteger(1, #SongIds) ]
	while CurrentSoundId == RandomId and #SongIds > 1 do
		RandomId = SongIds[ Random.new():NextInteger(1, #SongIds) ]
	end
	print(RandomId)
	CurrentSoundData = MusicData.SongData[ RandomId ]

	SetProperties( MusicSoundInstance, CurrentSoundData.Properties )

	-- start playing again
	Module.FadeSoundIn()
end

function Module.Start()
	RegionHandler.RegionEnter:Connect(function()
		Module.UpdateSongPlaylist()
	end)

	RegionHandler.RegionLeft:Connect(function()
		Module.UpdateSongPlaylist()
	end)

	MusicSoundInstance.Ended:Connect(function()
		MusicSoundInstance:Stop()
		Module.UpdateSongPlaylist()
	end)

	task.defer(Module.UpdateSongPlaylist)
end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module