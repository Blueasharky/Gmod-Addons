//-----------------------------------------------------------------------------------------------
//
//Server side script for ghoul entity
//
//@author TotallyNotLuna/luna/StudioNightly
//@version 28/5/18
//-----------------------------------------------------------------------------------------------
AddCSLuaFile("shared.lua")
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')

SPAWNERMODEL = "models/Gibs/HGIBS.mdl"
ENTITYCLASS = "sent_soccerball"

SPAWNTIME = CreateConVar( "sv_soccerballspawnerrange", 500, 128, "Sets the range in which the soccerball can be from the spawner." )

ENT.SPAWNEDBALL = nil






function ENT:Initialize()

	self:SetModel( SPAWNERMODEL )

	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)        

    local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then

		phys:Wake()
	end

	self:SetMaxRange(GetConVar("sv_soccerballspawnerrange"):GetInt())
end





function ENT:Think()

	local validBall = false

	if self.SPAWNEDBALL != nil then

		local corner1 = Vector(self:GetPos().x + GetConVar("sv_soccerballspawnerrange"):GetInt(), self:GetPos().y + GetConVar("sv_soccerballspawnerrange"):GetInt()/2, self:GetPos().z + GetConVar("sv_soccerballspawnerrange"):GetInt())
		local corner2 = Vector(self:GetPos().x - GetConVar("sv_soccerballspawnerrange"):GetInt(), self:GetPos().y - GetConVar("sv_soccerballspawnerrange"):GetInt()/2, self:GetPos().z - GetConVar("sv_soccerballspawnerrange"):GetInt())

		local nearbyEnts = ents.FindInBox( corner1, corner2 )

		for k,v in pairs(nearbyEnts) do

			if IsValid(v) && IsValid(self.SPAWNEDBALL) then

				if v:GetClass() == self.SPAWNEDBALL:GetClass() then

					validBall = true
				end
			end
		end
	end






	if( self.SPAWNEDBALL == nil ||  validBall == false ) then //spawn the goods

		if self.SPAWNEDBALL != nil then

			self.SPAWNEDBALL:Remove()
			self.SPAWNEDBALL = nil
		end

		self.SPAWNEDBALL = ents.Create(ENTITYCLASS)

		self.SPAWNEDBALL:SetPos( self:GetPos() )
		self.SPAWNEDBALL:Spawn()
	end





	self:SetMaxRange(GetConVar("sv_soccerballspawnerrange"):GetInt())

	self:NextThink(CurTime() + 10 )
	return true
end












