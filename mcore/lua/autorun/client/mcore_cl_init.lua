//--------------------------------------------------------------
//Globals
//--------------------------------------------------------------

//CreateClientConVar( "mcore_setting", "0", true, true, "Save settings for mcore.")

file.CreateDir("mcore")

surface.CreateFont( "mCoreBigFont", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 550,
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

surface.CreateFont( "mCoreSmallFont", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 15,
	weight = 650,
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

function mcoredraw()
	local MCoreDerma = vgui.Create( "DFrame" )
	MCoreDerma:Center()
	MCoreDerma:SetSize( 460, 200)
	MCoreDerma:SetTitle("")
	MCoreDerma:SetVisible( true )
	MCoreDerma:SetDraggable( true )
	MCoreDerma:ShowCloseButton( true )
	MCoreDerma:MakePopup()

	MCoreDerma.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h - 170, string.ToColor(GetConVar("cl_colorZone3"):GetString()))
		draw.RoundedBox( 0, 0, 30, w, h, string.ToColor(GetConVar("cl_colorZone1"):GetString()))
	end

	local MCoreText = vgui.Create("DLabel")
	MCoreText:SetParent(MCoreDerma)
	MCoreText:SetPos( 5, 2 )
	MCoreText:SetSize( 100, 20 )
	MCoreText:SetFont("mCoreBigFont")
	MCoreText:SetText( "MCore" )

	local MCoreText = vgui.Create("DLabel")
	MCoreText:SetParent(MCoreDerma)
	MCoreText:SetPos( 5, 50 )
	MCoreText:SetSize( 100, 10 )
	MCoreText:SetFont("mCoreSmallFont")
	MCoreText:SetTextColor(Color(255, 255, 255))
	MCoreText:SetText( "                Enable multi core rendering to increase game preformance! \n \nBe aware, depending on your hardware you may or may not see a FPS increase \n\n                                   This will do no harm to your game. \n              Any settings changed will revert when you restart your game" )
	MCoreText:SetMultiline(true)
	MCoreText:SizeToContentsX( 3 )
	MCoreText:SizeToContentsY( 3 )

	local MCoreCheckBox = vgui.Create("DCheckBox")
	MCoreCheckBox:SetParent( MCoreDerma )
	MCoreCheckBox:SetPos(110, 165)
	MCoreCheckBox:SetValue(0)

	local MCoreCheckText = vgui.Create("DLabel")
	MCoreCheckText:SetParent(MCoreDerma)
	MCoreCheckText:SetPos( 130, 165 )
	MCoreCheckText:SetSize( 100, 10 )
	MCoreCheckText:SetFont("mCoreSmallFont")
	MCoreCheckText:SetTextColor(Color(255, 255, 255))
	MCoreCheckText:SetText( "Save my setting, and dont ask again." )
	MCoreCheckText:SetMultiline(false)
	MCoreCheckText:SizeToContentsX( 3 )
	MCoreCheckText:SizeToContentsY( 3 )


	local MCoreButton = vgui.Create( "DButton" )
	MCoreButton:SetParent( MCoreDerma )
	MCoreButton:SetFont("mCoreSmallFont")
	MCoreButton:SetText( "Enable" )
	MCoreButton:SetPos( 10, 155 )
    MCoreButton:SetSize( 75, 35 )
    MCoreButton.DoClick = function ()
        if MCoreCheckBox:GetChecked() == true then 
    		file.Write("mcore/settings.txt", "1")
    	else
    		file.Write("mcore/settings.txt", "0")
    	end
    	RunConsoleCommand( "gmod_mcore_test", "1" )
    	RunConsoleCommand( "mat_queue_mode", "-1" )
    	RunConsoleCommand( "cl_threaded_bone_setup", "1" )
    	RunConsoleCommand( "cl_cmdrate", "100" )
    	chat.AddText( Color(255, 255, 255), "[", Color(200,0,255), "MCORE", Color(255,255,255), "] Multi core rendering has been enabled use !mcore off to turn it off if you experience issues" )
   		MCoreDerma:Close()
 	end

 	local MCoreButton = vgui.Create( "DButton" )
	MCoreButton:SetParent( MCoreDerma )
	MCoreButton:SetFont("mCoreSmallFont")
	MCoreButton:SetText( "Disable" )
	MCoreButton:SetPos( 360, 155 )
    MCoreButton:SetSize( 75, 35 )
    MCoreButton.DoClick = function ()
    	if MCoreCheckBox:GetChecked() == true then 
    		file.Write("mcore/settings.txt", "2")
    	else
    		file.Write("mcore/settings.txt", "0")
    	end
    	RunConsoleCommand( "gmod_mcore_test", "0" )
    	RunConsoleCommand( "mat_queue_mode", "0" )
    	RunConsoleCommand( "cl_threaded_bone_setup", "0" )
    	RunConsoleCommand( "cl_cmdrate", "100" )
		chat.AddText( Color(255, 255, 255), "[", Color(200,0,255), "MCORE", Color(255,255,255), "] Multi core rendering has been disabled use !mcore on to re-enable" )
    	MCoreDerma:Close()
 	end
end

usermessage.Hook("mcore_derma", mcoredraw)

function mcoreon()
	print("mcore on")
	RunConsoleCommand( "gmod_mcore_test", "1" )
    RunConsoleCommand( "mat_queue_mode", "-1" )
    RunConsoleCommand( "cl_threaded_bone_setup", "1" )
    RunConsoleCommand( "mcore_setting", "0" )
    RunConsoleCommand( "cl_cmdrate", "100" )
    chat.AddText( Color(255, 255, 255), "[", Color(200,0,255), "MCORE", Color(255,255,255), "] Multi core rendering has been enabled use !mcore off to turn it off if you experience issues" )
 end

usermessage.Hook("mcoreon", mcoreon)

function mcoreoff()
	RunConsoleCommand( "gmod_mcore_test", "0" )
    RunConsoleCommand( "mat_queue_mode", "0" )
    RunConsoleCommand( "cl_threaded_bone_setup", "0" )
    RunConsoleCommand( "mcore_setting", "0" )
    RunConsoleCommand( "cl_cmdrate", "100" )
    chat.AddText( Color(255, 255, 255), "[", Color(200,0,255), "MCORE", Color(255,255,255), "] Multi core rendering has been disabled use !mcore on to re-enable" )
end

usermessage.Hook("mcoreoff", mcoreoff)


function CL_McoreSpawn( )

		local mcore_savedSetting = file.Read("mcore/settings.txt", false)
	
		if not mcore_savedSetting then
			mcore_savedSetting = 0
		end


		if mcore_savedSetting == tostring( 0 ) then
			mcoredraw()
		end

		if mcore_savedSetting == tostring( 1 ) then
			mcoreon()
		end

		if mcore_savedSetting == tostring( 2 )  then
				mcoreoff()
		end


end
net.Receive("CL_McoreSpawn", CL_McoreSpawn)