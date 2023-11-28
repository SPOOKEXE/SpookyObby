local Lighting = game:GetService('Lighting')

local SystemsContainer = {}

-- // Module // --
local Module = {}

function Module.Start()

	Lighting.Ambient = Color3.fromRGB(80,80,80)
	Lighting.Brightness = 2
	Lighting.OutdoorAmbient = Color3.fromRGB(108, 108, 108)
	Lighting.ClockTime = 0

	local Atmosphere = Instance.new('Atmosphere')
	Atmosphere.Density = 0.627
	Atmosphere.Color = Color3.new()
	Atmosphere.Decay = Color3.new()
	Atmosphere.Glare = 0
	Atmosphere.Haze = 0

	local BLACK_SKYBOX = 'http://www.roblox.com/asset/?ID=2013298'
	local SolidSkybox = Instance.new('Sky')
	SolidSkybox.CelestialBodiesShown = false
	SolidSkybox.MoonAngularSize = 11
	SolidSkybox.MoonTextureId = 'rbxasset://sky/moon.jpg'
	SolidSkybox.SkyboxBk = BLACK_SKYBOX
	SolidSkybox.SkyboxDn = BLACK_SKYBOX
	SolidSkybox.SkyboxFt = BLACK_SKYBOX
	SolidSkybox.SkyboxLf = BLACK_SKYBOX
	SolidSkybox.SkyboxRt = BLACK_SKYBOX
	SolidSkybox.SkyboxUp = BLACK_SKYBOX
	SolidSkybox.StarCount = 0
	SolidSkybox.SunAngularSize = 21
	SolidSkybox.SunTextureId = 'rbxasset://sky/sun.jpg'

end

function Module.Init(otherSystems)
	SystemsContainer = otherSystems
end

return Module
