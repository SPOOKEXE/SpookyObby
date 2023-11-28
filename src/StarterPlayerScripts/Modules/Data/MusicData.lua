
-- // Module // --
local Module = {}

Module.SongData = {

	HorrorAtmosphere1 = {
		Properties = {
			SoundId = 'rbxassetid://1840271919',
			Volume = 0.025,
		},

		Display = false,
	},

	ScaryViolinNote = {
		Properties = {
			SoundId = 'rbxassetid://1839261153',
			Volume = 0.1,
		},

		Display = false,
	},

	EerieTheme1 = {
		Properties = {
			SoundId = 'rbxassetid://1836907831',
			Volume = 0.1,
		},

		Display = false,
	},

	CreepyNight1 = {
		Properties = {
			SoundId = 'rbxassetid://1846999567',
			Volume = 0.05,
		},

		Display = false,
	},

	Doom1 = {
		Properties = {
			SoundId = 'rbxassetid://1842546777',
			Volume = 0.125,
		},

		Display = false,
	},

}

local SongIds = { }
for songId, _ in pairs(Module.SongData) do
	table.insert(SongIds, songId)
end

Module.RegionSongs = {
	Default = SongIds,
}

return Module
