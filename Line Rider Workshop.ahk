#SingleInstance Ignore
SetBatchLines, -1
SetDefaultMouseSpeed, 0
CoordMode, Mouse, Screen

;///////////////////////////////////////////////////////////;

; Global variables
stop = true

doChangeColor1 = false
changeColor1Pos := 0
key1 := 1

doChangeColor2 = false
changeColor2Pos := 0
key2 := 2


moves := 0
radius := 0.0
radiusIncrementation := 0.0
startingAngle := 0.0
angleIncrementation := 0.0


tip = nothing

;///////////////////////////////////////////////////////////;

; GUI
Gui, Font, Bold
Gui, Add, GroupBox, x12 y5 w250 h220
Gui, Add, GroupBox, x12 y217 w390 h220
Gui, Add, Text, x32 y6 w57 h18 , Spiral tool
Gui, Font

; Moves
Gui, Add, GroupBox, x22 y17 w118 h42 , 
Gui, Add, Text, x32 y37 w40 h18 , Moves
Gui, Add, Edit, x72 y31 w60 h20 , 720
Gui, Add, UpDown, x40 y31 w20 h30 Range1-32767 Wrap 0x80, UpDown
GuiControl, Text, Edit1, 720

; Radius
Gui, Add, GroupBox, x22 y57 w230 h80 , 
Gui, Add, Text, x32 y77 w60 h20 , Circle radius
Gui, Add, Edit, x102 y72 w50 h20 , 100
Gui, Add, Text, x32 y107 w160 h20 , Radius incrementation per move
Gui, Add, Edit, x192 y102 w50 h20 , 0.1

; Angle
Gui, Add, GroupBox, x22 y137 w230 h80 , 
Gui, Add, Text, x32 y158 w70 h20 , Starting angle
Gui, Add, Edit, x102 y152 w50 h20 , 0
Gui, Add, Text, x32 y188 w160 h20 , Angle incrementation per move
Gui, Add, Edit, x192 y182 w50 h20 , 2

; Change line color #1
Gui, Add, GroupBox, x12 y217 w390 h86 , 
Gui, Add, Text, x32 y257 w100 h20 , Change line color to
Gui, Add, GroupBox, x132 y223 w60 h74 , 
Gui, Font, S8 CBlue, Arial
Gui, Add, Radio, x138 y233 w42 h20 +Checked, Blue
Gui, Font, S8 CRed, Arial
Gui, Add, Radio, x138 y253 w40 h20 , Red
Gui, Font, S8 CGreen, Arial
Gui, Add, Radio, x138 y273 w50 h20 , Green
Gui, Font
Gui, Add, Text, x202 y258 w50 h20 , on angle
Gui, Add, Edit, x252 y252 w60 h20 , 180
Gui, Add, Button, x322 y232 w60 h30 gOkChangeColor1, Ok
Gui, Add, Button, x327 y270 w50 h25 +Disabled gUndoChangeColor1, Undo

; Change line color #2
Gui, Add, GroupBox, x12 y295 w390 h86 , 
Gui, Add, Text, x32 y337 w100 h20 , Change line color to
Gui, Add, GroupBox, x132 y301 w60 h74 , 
Gui, Font, S8 CBlue, Arial
Gui, Add, Radio, x138 y312 w42 h20 , Blue
Gui, Font, S8 CRed, Arial
Gui, Add, Radio, x138 y332 w40 h20 +Checked, Red
Gui, Font, S8 CGreen, Arial
Gui, Add, Radio, x138 y352 w50 h20 , Green
Gui, Font
Gui, Add, Text, x202 y338 w50 h20 , on angle
Gui, Add, Edit, x252 y332 w60 h20 , 0
Gui, Add, Button, x322 y310 w60 h30 gOkChangeColor2, Ok
Gui, Add, Button, x327 y348 w50 h25 +Disabled gUndoChangeColor2, Undo

; Hotkey
Gui, Add, GroupBox, x22 y382 w180 h46 , 
Gui, Add, Text, x32 y402 w60 h20 , Hotkey
Gui, Add, Hotkey, x72 y399 w120 h20 , F11
Gui, Add, Button, x212 y393 w80 h30 Default gSpiralOk, Ok

Gui, Add, Button, x361 y445 w60 h20 , About..

Gui, Add, Text, x25 y450 w330 h20 gChangeTip, Tip:
GoSub, changeTip

