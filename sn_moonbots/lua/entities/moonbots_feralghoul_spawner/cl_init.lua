include('shared.lua')

SPAWNERLOCATOR = CreateClientConVar( "cl_feralghoulspawnervisible", 0, false, false, "Hides or un-hides the spawner for location purposes." )

function ENT:Draw()

	if(GetConVar( "cl_feralghoulspawnervisible" ):GetInt() == 1) then

		self:DrawModel()
	end
end
