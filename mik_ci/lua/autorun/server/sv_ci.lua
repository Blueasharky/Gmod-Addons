//-------------------------------------------------------------------------------
//							Cop incentive
//	incetivieses being a cop by giving a small payment to all cops on arrest
//
//by: Mikomi
//7/20/17
//-------------------------------------------------------------------------------

ciPolice = { "Mayor", "Equestrian Police", "Equestrian Police Quartermaster", "Equestrian Police Chief" }

print("Cop incentive Loaded yo")

function CI_PayThePolice(  )
local cuCurPolice = {}
	
	for k,v in pairs(player.GetAll()) do
		
		if table.HasValue(ciPolice, v:getJobTable().name) == true then
			cuCurPolice[ #cuCurPolice + 1 ] = v 
		end
		
	end

	for k,v in pairs(cuCurPolice) do
		v:addMoney( 5 )
		DarkRP.notify( v, 0, 6, "The EPS has been rewarded 5 bits from the Mayor for another scucessful arrest.")
	end

	return nil

end
hook.Add("playerArrested", "CI_PayThePolice", CI_PayThePolice)