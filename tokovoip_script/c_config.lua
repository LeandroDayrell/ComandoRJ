TokoVoipConfig = {
	refreshRate = 250, -- Rate at which the data is sent to the TSPlugin
	networkRefreshRate = 2000, -- Rate at which the network data is updated/reset on the local ped
	playerListRefreshRate = 5000, -- Rate at which the playerList is updated
	minVersion = "1.2.4", -- Version of the TS plugin required to play on the server
	distance = {
		12, -- Normal speech distance in gta distance units
		4, -- Whisper speech distance in gta distance units
		30, -- Shout speech distance in gta distance units
	},
	headingType = 1, -- headingType 0 uses GetGameplayCamRot, basing heading on the camera's heading, to match how other GTA sounds work. headingType 1 uses GetEntityHeading which is based on the character's direction
	radioKey = Keys["CAPS"], -- Keybind used to talk on the radio
	keySwitchChannels = Keys["LEFTSHIFT"], -- Keybind used to switch the radio channels
	keySwitchChannelsSecondary = Keys["Z"], -- If set, both the keySwitchChannels and keySwitchChannelsSecondary keybinds must be pressed to switch the radio channels
	keyProximity = Keys["HOME"], -- Keybind used to switch the proximity mode
	plugin_data = {
		TSChannel = "CRJ - TokoVOIP",
		TSPassword = "crj2020", -- TeamSpeak channel password (can be empty)
		TSChannelWait = "Aguardando TokoVOIP",		
		-- Blocking screen informations
		TSServer = "ts.comandorj.com.br", -- TeamSpeak server address to be displayed on blocking screen
		TSChannelSupport = "discord.gg/VUmdPh5", -- TeamSpeak support channel name displayed on blocking screen
		TSDownload = "", -- Download link displayed on blocking screen
		TSChannelWhitelist = {}, -- Black screen will not be displayed when users are in those TS channels
		-- The following is purely TS client settings, to match tastes
		local_click_on = true, -- Is local click on sound active
		local_click_off = true, -- Is local click off sound active
		remote_click_on = false, -- Is remote click on sound active
		remote_click_off = true, -- Is remote click off sound active
		enableStereoAudio = true, -- If set to true, positional audio will be stereo (you can hear people more on the left or the right around you)
		localName = "", -- If set, this name will be used as the user's teamspeak display name
		localNamePrefix = "["..GetPlayerServerId(PlayerId()).."] ", -- If set, this prefix will be added to the user's teamspeak display name
	}
};

AddEventHandler("onClientResourceStart", function(resource)
	if (resource == GetCurrentResourceName()) then	--	Initialize the script when this resource is started
		Citizen.CreateThread(function()
			TokoVoipConfig.plugin_data.localName = escape(GetPlayerName(PlayerId())); -- Set the local name
		end);
		TriggerEvent("initializeVoip"); -- Trigger this event whenever you want to start the voip
	end
end)
