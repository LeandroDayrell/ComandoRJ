local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vAZ = {}
Tunnel.bindInterface('az-richpresence', vAZ)

vAZ.PlayerCount = function()
	return GetNumPlayerIndices()
end