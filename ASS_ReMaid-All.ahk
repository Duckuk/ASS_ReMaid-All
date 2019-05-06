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

waitUntilChoice(fileName, startX:=0, startY:=0, endX:=false, endY:=false) {
	global FoundX
	global FoundY
	endX := !(endX) ? (A_ScreenWidth) : (endX)		;Just an if/else statement for hipsters, they're called 'ternary operators'
	endY := !(endY) ? (A_ScreenHeight) : (endY)		;Probably not a good idea to use these often as readability suffers quite a bit
	Loop {
		ImageSearch, FoundX, FoundY, %startX%, %startY%, %endX%, %endY%, .\ASS_ReMaid-All_resources\%fileName%.png
		if !(ErrorLevel) {
			break
		}
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
	global xColour
	global yColour
	Click, 951, 582
	;Look for nose on main menu
	Loop {
		PixelSearch, xColour, yColour, 974, 756, 974, 756, 0xBBCFF2, 0, Fast
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
	waitUntilChoice("choice1")
	pickChoice_2(2)
	
	
	;Pick 'Apologize.'
	waitUntilChoice("choice2")
	pickChoice_3(1)
	
	
	;Pick 'Pretend you didn't see her.'
	waitUntilChoice("choice3")
	pickChoice_2(1)
	
	
	;Pick 'Go to class'
	waitUntilChoice("masturbation_choice1")
	pickChoice_2(2)
	
	
	;Pick 'Wait.'
	waitUntilChoice("choice4")
	pickChoice_2(1)
	
	
	;Pick 'Wait for her to go back to her room.'
	waitUntilChoice("choice5")
	pickChoice_2(2)
	
	
	;Save and pick 'Excuse yourself.'
	waitUntilChoice("hanachat1_choice2")
	saveGame(6)
	pickChoice_5(5)
	
	
	;Pick 'Head into town.'
	waitUntilChoice("town-or-home")
	pickChoice_2(1)
	
	
	;Pick 'Apologize and leave.'
	waitUntilChoice("town_erika-maid")
	pickChoice_3(2)
	
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	waitUntilChoice("dream_choice")
	pickChoice_2(1)
	
	
	;Pick 'Don't.'
	waitUntilChoice("after-dream_choice")
	pickChoice_2(2)
	
	
	;Pick 'Tell her she's cute.'
	waitUntilChoice("walking-home_erika_choice")
	pickChoice_2(1)
	
	
	;GOING FOR THE 'Rapist' ENDING
	
	
	;Save and pick 'Ask her if she wants to sit down and have a drink.'
	waitUntilChoice("walked-home_choice")
	saveGame(1)
	pickChoice_3(3)
	
	
	;Pick 'Make fun of her.'
	waitUntilChoice("rapist_choice1")
	pickChoice_3(1)
	
	
	;Pick 'Help her undress.'
	waitUntilChoice("rapist_choice2")
	pickChoice_4(4)
	
	
	;Pick 'Snap a photo with your phone before you put on her pajamas.'
	waitUntilChoice("rapist_choice3")
	pickChoice_2(1)
	
	
	;Pick 'Gently lift her leg and have a look.'
	waitUntilChoice("rapist_choice4")
	pickChoice_2(1)
	
	
	;Save and pick 'Hmmmmm.'
	waitUntilChoice("rapist_choice5")
	saveGame(2)
	pickChoice_3(3)
	
	
	;Pick 'It's not rape if she doesn't resist.'
	waitUntilChoice("rapist_choice6")
	pickChoice_2(2)
	
	
	;'Rapist' ENDING DONE (1/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_dark", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(2)
	
	
	;GOING FOR THE '4-Ever Alone' ENDING
	
	
	Send, {Ctrl down}
	pickChoice_3(2)
	
	
	;Pick 'Say no.'
	waitUntilChoice("kenji_know-hana")
	pickChoice_2(2)
	
	
	;Save and pick 'Disagree.'
	waitUntilChoice("kenji_stick-together")
	saveGame(7)
	pickChoice_2(2)
	
	
	;Pick 'Knock on her door.'
	waitUntilChoice("erika_knock-knock")
	pickChoice_2(1)
	
	
	;Pick 'Ask her if she's feeling alright.'
	waitUntilChoice("erika_knock-reply")
	pickChoice_3(1)
	
	
	;Pick 'Compliment her.'
	waitUntilChoice("erika_knock-tease")
	pickChoice_3(2)
	
	
	;Pick 'Invite her to the hanami.'
	waitUntilChoice("erika_knock-hanami")
	pickChoice_2(1)
	
	
	;Pick 'Sit down with Erika.'
	waitUntilChoice("hanami_sit-down")
	pickChoice_3(1)
	
	
	;Pick 'Just talk to her.'
	waitUntilChoice("hanami_erika_choice")
	pickChoice_4(2)
	
	
	;Pick 'Say it's been nice.'
	waitUntilChoice("hanami_hana_choice")
	pickChoice_2(1)
	
	
	;Save and pick 'Stay in your room.'
	waitUntilChoice("day7_choice")
	saveGame(3)
	pickChoice_4(4)
	
	
	;'4-Ever Alone' ENDING DONE (2/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_light", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(3)
	
	
	;GOING FOR THE 'Heart Broke' ENDING
	Send, {Ctrl down}
	pickChoice_3(3)
	
	
	;Pick 'Agree.'
	waitUntilChoice("erika_train-sailors")
	pickChoice_3(1)
	
	
	;Pick 'Don't.'
	waitUntilChoice("erika_town-along")
	pickChoice_2(2)
	
	
	;Pick 'Let her keep the uniform on.' (Easier to censor)
	waitUntilChoice("erika_uniform_choice")
	pickChoice_2(2)
	
	
	;'Heart Broke' ENDING DONE (3/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_light", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(7)
	
	
	;GOING FOR THE 'Kenji' ENDING
	
	
	Send, {Ctrl down}
	pickChoice_2(1)
	
	
	;Pick 'Accept it.'
	waitUntilChoice("kenji_hike-invitation")
	pickChoice_3(2)
	
	
	;Pick 'Let her be.'
	waitUntilChoice("erika_knock-knock")
	pickChoice_2(2)
	
	
	;Pick 'Go sit down with Kenji.'
	waitUntilChoice("hanami_sit-down")
	pickChoice_3(2)
	
	
	;Pick 'Sit for yourself a while longer.'
	waitUntilChoice("hanami_for-self")
	pickChoice_2(2)
	
	
	;Pick 'A couple of rice balls and an energy drink.'
	waitUntilChoice("hike_lunch")
	pickChoice_3(1)
	
	
	;Pick '"Nah..."'
	waitUntilChoice("hike_hana_rich-kid")
	pickChoice_3(3)
	
	
	;Pick 'Air.'
	waitUntilChoice("hike_hana_live-without")
	Click, 951, 216
	MouseMove, 121, 930
	
	
	;'Kenji' ENDING DONE (4/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_kenjah", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(1)
	
	
	;GOING FOR THE 'Erika' ENDING
	
	
	Send, {Ctrl down}
	pickChoice_3(1)
	
	
	;Pick 'Say no.'
	waitUntilChoice("kenji_know-hana")
	pickChoice_2(2)
	
	
	;Pick 'Disagree.'
	waitUntilChoice("kenji_stick-together")
	pickChoice_2(2)
	
	
	;Pick 'Go sit with her.'
	waitUntilChoice("erika_sit-with")
	pickChoice_2(1)
	
	
	;Pick 'Tell her you enjoyed studying together.'
	waitUntilChoice("erika_sitting-with")
	pickChoice_4(1)
	
	
	;Pick 'Knock on her door.'
	waitUntilChoice("erika_knock-knock")
	pickChoice_2(1)
	
	
	;Pick 'Ask her if you can come in.'
	waitUntilChoice("erika_knock-reply_2")
	pickChoice_3(1)
	
	
	;Pick 'Compliment her.'
	waitUntilChoice("erika_knock-tease")
	pickChoice_3(2)
	
	
	;Pick 'Invite her to the hanami.'
	waitUntilChoice("erika_knock-hanami")
	pickChoice_2(1)
	
	
	;Pick 'Sit down with Erika.'
	waitUntilChoice("hanami_sit-down")
	pickChoice_3(1)
	
	
	;Pick 'Just talk to her.'
	waitUntilChoice("hanami_erika_choice")
	pickChoice_4(2)
	
	
	;Pick 'Say it's been nice.'
	waitUntilChoice("hanami_hana_choice")
	pickChoice_2(1)
	
	
	;Pick 'Check with Erika if she's up for something.'
	waitUntilChoice("day7_choice")
	pickChoice_4(3)
	
	
	;Pick 'Agree.'
	waitUntilChoice("erika_train-sailors")
	pickChoice_3(1)
	
	
	;Pick 'Don't.'
	waitUntilChoice("erika_town-along")
	pickChoice_2(2)
	
	
	;Pick 'Let her keep the uniform on.' (Easier to censor)
	waitUntilChoice("erika_uniform_choice")
	pickChoice_2(2)
	
	
	;Pick 'I came in Erika's mouth.' (Easier to censor)
	waitUntilChoice("erika-hana_blowie")
	pickChoice_2(1)
	
	
	;'Erika' ENDING DONE (5/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_erika", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(6)
	
	
	;GOING FOR THE 'Hana' ENDING
	
	
	Send, {Ctrl down}
	
	
	;Pick 'Tell her you just moved in with a girl.'
	pickChoice_5(3)
	
	
	;Pick 'Tell her she is not your type.'
	waitUntilChoice("hanachat1_erika-choice")
	pickChoice_3(3)
	
	
	;Pick 'Go for it.'
	waitUntilChoice("hanachat1_dinner-choice")
	pickChoice_2(1)
	
	
	;Pick 'Order the eggplant pasta.'
	waitUntilChoice("hana-dinner_food-choice")
	pickChoice_3(3)
	
	
	;Pick 'Tell her you like it.'
	waitUntilChoice("hana-dinner_class-choice")
	pickChoice_3(2)
	
	
	;Pick 'Tell her about Erika.'
	waitUntilChoice("hana-dinner_erika-choice")
	pickChoice_2(2)
	
	
	;Pick 'Lie and say you do.'
	waitUntilChoice("hana-dinner_sport-choice")
	pickChoice_2(2)
	
	
	;Pick 'The flute.'
	waitUntilChoice("hana-dinner_sport-choice2")
	pickChoice_5(5)
	
	
	;Pick 'Go dutch.'
	waitUntilChoice("hana-dinner_payment-choice", 494, 384, 1479, 705)
	pickChoice_3(2)
	
	
	;Pick 'Go to sleep.'
	waitUntilChoice("erika_snoop", 494, 384, 1479, 705)
	pickChoice_2(2)
	
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	waitUntilChoice("dream_choice")
	pickChoice_2(1)
	
	
	;Pick 'Don't.'
	waitUntilChoice("after-dream_choice")
	pickChoice_2(2)
	
	
	;Pick 'Agree to go.'
	waitUntilChoice("hana_town-choice")
	pickChoice_3(1)
	
	
	;Pick 'Go for it.'
	waitUntilChoice("hana-town_drink-choice")
	pickChoice_2(1)
	
	
	;Pick 'Cum.' (Other option doesn't progress the game)
	waitUntilChoice("hana-town_sex-choice")
	pickChoice_2(1)
	
	
	;Pick 'Say yes.'
	waitUntilChoice("kenji_know-hana2")
	pickChoice_3(1)
	
	
	;Pick 'Agree.'
	waitUntilChoice("kenji_stick-together2")
	pickChoice_2(1)
	
	
	;Pick 'Accept it.'
	waitUntilChoice("kenji_hike-invitation2")
	pickChoice_3(2)
	
	
	;Pick 'Go sit by yourself.'
	waitUntilChoice("erika_sit-with")
	pickChoice_2(2)
	
	
	;Pick 'Let her be.'
	waitUntilChoice("erika_knock-knock")
	pickChoice_2(2)
	
	
	;Pick 'Go sit down with Hana.'
	waitUntilChoice("hanami_sit-down")
	pickChoice_3(1)
	
	
	;Pick 'Say it's been nice.'
	waitUntilChoice("hanami_hana_choice2")
	pickChoice_4(1)
	
	
	;Pick 'Invite her.'
	waitUntilChoice("hanami_hana_invite-hike")
	pickChoice_2(1)
	
	
	;Pick 'A couple of rice balls and an energy drink.'
	waitUntilChoice("hike_lunch")
	pickChoice_3(1)
	
	
	;Pick 'Tease her, lightly.'
	waitUntilChoice("hike_hana_rich-kid")
	pickChoice_3(2)
	
	
	;Pick 'Cat pictures.'
	waitUntilChoice("hike_hana_live-without")
	Click, 947, 757
	MouseMove, 121, 930
	
	
	;Pick 'Heaps of money.'
	waitUntilChoice("hike_hana_live-without2")
	Click, 957, 754
	MouseMove, 121, 930
	
	
	;Pick 'Cum.' (Other option doesn't progress the game)
	waitUntilChoice("hana_sex-choice")
	pickChoice_2(1)
	
	
	;Pick 'Take her in the ass.' (See supplementary video)
	waitUntilChoice("hana_sex-choice2")
	pickChoice_2(1)
	
	
	;Pick 'Come inside of her.' (Other option doesn't progress the game)
	waitUntilChoice("hana_sex-choice3")
	pickChoice_2(1)
	
	
	;'Hana' ENDING DONE (6/7)
	
	
	;Go back to main menu from ending screen
	waitUntilChoice("ending-screen_hana", 400, 304, 1584, 542)
	timerSplit()
	endingNewGame(1, true)
	
	
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
	waitUntilChoice("choice1")
	pickChoice_2(2)
	
	
	;Pick 'Apologize.'
	waitUntilChoice("choice2")
	pickChoice_3(1)
	
	
	;Pick 'Pretend you didn't see her.'
	waitUntilChoice("choice3")
	pickChoice_2(1)
	
	
	;Pick 'Go to class.'
	waitUntilChoice("masturbation_choice1")
	pickChoice_2(2)
	
	
	;Pick 'You've waited enough already.'
	waitUntilChoice("choice4")
	pickChoice_2(2)
	
	
	;Pick 'Don't.'
	waitUntilChoice("shower_choice")
	pickChoice_2(2)
	
	
	;Pick 'Say it's an explosion of new impressions.'
	waitUntilChoice("hanachat1_choice2_bomb")
	Click, 968, 597
	MouseMove, 121, 930
	
	
	;Pick 'Make an excuse.'
	waitUntilChoice("hanachat1_dinner-choice_bomb")
	pickChoice_2(2)
	
	
	;Pick 'Head into town.'
	waitUntilChoice("town-or-home")
	pickChoice_2(1)
	
	
	;Pick 'Apologize and leave.'
	waitUntilChoice("town_erika-maid")
	pickChoice_3(2)
	
	
	;Pick 'Begin to masturbate.' (It has less dialogue)
	waitUntilChoice("dream_choice")
	pickChoice_2(1)
	
	
	;Pick 'Don't.'
	waitUntilChoice("after-dream_choice")
	pickChoice_2(2)
	
	
	;Pick 'Yell "bomb!"'
	waitUntilChoice("walking-home_erika_choice_bomb")
	pickChoice_3(3)
	
	
	;Pick 'Let her go.'
	waitUntilChoice("walked-home_choice_bomb")
	pickChoice_3(2)
	
	
	;Pick 'Ask him if he's referring to the girl with the big bombs?'
	waitUntilChoice("kenji_know-hana_bomb")
	pickChoice_3(3)
	
	
	;Pick 'Say yes.'
	waitUntilChoice("kenji_know-hana")
	pickChoice_2(1)
	
	
	;Pick 'Agree.'
	waitUntilChoice("kenji_stick-together_bomb")
	pickChoice_2(1)
	
	
	;Pick 'Ask if it's going to be the bomb?'
	waitUntilChoice("kenji_hike-invitation_bomb")
	pickChoice_4(4)
	
	
	;Pick 'Decline the invitation.'
	waitUntilChoice("kenji_hike-invitation2_bomb")
	pickChoice_3(1)
	
	
	;Pick 'Go sit by yourself.'
	waitUntilChoice("erika_sit-with")
	pickChoice_2(2)
	
	
	;Pick 'Let her be.'
	waitUntilChoice("erika_knock-knock")
	pickChoice_2(2)
	
	
	;Pick 'Go sit down with Hana'
	waitUntilChoice("hanami_sit-down_bomb")
	pickChoice_2(1)
	
	
	;Pick 'Say it's been nice.'
	waitUntilChoice("hanami_hana_choice_bomb")
	pickChoice_2(1)
	
	
	;Pick 'Stay in your room.'
	waitUntilChoice("day7_choice")
	pickChoice_4(4)
	
	
	;'Bomb' ENDING DONE (7/7)
	
	
	;Stop timer on ending screen
	waitUntilChoice("ending-screen_bomb", 400, 304, 1584, 542)
	timerSplit()
	
	
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