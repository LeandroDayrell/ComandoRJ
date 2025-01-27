local cfg = module("cfg/homes")

vRP.prepare("vRP/set_address", "INSERT INTO vrp_user_homes(user_id,home,number,locked,guardaRoupa,chest,bauLimite) VALUES(@user_id,@home,@number,@locked,@guardaRoupa,@bau,@bauLimite)")
vRP.prepare("vRP/get_address", "SELECT user_id, home, number, locked FROM vrp_user_homes WHERE user_id = @user_id")
vRP.prepare("vRP/get_home", "SELECT * FROM vrp_user_homes WHERE home = @home")
vRP.prepare("vRP/get_home_owner", "SELECT user_id FROM vrp_user_homes WHERE home = @home AND number = @number")
vRP.prepare("vRP/rm_address", "DELETE FROM vrp_user_homes WHERE user_id = @user_id")

function vRP.getUserAddresses(user_id)
	local rows = vRP.query("vRP/get_address", {user_id = user_id})
	return rows
end

function vRP.setUserAddress(user_id,home,number,locked,limite)
	vRP.execute("vRP/set_address", {user_id = user_id, home = home, number = number, locked = locked, guardaRoupa = json.encode({}), bau = json.encode({}), bauLimite = limite })
end

function vRP.removeUserAddress(user_id)
	vRP.execute("vRP/rm_address", {user_id = user_id})
end

function vRP.getUserByAddress(home,number,cbr)
	local rows = vRP.query("vRP/get_home_owner", {home = home, number = number})
	if #rows > 0 then
		return rows[1].user_id
	end
end