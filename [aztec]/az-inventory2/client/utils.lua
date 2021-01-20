--[[ az-inventory:utils ]]--

vAZ.DrawText3D = function(x, y, z, text, bg)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    if bg then DrawRect(_x,_y+0.0125, 0.015 + ((string.len(text)) / 370), 0.03, 41, 11, 41, 68) end
end

vAZ.loadPtfx = function(dict)
    RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do Wait(0) end
    UseParticleFxAssetNextCall(dict)
    return dict
end

vAZ.loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end