; Curve
Gui, Font
Gui, Add, GroupBox, x272 y5 w140 h175 , 
Gui, Font, Bold
Gui, Add, Text, x292 y6 w58 h16 , Curve tool
Gui, Font
Gui, Add, GroupBox, x282 y17 w120 h42 , 
Gui, Add, Text, x292 y37 w50 h18 , Lines
Gui, Add, Edit, x325 y31 w60 h20 , 10
Gui, Add, UpDown, x372 y22 w20 h30 Range1-32767 Wrap 0x80, UpDown
GuiControl, Text, Edit8, 10
Gui, Add, GroupBox, x282 y57 w120 h80 ,
Gui, Add, Text, x292 y77 w50 h20 , Hotkey
Gui, Add, Hotkey, x292 y102 w100 h20 , F12
Gui, Add, Button, x332 y142 w70 h30 gCurveOk, Ok


; Generated using SmartGUI Creator 4.0

Gui, Show, x400 y250 w425 h470, Line Rider Workshop v1.0 - by Arion
return

;///////////////////////////////////////////////////////////;

OkChangeColor1:
   doChangeColor1 = false
   
   GuiControlGet, myBlue, , Button8
   GuiControlGet, myRed, , Button9
   GuiControlGet, myGreen, , Button10
   GuiControlGet, myAngle1, , Edit6
   

   if (myAngle1 < 0) || (myAngle1 > 360)
      msgbox Invalid angle!

   else
      {   
         if myBlue
            key1 := 1
            
         else if myRed
            key1 := 2
            
         else if myGreen
            key1 := 3
         
         GuiControl, +Disabled, Static7        
         GuiControl, +Disabled, Button8
         GuiControl, +Disabled, Button9
         GuiControl, +Disabled, Button10
         GuiControl, +Disabled, Static8
         GuiControl, +Disabled, Edit6
         GuiControl, +Disabled, Button11
         
         GuiControl, -Disabled, Button12
         
         doChangeColor1 = true
         changeColor1Pos := myAngle1
      }
   
return


UndoChangeColor1:
   GuiControl, -Disabled, Static7       
   GuiControl, -Disabled, Button8
   GuiControl, -Disabled, Button9
   GuiControl, -Disabled, Button10
   GuiControl, -Disabled, Static8
   GuiControl, -Disabled, Edit6
   GuiControl, -Disabled, Button11
   
   GuiControl, +Disabled, Button12
   
   doChangeColor1 = false
return

;///////////////////////////////////////////////////////////;

OkChangeColor2:
   doChangeColor2 = false
   
   GuiControlGet, myBlue, , Button15
   GuiControlGet, myRed, , Button16
   GuiControlGet, myGreen, , Button17
   GuiControlGet, myAngle2, , Edit7
   

   if (myAngle2 < 0) || (myAngle2 > 360)
      msgbox Invalid angle!

   else
      {   
         if myBlue
            key2 := 1
            
         else if myRed
            key2 := 2
            
         else if myGreen
            key2 := 3
         
         GuiControl, +Disabled, Static9    
         GuiControl, +Disabled, Button15
         GuiControl, +Disabled, Button16
         GuiControl, +Disabled, Button17
         GuiControl, +Disabled, Static10
         GuiControl, +Disabled, Edit7
         GuiControl, +Disabled, Button18
         
         GuiControl, -Disabled, Button19
         
         doChangeColor2 = true
         changeColor2Pos := myAngle2
      }
   
return


UndoChangeColor2:
   GuiControl, -Disabled, Static9      
   GuiControl, -Disabled, Button15
   GuiControl, -Disabled, Button16
   GuiControl, -Disabled, Button17
   GuiControl, -Disabled, Static10
   GuiControl, -Disabled, Edit7
   GuiControl, -Disabled, Button18
   
   GuiControl, +Disabled, Button19
   
   doChangeColor2 = false
return

;///////////////////////////////////////////////////////////;

SpiralOk:
   GuiControlGet, moves, , Edit1
   GuiControlGet, radius, , Edit2
   GuiControlGet, radiusIncrementation, , Edit3
   GuiControlGet, startingAngle, , Edit4
   GuiControlGet, angleIncrementation, , Edit5
   
   
   if (moves <= 0) || (moves > 32767)
      MsgBox, 64, Invalid parameter!, Invalid moves amount!`n`nEnter an integer number between 1 and 32767
      
   else if (radius < 1) || (radius > 32767)
      msgbox Invalid circle radius!`n`nEnter a number between 1.0 and 32767
      
   else if (radiusIncrementation < 0) || (radiusIncrementation > 32767)
      msgbox Invalid circle radius incrementation!`n`nEnter a number between 0 and 32767`n`nTip: Set it to 0 to make a circle
      
   else if (startingAngle < 0) || (startingAngle > 32767)
      msgbox Invalid starting angle!`n`nEnter a number between 0 and 32767
      
   else if (angleIncrementation <= 0) || (angleIncrementation > 32767)
      msgbox Invalid angle incrementation!`n`nEnter a number between 0.1 and 32767
      
   else
      {
         GuiControlGet, hotkeyShortcut, , msctls_hotkey321
         Hotkey, %hotkeyShortcut%, makeSpiral
         
         if radiusIncrementation = 0
            TrayTip, Circle, Hotkey ready!, 10, 1
         
         else
            TrayTip, Spiral, Hotkey ready!, 10, 1
      }
   
