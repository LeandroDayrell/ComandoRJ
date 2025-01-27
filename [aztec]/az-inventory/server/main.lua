local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
local Tools = module('vrp', 'lib/Tools')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-inventory')
vAZ = {}
Tunnel.bindInterface('az-inventory', vAZ)

vAZgarage = Proxy.getInterface('az-garages')
vAZhomes = Proxy.getInterface('az-homes')

vAZ.id = Tools.newIDGenerator()
vAZ.temp = {}

-- etc