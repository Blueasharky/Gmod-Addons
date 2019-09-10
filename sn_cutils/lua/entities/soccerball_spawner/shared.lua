//-----------------------------------------------------------------------------------------------
//
//shared file for soccerball spawner
//
//@author TotallyNotLuna/luna/StudioNightly
//@version 28/5/18
//-----------------------------------------------------------------------------------------------

ENT.Base = "base_gmodentity"

ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.Author = "Luna/StudioNightly/TotallyNotLuna"

ENT.Category = "CU Utilities"
ENT.PrintName = "Soccer Ball Spawner"
ENT.Instructions = "Its a football."

function ENT:SetupDataTables()
    
    self:NetworkVar("Int",0,"MaxRange")
end