return

;///////////////////////////////////////////////////////////;

makeSpiral:
   MouseGetPos, baseX, baseY   
   
   localAngle := startingAngle
   localRadius := radius   
   
   baseY := baseY - localRadius
   
   GetKeyState, state, LButton
   
   if state = D
      Click up
      
   stop = false
   
   Loop, %moves%
      {
         if state = D
            if A_Index = 2
               Click down


         if stop = true
           break
            
         newX := baseX + localRadius * sin(localAngle * 3.141592653589793 / 180)
         newY := baseY + localRadius * cos(localAngle * 3.141592653589793 / 180)

         MouseMove, %newX%, %newY%  


         if doChangeColor1 = true
            if mod(localAngle, 360) = changeColor1Pos
               Send %key1%

         if doChangeColor2 = true
            if mod(localAngle, 360) = changeColor2Pos
               Send %key2%


         localAngle += %angleIncrementation%         
         
         localRadius += %radiusIncrementation%
      }   
return

;///////////////////////////////////////////////////////////;

CurveOk:
   GuiControlGet, lines, , Edit8
   
   if (lines < 1) || (lines > 32767)
      msgbox Invalid lines amount!`n`nEnter an integer number between 1 and 32767
      
   else
      {
         GuiControlGet, hotkeyShortcut, , msctls_hotkey322
         
         Hotkey, %hotkeyShortcut%, makeCurve
         
         TrayTip, Curve, Hotkey ready!, 10, 1
      }

return

;///////////////////////////////////////////////////////////;

makeCurve:
   GuiControlGet, lines, , Edit8   
   
   KeyWait, LButton, D
   MouseGetPos, x1, y1
   KeyWait, LButton, U   
   MouseGetPos, x2, y2
   
   KeyWait, LButton, D
   MouseGetPos, x3, y3
   KeyWait, LButton, U
   MouseGetPos, x4, y4   


   MouseMove, x1, y1
   Click down
   MouseMove, x3, y3
   Click up

   stop = false
   
   Loop % lines - 1
      {
         if stop = true
           break
           
           
         startX := x1 + (x2 - x1) / (lines - 1) * A_Index
         startY := y1 + (y2 - y1) / (lines - 1) * A_Index
         
         endX := x3 + (x4 - x3) / (lines - 1) * A_Index
         endY := y3 + (y4 - y3) / (lines - 1) * A_Index


         MouseMove, %startX%, %startY%
         Click down
         MouseMove, %endX%, %endY%
         Click up
      }
return

;///////////////////////////////////////////////////////////;

changeTip:
   ControlGetText, oldTip, Static12
   
   Loop
      {
         Random, rand, 1, 9

         if rand = 1
            tip = Tip #1: Set "Radius incrementation per move" to 0 to make a circle.
         else if rand = 2
            tip = Tip #2: You can make as many customized hotkeys as you want.
         else if rand = 3
            tip = Tip #3: You can change the line color at 2 different positions.
         else if rand = 4
            tip = Tip #4: Smaller angle incrementation means smoother spirals.
         else if rand = 5
            tip = Tip #5: You can use this script anywhere else besides Line Rider.
         else if rand = 6
            tip = Tip #6: To stop creating a spiral or curve, press "Esc".
         else if rand = 7
            tip = Tip #7: The cake is a lie.
         else if rand = 8
            tip = Tip #8: More lines in a curve causes more lag.
         else if rand = 9
            tip = Tip #9: Set "Moves" to 30 and keep hotkey pressed. Surprise.


         if (oldTip = "") || ((oldTip <> "") && oldTip <> tip)
            break
      }
      
   Gui, Font, S8 CGreen Italic, Arial   
   GuiControl, Font, Static12
   
   Loop, 2
      {
         GuiControl, , Static12
         Sleep 100
         GuiControl, , Static12, %oldTip%
         Sleep 100
      }

   Loop, 1
      {
         GuiControl, , Static12
         Sleep 100
         GuiControl, , Static12, %tip%
         Sleep 100
      }

return

;///////////////////////////////////////////////////////////;

ButtonAbout..:
   MsgBox, 532544, About.., Line Rider Workshop`nv1.0 - 11/01/2008`nby Arion`narionkrause@gmail.com`n`n`nPowered by AutoHotkey®`nautohotkey.com`n`nDesigned for Line Rider®`nlinerider.com
return

;///////////////////////////////////////////////////////////;

~Esc::
   stop = true
return

;///////////////////////////////////////////////////////////;

GuiClose:
ExitApp