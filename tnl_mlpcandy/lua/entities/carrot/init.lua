AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )  

include( "shared.lua" )


function ENT:Initialize()
 
	self.Entity:SetModel( "models/mlpfurnitureaddon/carrot.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )     
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )   
	self.Entity:SetSolid( SOLID_VPHYSICS )         
	self.Entity:SetUseType(SIMPLE_USE)
    local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, ent )
	
	self.Entity:Remove()
	
	if ( activator:IsPlayer() ) then

		activator:setSelfDarkRPVar("Energy", math.Clamp( activator:getDarkRPVar("Energy") + 20, 0, 100 ))
	
		// Give the collecting player some free health
		local health = activator:Health()
		activator:SetHealth(math.Clamp( activator:Health() + 40, 0, 100 ))
		activator:EmitSound("ediblefoods/eat.wav", 75, 100)
	end
 
    
end


function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create( "Carrot" )
		ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end
 
