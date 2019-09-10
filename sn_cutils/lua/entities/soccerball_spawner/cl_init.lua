include('shared.lua')

surface.CreateFont( "soccerBallResetText", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 100,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

SPAWNERLOCATOR = CreateClientConVar( "cl_soccerballspawnervisible", 0, false, false, "Hides or un-hides the spawner for location purposes." )

function ENT:Draw()

	if( GetConVar( "cl_soccerballspawnervisible" ):GetInt() == 1) then

		self:DrawModel()

		local ang = self:GetAngles()

		ang:RotateAroundAxis( self:GetAngles():Right(), 180)
		ang:RotateAroundAxis( self:GetAngles():Forward(), 180)
		ang:RotateAroundAxis( self:GetAngles():Up(), 90)

		cam.Start3D2D( self:GetPos(), ang, 1)

			draw.RoundedBox(0,-self:GetMaxRange(),-self:GetMaxRange(),2*self:GetMaxRange(),2*self:GetMaxRange(),Color( 255, 255, 255, 100))
		cam.End3D2D()
	end
end
