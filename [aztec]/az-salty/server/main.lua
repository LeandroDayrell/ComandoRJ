local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')
vAZclient = Tunnel.getInterface('az-salty')
vAZ = {}
Tunnel.bindInterface('az-salty', vAZ)

vAZ.private = {
    [1] = {permission = "policia.permissao"},
    [2] = {permission = "policia.permissao"},
    [3] = {permission = "policia.permissao"},
    [4] = {permission = "samuradio.permissao"},
	[5] = {permission = "policia.permissao"},
	[6] = {permission = "policia.permissao"},
    [7] = {permission = "policia.permissao"}
}

RegisterCommand('radio',function(source, args, rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id, "walkietalkie") > 0 then
        vAZclient.OpenNUIRadio(source)
    end
end)

RegisterCommand('vvoz',function(source, args, rawCommand)
    local source = source
    if args[1] then
        if args[1] == 'true' then
            exports['saltychat']:SetPlayerRadioSpeaker(source, true)
        elseif args[1] == 'false' then
            exports['saltychat']:SetPlayerRadioSpeaker(source, false)
        end
    end
end)

vAZ.SetPlayerAlive = function(bool)
    local source = source
    exports['saltychat']:SetPlayerAlive(source, bool)
end

vAZ.RadioItem = function()
    local source = source
    local user_id = parseInt(user_id)
    return (vRP.getInventoryItemAmount(user_id, "walkietalkie") > 0)
end

vAZ.RadioPermission = function(channel)
    local source = source
    local user_id = vRP.getUserId(source)
    if vAZ.private[channel] then
        if not vRP.hasPermission(user_id, vAZ.private[channel].permission) then
            TriggerClientEvent('Notify', source, 'importante', 'Você não pode entrar nessa <b>frequencia!</b>')
            return false
        end
    end
    return true
end

async(function()
    exports['saltychat']:SetRadioTowers({
        vector3(-338.7884, -579.6178, 48.0948944),
        vector3(-293.022156, -632.1178, 47.43132),
        vector3(-269.2281, -962.775, 143.51416),
        vector3(98.88757, -870.866333, 136.916489),
        vector3(-214.615784, -744.6461, 219.442841),
        vector3(-166.724548, -590.671753, 199.078262),
        vector3(124.2959, -654.8749, 261.861633),
        vector3(149.2771, -769.009155, 261.861633),
        vector3(580.176941, 89.59447, 117.330841),
        vector3(423.6479, 15.5682507, 151.924164),
        vector3(424.921936, 18.5860023, 151.93103),
        vector3(551.9955, -28.1988735, 93.86244),
        vector3(305.862976, -284.849426, 68.2982941),
        vector3(299.487976, -313.949341, 68.2982941),
        vector3(1240.899, -1090.09509, 44.35722),
        vector3(-418.446381, -2804.49487, 14.8069534),
        vector3(802.335449, -2996.21313, 27.3687477),
        vector3(253.297028, -3145.925, 39.4068832),
        vector3(207.652008, -3145.925, 39.4145126),
        vector3(207.652008, -3307.39746, 39.51926),
        vector3(247.336456, -3307.39746, 39.5240364),
        vector3(484.285553, -2178.58228, 40.2511559),
        vector3(548.352051, -2219.756, 67.9466553),
        vector3(-701.2187, 58.91474, 68.6857452),
        vector3(-696.7746, 208.69516, 139.773132),
        vector3(-769.8155, 255.006042, 134.738525),
        vector3(-150.320984, -150.245941, 96.1528),
        vector3(-202.968384, -327.191345, 65.0489349),
        vector3(-1913.76978, -3031.84961, 22.5877686),
        vector3(-1918.88379, -3028.62476, 22.6142921),
        vector3(-1039.81726, -2385.44434, 27.4025517),
        vector3(-1042.57849, -2390.22681, 27.4025517),
        vector3(-1583.46069, -3216.81, 28.6338768),
        vector3(-1590.3728, -3212.547, 28.6604),
        vector3(-1308.23, -2626.36816, 36.0893),
        vector3(-1311.997, -2624.58887, 36.11582),
        vector3(-984.6726, -2778.28174, 48.2857475),
        vector3(-991.5846, -2774.019, 48.31227),
        vector3(-556.70166, -119.851929, 50.98835),
        vector3(-619.0831, -106.581512, 51.0120239),
        vector3(-1167.26953, -575.026733, 40.19548),
        vector3(-1152.40771, -443.973816, 42.8913651),
        vector3(-1156.08057, -498.807922, 49.3204346),
        vector3(-1290.00684, -445.2428, 106.471085),
        vector3(-928.507568, -383.133362, 135.269775),
        vector3(-902.8115, -443.052917, 170.818512),
        vector3(-770.0829, -786.3356, 83.82861),
        vector3(-824.313232, -719.180542, 120.251671),
        vector3(-598.8342, -917.80896, 35.8440781),
        vector3(-678.5171, -717.0078, 54.0979462),
        vector3(-669.458, -804.2544, 31.8843975),
        vector3(-1463.98755, -526.122864, 83.58365),
        vector3(-1525.9043, -596.7999, 66.5211945),
        vector3(-1375.13428, -465.258484, 83.51427),
        vector3(-1711.98438, 478.334045, 127.189156),
        vector3(-2311.60059, 335.444122, 187.604874),
        vector3(-2214.416, 342.206, 198.101166),
        vector3(-2234.35522, 187.023453, 193.601486),
        vector3(202.693359, 1204.00012, 230.258759),
        vector3(217.064575, 1140.44348, 230.258759),
        vector3(758.4658, 1273.72107, 405.944946),
        vector3(668.782654, 590.3213, 136.9934),
        vector3(722.2471, 562.26825, 134.294266),
        vector3(838.170532, 510.109131, 138.664932),
        vector3(773.1747, 575.3554, 138.415543),
        vector3(735.4507, 231.999466, 145.136826),
        vector3(450.932, 5566.45068, 795.442),
        vector3(-449.0599, 6019.92334, 35.5656433),
        vector3(-142.555878, 6286.784, 39.2638245),
        vector3(-368.047058, 6105.006, 38.4290161),
        vector3(2792.246, 5996.04541, 355.192261),
        vector3(2796.773, 5992.87158, 354.988953),
        vector3(3460.883, 3653.53247, 51.1671066),
        vector3(3459.17847, 3659.83447, 51.19159),
        vector3(3615.938, 3642.9502, 51.19159),
        vector3(3614.5918, 3636.56177, 51.1671066),
        vector3(-2180.7937, 3252.70313, 54.3309),
        vector3(-2124.38062, 3219.853, 54.3309),
        vector3(-2050.93921, 3178.414, 54.3309),
        vector3(1858.295, 3694.04248, 37.9116821),
        vector3(1695.48584, 3614.86255, 37.7968445),
        vector3(715.3033, 2582.80542, 81.20924),
        vector3(1692.82947, 2532.07324, 60.3378525),
        vector3(1692.82947, 2647.942, 60.3378525),
        vector3(1824.35254, 2574.386, 60.56225),
        vector3(1407.90771, 2117.48877, 104.101059)
    })
end)