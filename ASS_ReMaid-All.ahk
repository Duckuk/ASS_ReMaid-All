#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn, All  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode, Pixel
CoordMode, Mouse

;I don't know if it's just this game or if it's flash but the way the game detects inputs is odd (i.e pressing and releasing space in 5-10 milliseconds will only be registered 10% of the time unlike other games)
;This is fine if you're human but not so fine if you're an autohotkey program
SendMode Event
SetKeyDelay, 0, 25
SetMouseDelay, 0

IniRead, swfFileName, ASS_ReMaid-All.ini, Settings, swfFileName
IniRead, timer, ASS_ReMaid-All.ini, Settings, timer
IniRead, timerKey, ASS_ReMaid-All.ini, Settings, timerKey

timerSplit() {
	global
	if (timer) {
		Send, {%timerKey%}
	}
}

pickChoice_2(option) {
	if (option == 1) {
		Click, 951, 527
	} else if (option == 2) {
		Click, 951, 603
	} else {
		MsgBox, %option% is not valid.
	}
	MouseMove, 121, 930
}

pickChoice_3(option) {
	if (option == 1) {
		Click, 951, 488
	} else if (option == 2) {
		Click, 951, 565
	} else if (option == 3) {
		Click, 951, 638
	} else {
		MsgBox, %option% is not valid.
	}
	MouseMove, 121, 930
}

pickChoice_4(option) {
	if (option == 1) {
		Click, 951, 448
	} else if (option == 2) {
		Click, 951, 523
	} else if (option == 3) {
		Click, 951, 599
	} else if (option == 4) {
		Click, 951, 670
	} else {
		MsgBox, %option% is not valid.
	}
	MouseMove, 121, 930
}

pickChoice_5(option) {
	if (option == 1) {
		Click, 951, 412
	} else if (option == 2) {
		Click, 951, 486
	} else if (option == 3) {
		Click, 951, 565
	} else if (option == 4) {
		Click, 951, 634
	} else if (option == 5) {
		Click, 951, 713
	} else {
		MsgBox, %option% is not valid.
	}
	MouseMove, 121, 930
}

endingNewGame(slot := 1, newGame := false) {
	Click, 951, 582
	;Look for nose on main menu
	Loop {
		PixelSearch, xC, yC, 974, 756, 974, 756, 0xBBCFF2, 0, Fast
		if (ErrorLevel = 0) {
			break
		}
	}
	if (!newGame) {
		Click, 951, 325
		Sleep, 50
		
		if (slot == 1) {
			Click, 1456, 329
		} else if (slot == 2) {
			Click, 1118, 538
		} else if (slot == 3) {
			Click, 1468, 538
		} else if (slot == 4) {
			Click, 444, 754
		} else if (slot == 5) {
			Click, 783, 754
		} else if (slot == 6) {
			Click, 1124, 754
		} else if (slot == 7) {
			Click, 1464, 754
		} else {
			MsgBox, Slot '%slot%' is not valid.
		}
	}
	MouseMove, 121, 930
	Sleep, 50
}

saveGame(slot := 1) {
	Send, {Ctrl up}
	Send, {Escape down}
	Sleep, 75
	Send, {Escape up}
	Sleep, 50
	Click, 568, 369
	Sleep, 225
	if (slot == 1) {
		Click, 462, 428
	} else if (slot == 2) {
		Click, 786, 428
	} else if (slot == 3) {
		Click, 1131, 428
	} else if (slot == 4) {
		Click, 1439, 428
	} else if (slot == 5) {
		Click, 464, 655
	} else if (slot == 6) {
		Click, 800, 655
	} else if (slot == 7) {
		Click, 1137, 655
	} else {
		MsgBox, Slot '%slot%' is not valid.
	}
	Sleep, 50
	Click, 967, 826
	Sleep, 300
	Click, 972, 942
	MouseMove, 121, 930
	Send, {Ctrl down}
}

