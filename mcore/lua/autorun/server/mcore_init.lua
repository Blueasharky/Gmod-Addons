//AddCSLuaFile( "autorun/client/mcore_cl_init.lua" )

-------------------------------------------------
//			ConVar Creation
-------------------------------------------------
//function MCore_Initalize(  )
//	CreateClientConVar( "mcore", "0", true, true, "1 = Mcore on, 2 = Mcore off, 0 = ask on join" )
//end
//hook.Add("Initialize", "MCore_Initalize", MCore_Initalize)

util.AddNetworkString("CL_McoreSpawn")



function MCore_Chat( ply, text )

		if (text == "/mcore") then

			umsg.Start("mcore_derma", ply)

			umsg.End()
			return ""

		elseif (text == "/mcore on") then
			umsg.Start("mcoreon", ply)

			umsg.End()
    		return ""

    	elseif (text == "/mcore off") then
    		umsg.Start("mcoreoff", ply)

			umsg.End()

    		return ""

		end
end


hook.Add("PlayerSay", "MCore_Chat", MCore_Chat )


function MCore_Spawn( ply )

	print("Dis happining")

	timer.Simple(5, function(  )

		net.Start("CL_McoreSpawn")
		net.Send(ply)

	end)
end

hook.Add("PlayerInitialSpawn", "MCore_Spawn", MCore_Spawn)