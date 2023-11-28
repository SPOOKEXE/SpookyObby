
local Module = {}

Module.LightingProperties = {

	Default = {
		Morning = {
			TimeStart = 6.5,
			TimeEnd = 8,

			Properties = {
				Ambient = Color3.new(),
				Brightness = 2.8,
				ColorShift_Bottom = Color3.new(),
				ColorShift_Top = Color3.fromRGB(141, 111, 91),
				EnvironmentDiffuseScale = 0.5,
				EnvironmentSpecularScale = 0.5,
				OutdoorAmbient = Color3.fromRGB(140, 137, 88),
				ShadowSoftness = 0.15,
				ExposureCompensation = -0.12,
			},

			Effects = {

				Sky = {
					CelestialBodiesShown = true,
					MoonAngularSize = 11,
					MoonTextureId = 'rbxassetid://1345054856',
					SkyboxBk = 'rbxassetid://591058823',
					SkyboxDn = 'rbxassetid://591059876',
					SkyboxFt = 'rbxassetid://591058104',
					SkyboxLf = 'rbxassetid://591057861',
					SkyboxRt = 'rbxassetid://591057625',
					SkyboxUp = 'rbxassetid://591059642',
					StarCount = 3000,
					SunAngularSize = 11,
					SunTextureId = 'rbxassetid://1345009717',
				},

				SunRays = {
					Intensity = 0.01,
					Spread = 0.146,
				},
			},
		},

		Day = {
			TimeStart = 11,
			TimeEnd = 12,

			Properties = {
				Ambient = Color3.new(),
				Brightness = 4,
				ColorShift_Bottom = Color3.new(),
				ColorShift_Top = Color3.fromRGB(88, 114, 161),
				EnvironmentDiffuseScale = 0.7,
				EnvironmentSpecularScale = 0.7,
				OutdoorAmbient = Color3.fromRGB(121, 139, 161),
				ShadowSoftness = 0.15,
				ExposureCompensation = 0,
			},

			Effects = {
				Sky = {
					CelestialBodiesShown = true,
					MoonAngularSize = 11,
					MoonTextureId = 'rbxassetid://1345054856',
					SkyboxBk = 'rbxassetid://591058823',
					SkyboxDn = 'rbxassetid://591059876',
					SkyboxFt = 'rbxassetid://591058104',
					SkyboxLf = 'rbxassetid://591057861',
					SkyboxRt = 'rbxassetid://591057625',
					SkyboxUp = 'rbxassetid://591059642',
					StarCount = 3000,
					SunAngularSize = 11,
					SunTextureId = 'rbxassetid://1345009717',
				},

				SunRays = {
					Intensity = 0.01,
					Spread = 0.146,
				},
			},
		},

		Afternoon = {
			TimeStart = 16.3,
			TimeEnd = 17.8,

			Properties = {
				Ambient = Color3.new(),
				Brightness = 3,
				ColorShift_Bottom = Color3.new(),
				ColorShift_Top = Color3.fromRGB(255, 192, 146),
				EnvironmentDiffuseScale = 0.222,
				EnvironmentSpecularScale = 0.222,
				OutdoorAmbient = Color3.fromRGB(65, 72, 53),
				ShadowSoftness = 0.15,
				ExposureCompensation = 0,
			},

			Effects = {
				Atmosphere = {
					Density = 0.279,
					Offset = 0.309,

					Color = Color3.fromRGB(124, 184, 134),
					Decay = Color3.fromRGB(109, 149, 75),
					Glare = 0,
					Haze = 0,
				},

				Sky = {
					CelestialBodiesShown = true,
					MoonAngularSize = 11,
					MoonTextureId = 'rbxassetid://1345054856',
					SkyboxBk = 'rbxassetid://627331893',
					SkyboxDn = 'rbxassetid://627331733',
					SkyboxFt = 'rbxassetid://627331981',
					SkyboxLf = 'rbxassetid://627331549',
					SkyboxRt = 'rbxassetid://627331779',
					SkyboxUp = 'rbxassetid://627332635',
					StarCount = 1334,
					SunAngularSize = 11,
					SunTextureId = 'rbxassetid://1345009717',
				},

				Bloom = {
					Intensity = 1,
					Size = 24,
					Threshold = 2,
				},

				DepthOfField = {
					FarIntensity = 0.1,
					FocusDistance = 0.05,
					InFocusRadius = 50,
					NearIntensity = 0.75,
				},

				SunRays = {
					Intensity = 0.01,
					Spread = 0.146,
				},
			},
		},

		Night = {
			TimeStart = 17.9,
			TimeEnd = 18.2,

			Properties = {
				Ambient = Color3.new(),
				Brightness = 2.8,
				ColorShift_Bottom = Color3.new(),
				ColorShift_Top = Color3.fromRGB(216, 192, 153),
				EnvironmentDiffuseScale = 1,
				EnvironmentSpecularScale = 1,
				OutdoorAmbient = Color3.fromRGB(63, 83, 116),
				ShadowSoftness = 0.15,
				ExposureCompensation = -0.62,
			},

			Effects = {
				Sky = {
					CelestialBodiesShown = true,
					MoonAngularSize = 11,
					MoonTextureId = 'rbxassetid://1345054856',
					SkyboxBk = 'rbxassetid://591058823',
					SkyboxDn = 'rbxassetid://591059876',
					SkyboxFt = 'rbxassetid://591058104',
					SkyboxLf = 'rbxassetid://591057861',
					SkyboxRt = 'rbxassetid://591057625',
					SkyboxUp = 'rbxassetid://591059642',
					StarCount = 3000,
					SunAngularSize = 11,
					SunTextureId = 'rbxassetid://1345009717',
				},

				SunRays = {
					Intensity = 0.01,
					Spread = 0.146,
				},
			},

		},

		Thunderstorm = {
			WindLoudness = 0.1,
			ActivateRain = true,
			ThunderChance = (1/800),

			Properties = {
				Ambient = Color3.fromRGB(56, 56, 56),
				Brightness = 0.45,
				ColorShift_Bottom = Color3.new(),
				ColorShift_Top = Color3.fromRGB(130, 110, 82),
				EnvironmentDiffuseScale = 0.2,
				EnvironmentSpecularScale = 0.2,
				OutdoorAmbient = Color3.fromRGB(115, 122, 153),
				ShadowSoftness = 0.15,
				ExposureCompensation = -1.37,
			},

			Effects = {
				Sky = {
					CelestialBodiesShown = true,
					MoonAngularSize = 11,
					MoonTextureId = 'rbxassetid://1345054856',
					SkyboxBk = 'rbxassetid://246480323',
					SkyboxDn = 'rbxassetid://246480523',
					SkyboxFt = 'rbxassetid://246480105',
					SkyboxLf = 'rbxassetid://246480105',
					SkyboxRt = 'rbxassetid://246480565',
					SkyboxUp = 'rbxassetid://246480504',
					StarCount = 3000,
					SunAngularSize = 11,
					SunTextureId = 'rbxassetid://1345009717',
				},

				Atmosphere = {
					Density = 0.406,
					Offset = 0,

					Color = Color3.fromRGB(20, 122, 199),
					Decay = Color3.fromRGB(20, 122, 199),
					Glare = 0.31,
					Haze = 2.4,
				},
			},
		},
	},

}

return Module