loadGame(slot := 1) {
	Send, {Ctrl up}
	Send, {Escape}
	Sleep, 50
	Click, 568, 665
	Sleep, 200
	if (slot == 1) {
		Click, 1456, 329
	} else if (slot == 2) {
		Click, 1118, 538
	} else if (slot == 3) {
		Click, 1468, 538
	} else if (slot == 4) {
		Click, 444, 754
	} else if (slot == 5) {
		Click, 783, 754
	} else if (slot == 6) {
		Click, 1124, 754
	} else if (slot == 7) {
		Click, 1464, 754
	} else {
		MsgBox, Slot '%slot%' is not valid.
	}
	MouseMove, 121, 930
	Send, {Ctrl down}
}

]::
	;Run .swf file
	Run, %swfFileName%
	
	;Wait for swf player window to exist before switching to and maximizing it
	Loop {
		if WinExist("ahk_exe SWFFilePlayer.exe") {
			WinActivate, ahk_exe SWFFilePlayer.exe
			WinMaximize
			MouseMove, 121, 930
			break
		}
	}
	
	Sleep, 1000
	
	Send, {Tab}{Enter}

	;Look for nose on main menu
	Loop {
		PixelSearch, xColour, yColour, 947, 663, 947, 663, 0xE0E8FD, 0, Fast
		if (ErrorLevel = 0) {
			;Go to options
			Click, 954, 325
			break
		}
	}
	
	Sleep, 25
	
	;Check 'Continue Skipping After Choices'
	Click, 1300, 396
	
	Sleep, 25
	
	;Check 'Disable Automatic Saving'
	;Click, 1300, 512
	
	Sleep, 25
	
	;Set 'Text Speed'
	Click, 1307, 660, down
	Sleep, 25
	Click, up
	
	Sleep, 25
	
	;Set 'Music Volume'
	Click, 1090, 719, down
	Sleep, 25
	Click, up
	
	Sleep, 25
	
	;Set 'Sound Volume'
	Click, 1090, 780, down
	Sleep, 25
	Click, up
	
	Sleep, 25
	
	;Go back to main menu and start new game
	Send, {Escape}
	Sleep, 50
	Send, {Down}{Enter}
	
	Sleep, 100
	
	MouseMove, 121, 930
	
	timerSplit()
	
	Send, {Ctrl down}
	
	;Wait for game to properly start
	Loop {
		PixelSearch, xColour, yColour, 1606, 475, 1606, 475, 0xD2EAEF, 0, Fast
		if (ErrorLevel = 0) {
			Send, {Ctrl up}
			break
		}
	}
	
	;Disable automatic saving
	Send, {Escape}
	Sleep, 50
	Click, 845, 364
	Sleep, 200
	Click, 1300, 512
	Sleep, 50
	Click, 964, 920
	Sleep, 300
	Click, 972, 942
	MouseMove, 121, 930
	Send, {Ctrl down}
	
	;PAVING THE WAY
	
	;Pick 'Say you're fine.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice1.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Apologize.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice2.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Pretend you didn't see her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice3.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Go to class'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\masturbation_choice1.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Wait.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice4.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Wait for her to go back to her room.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice5.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Save and pick 'Excuse yourself.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanachat1_choice2.png
		if (ErrorLevel = 0) {
			saveGame(6)
			pickChoice_5(5)
			break
		}
	}
	
	;Pick 'Head into town.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\town-or-home.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Apologize and leave.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\town_erika-maid.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\after-dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Tell her she's cute.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\walking-home_erika_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;GOING FOR THE 'Rapist' ENDING
	
	;Save and pick 'Ask her if she wants to sit down and have a drink.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\walked-home_choice.png
		if (ErrorLevel = 0) {
			saveGame(1)
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Make fun of her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice1.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Help her undress.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice2.png
		if (ErrorLevel = 0) {
			pickChoice_4(4)
			break
		}
	}
	
	;Pick 'Snap a photo with your phone before you put on her pajamas.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice3.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Gently lift her leg and have a look.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice4.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Save and pick 'Hmmmmm.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice5.png
		if (ErrorLevel = 0) {
			saveGame(2)
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'It's not rape if she doesn't resist.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\rapist_choice6.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;'Rapist' ENDING DONE (1/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_dark.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(2)
			break
		}
	}
	
	;GOING FOR THE '4-Ever Alone' ENDING
	
	Send, {Ctrl down}
	pickChoice_3(2)
	
	;Pick 'Say no.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_know-hana.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Save and pick 'Disagree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_stick-together.png
		if (ErrorLevel = 0) {
			saveGame(7)
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Knock on her door.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-knock.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Ask her if she's feeling alright.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-reply.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Compliment her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-tease.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Invite her to the hanami.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-hanami.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Sit down with Erika.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_sit-down.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Just talk to her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_erika_choice.png
		if (ErrorLevel = 0) {
			pickChoice_4(2)
			break
		}
	}
	
	;Pick 'Say it's been nice.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_hana_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Save and pick 'Stay in your room.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\day7_choice.png
		if (ErrorLevel = 0) {
			saveGame(3)
			pickChoice_4(4)
			break
		}
	}
	
	;'4-Ever Alone' ENDING DONE (2/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_light.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(3)
			break
		}
	}
	
	;GOING FOR THE 'Heart Broke' ENDING
	Send, {Ctrl down}
	pickChoice_3(3)
	
	;Pick 'Agree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_train-sailors.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_town-along.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Let her keep the uniform on.' (Easier to censor)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_uniform_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;'Heart Broke' ENDING DONE (3/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_light.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(7)
			break
		}
	}
	
	;GOING FOR THE 'Kenji' ENDING
	
	Send, {Ctrl down}
	pickChoice_2(1)
	
	;Pick 'Accept it.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_hike-invitation.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Let her be.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-knock.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Go sit down with Kenji.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_sit-down.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Sit for yourself a while longer.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_for-self.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'A couple of rice balls and an energy drink.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_lunch.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick '"Nah..."'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_hana_rich-kid.png
		if (ErrorLevel = 0) {
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Air.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_hana_live-without.png
		if (ErrorLevel = 0) {
			Click, 951, 216
			break
		}
	}
	
	;'Kenji' ENDING DONE (4/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_kenjah.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(1)
			break
		}
	}
	
	;GOING FOR THE 'Erika' ENDING
	
	Send, {Ctrl down}
	pickChoice_3(1)
	
	;Pick 'Say no.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_know-hana.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Disagree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_stick-together.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Go sit with her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_sit-with.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Tell her you enjoyed studying together.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_sitting-with.png
		if (ErrorLevel = 0) {
			pickChoice_4(1)
			break
		}
	}
	
	;Pick 'Knock on her door.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-knock.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Ask her if you can come in.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-reply_2.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Compliment her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-tease.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Invite her to the hanami.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-hanami.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Sit down with Erika.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_sit-down.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Just talk to her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_erika_choice.png
		if (ErrorLevel = 0) {
			pickChoice_4(2)
			break
		}
	}
	
	;Pick 'Say it's been nice.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_hana_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Check with Erika if she's up for something.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\day7_choice.png
		if (ErrorLevel = 0) {
			pickChoice_4(3)
			break
		}
	}
	
	;Pick 'Agree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_train-sailors.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_town-along.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Let her keep the uniform on.' (Easier to censor)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_uniform_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'I came in Erika's mouth.' (Easier to censor)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika-hana_blowie.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;'Erika' ENDING DONE (5/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_erika.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(6)
			break
		}
	}
	
	;GOING FOR THE 'Hana' ENDING
	
	Send, {Ctrl down}
	
	;Pick 'Tell her you just moved in with a girl.'
	pickChoice_5(3)
	
	;Pick 'Tell her she is not your type.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanachat1_erika-choice.png
		if (ErrorLevel = 0) {
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Go for it.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanachat1_dinner-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Order the eggplant pasta.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-dinner_food-choice.png
		if (ErrorLevel = 0) {
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Tell her you like it.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-dinner_class-choice.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Tell her about Erika.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-dinner_erika-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Lie and say you do.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-dinner_sport-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'The flute.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-dinner_sport-choice2.png
		if (ErrorLevel = 0) {
			pickChoice_5(5)
			break
		}
	}
	
	;Pick 'Go dutch.'
	Loop {
		ImageSearch, FoundX, FoundY, 494, 384, 1479, 705, .\ASS_ReMaid-All_resources\hana-dinner_payment-choice.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Go to sleep.'
	Loop {
		ImageSearch, FoundX, FoundY, 494, 384, 1479, 705, .\ASS_ReMaid-All_resources\erika_snoop.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\after-dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Agree to go.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana_town-choice.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Go for it.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-town_drink-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Cum.' (Other option doesn't progress the game)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana-town_sex-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Say yes.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_know-hana2.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Agree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_stick-together2.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Accept it.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_hike-invitation2.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Go sit by yourself.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_sit-with.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Let her be.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-knock.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Go sit down with Hana.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_sit-down.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Say it's been nice.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_hana_choice2.png
		if (ErrorLevel = 0) {
			pickChoice_4(1)
			break
		}
	}
	
	;Pick 'Invite her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_hana_invite-hike.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'A couple of rice balls and an energy drink.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_lunch.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Tease her, lightly.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_hana_rich-kid.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Cat pictures.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_hana_live-without.png
		if (ErrorLevel = 0) {
			Click, 947, 757
			MouseMove, 121, 930
			break
		}
	}
	
	;Pick 'Heaps of money.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hike_hana_live-without2.png
		if (ErrorLevel = 0) {
			Click, 957, 754
			MouseMove, 121, 930
			break
		}
	}
	
	;Pick 'Cum.' (Other option doesn't progress the game)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana_sex-choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Take her in the ass.' (See 'analanal.webm')
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana_sex-choice2.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Come inside of her.' (Other option doesn't progress the game)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hana_sex-choice3.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;'Hana' ENDING DONE (6/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_hana.png
		if (ErrorLevel = 0) {
			timerSplit()
			endingNewGame(1, true)
			break
		}
	}
	
	;GOING FOR THE 'Bomb' ENDING
	
	Send, {Ctrl up}
	
	;Go to options
	Click, 956, 377
	
	Sleep, 25
	
	;Check 'Author's Commentary'
	Click, 1297, 570
	
	;Go back to main menu and start new game
	Click, 960, 922
	Sleep, 50
	Click, 950, 265
	MouseMove, 121, 930
	
	Sleep, 100
	
	Send, {Ctrl down}
	
	;Pick 'Say you're fine.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice1.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Apologize.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice2.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Pretend you didn't see her.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice3.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Go to class.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\masturbation_choice1.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'You've waited enough already.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\choice4.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\shower_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Say it's an explosion of new impressions.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanachat1_choice2_bomb.png
		if (ErrorLevel = 0) {
			Click, 968, 597
			MouseMove, 121, 930
			break
		}
	}
	
	;Pick 'Make an excuse.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanachat1_dinner-choice_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Head into town.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\town-or-home.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Apologize and leave.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\town_erika-maid.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Don't.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\after-dream_choice.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Tell her she's cute.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\walking-home_erika_choice_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Let her go.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\walked-home_choice_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_3(2)
			break
		}
	}
	
	;Pick 'Ask him if he's referring to the girl with the big bombs?'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_know-hana_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_3(3)
			break
		}
	}
	
	;Pick 'Say yes.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_know-hana.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Agree.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_stick-together_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Ask if it's going to be the bomb?'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_hike-invitation_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_4(4)
			break
		}
	}
	
	;Pick 'Decline the invitation.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\kenji_hike-invitation2_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_3(1)
			break
		}
	}
	
	;Pick 'Go sit by yourself.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_sit-with.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Let her be.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\erika_knock-knock.png
		if (ErrorLevel = 0) {
			pickChoice_2(2)
			break
		}
	}
	
	;Pick 'Go sit down with Hana'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_sit-down_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Say it's been nice.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\hanami_hana_choice_bomb.png
		if (ErrorLevel = 0) {
			pickChoice_2(1)
			break
		}
	}
	
	;Pick 'Stay in your room.'
	Loop {
		ImageSearch, FoundX, FoundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, .\ASS_ReMaid-All_resources\day7_choice.png
		if (ErrorLevel = 0) {
			pickChoice_4(4)
			break
		}
	}
	
	;'Bomb' ENDING DONE (7/7)
	
	;Go back to main menu from ending screen
	Loop {
		ImageSearch, FoundX, FoundY, 400, 304, 1584, 542, .\ASS_ReMaid-All_resources\ending-screen_bomb.png
		if (ErrorLevel = 0) {
			timerSplit()
			break
		}
	}
	
	Send, {Ctrl up}
	ExitApp
return

[::
	ExitApp
return

^[::
	Send, {Ctrl up}
	ExitApp
return