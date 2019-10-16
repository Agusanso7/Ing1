!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Exercise'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 18:52:19'!
test01WhenGameBeginXIsPlayingAndOIsNot

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	""
	
	self assert: terniLapiliGame isPlayingX.
	self assert: terniLapiliGame isPlayingO not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 18:54:02'!
test02WhenGameBeginsOCantPutChips

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	self should: [terniLapiliGame putOAt: 'a1'] 
		raise: Error 
		description: TerniLapilli invalidTurnErrorDescription.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:20:50'!
test03WhenGameBeginsXPlacesAChipAndTakesThePositionInTheBoard
	
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	
	self assert:( terniLapiliGame isXAt: 'a1').
	self assert: terniLapiliGame numberOfChips equals: 1! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 18:55:42'!
test04ItsOTurnAfterXPlays

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	self assert: terniLapiliGame isPlayingX not.
	self assert: terniLapiliGame isPlayingO.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:03'!
test05XCantPlayTwiceInARow

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	self should: [terniLapiliGame putXAt: 'a2'] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:error | 
			self assert: error messageText  = TerniLapilli invalidTurnErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 1. 
	].
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:20:32'!
test06WhenGameBeginsOCanPutChipsAfterX

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	
	self assert: terniLapiliGame numberOfChips equals: 2.
	self assert: (terniLapiliGame isOAt: 'a1') not.
	self assert: (terniLapiliGame isOAt: 'a2').! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:23:49'!
test07ItsXTurnAfterO

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	
	self assert: terniLapiliGame isPlayingO not.
	self assert: terniLapiliGame isPlayingX.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:15'!
test08XCantPutTwoChipsInTheSamePlace

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	
	self should: [terniLapiliGame putXAt: 'a1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[:error |
				self assert: error messageText = TerniLapilli positionTakenErrorDescription.
				self assert: terniLapiliGame numberOfChips equals: 2.
				self assert: (terniLapiliGame isXAt: 'a1').
				self assert: (terniLapiliGame isOAt: 'a2').
	].
		
	self should: [terniLapiliGame putXAt: 'a2']
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[:error |
				self assert: error messageText = TerniLapilli positionTakenErrorDescription.
				self assert: terniLapiliGame numberOfChips equals: 2.
				self assert: (terniLapiliGame isXAt: 'a1').
				self assert: (terniLapiliGame isOAt: 'a2').
	].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:24'!
test09OCantPutTwoChipsInTheSamePlace

	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'a3'.
	
	self should: [terniLapiliGame putOAt: 'a2']
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[:error |
				self assert: error messageText = TerniLapilli positionTakenErrorDescription.
				self assert: terniLapiliGame numberOfChips equals: 3.
				self assert: (terniLapiliGame isXAt: 'a1').
				self assert: (terniLapiliGame isXAt: 'a3').
				self assert: (terniLapiliGame isOAt: 'a2').
	].
		
			
	self should: [terniLapiliGame putOAt: 'a3']
		raise: Error - MessageNotUnderstood 
		withExceptionDo:[:error |
				self assert: error messageText = TerniLapilli positionTakenErrorDescription.
				self assert: terniLapiliGame numberOfChips equals: 3.
				self assert: (terniLapiliGame isXAt: 'a1').
				self assert: (terniLapiliGame isXAt: 'a3').
				self assert: (terniLapiliGame isOAt: 'a2').
	].! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:53:40'!
test10WhenGameBeginsItisNotOver
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	self assert: terniLapiliGame isOver not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:29:17'!
test11XWinsIfItHas3ChipsInTopRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'b1'.
	terniLapiliGame putXAt: 'a2'.
	terniLapiliGame putOAt: 'c1'.
	terniLapiliGame putXAt: 'a3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:32:33'!
test12XWinsIfItHas3ChipsInBottomRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'c1'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:39:21'!
test13XWinsIfItHas3ChipsInCenterRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'b1'.
	terniLapiliGame putOAt: 'c1'.
	terniLapiliGame putXAt: 'b2'.
	terniLapiliGame putOAt: 'c2'.
	terniLapiliGame putXAt: 'b3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:46:58'!
test14XWinsIfItHas3ChipsInLeftColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'c3'.
	terniLapiliGame putXAt: 'b1'.
	terniLapiliGame putOAt: 'c2'.
	terniLapiliGame putXAt: 'c1'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:47:04'!
test15XWinsIfItHas3ChipsInCenterColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a2'.
	terniLapiliGame putOAt: 'c3'.
	terniLapiliGame putXAt: 'b2'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'c2'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:47:23'!
test16XWinsIfItHas3ChipsInRightColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a3'.
	terniLapiliGame putOAt: 'c2'.
	terniLapiliGame putXAt: 'b3'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'c3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:49:17'!
test17XWinsIfItHas3ChipsInADiagonal
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a3'.
	terniLapiliGame putOAt: 'c2'.
	terniLapiliGame putXAt: 'b2'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'c1'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:51:31'!
test18XWinsIfItHas3ChipsInInverseDiagonal
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'c2'.
	terniLapiliGame putXAt: 'b2'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerXWon.
	self assert: terniLapiliGame hasPlayerOWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 20:59:47'!
test19OWinsIfItHas3ChipsInTopRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'c1'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'b2'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'b3'.
	terniLapiliGame putOAt: 'a3'.

	self assert: terniLapiliGame isOver.
	self assert: terniLapiliGame hasPlayerOWon.
	self assert: terniLapiliGame hasPlayerXWon not.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:37'!
test20OCantPlaceMoreChipsIfXWon
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'c1'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c3'.
	self  should: [terniLapiliGame putOAt: 'a3']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli gameIsAlreadyOverErrorDescription.
			self assert: terniLapiliGame isOver.
			self assert: terniLapiliGame  hasPlayerXWon.
			self assert: terniLapiliGame numberOfChips equals: 5.
			self assert: (terniLapiliGame isOAt: 'a3') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:44'!
test21XCantPlaceMoreThan3Chips
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self  should: [terniLapiliGame putXAt: 'b1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli cantPlaceMoreChipsErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'b1') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:51'!
test22XCantMoveChipsHavingPlayedLessThan3
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	
	self  should: [terniLapiliGame moveXChipFrom: 'a1' to: 'b2']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli cantMoveChipsYetErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 2.
			self assert: (terniLapiliGame isXAt: 'a1').
			self assert: (terniLapiliGame isXAt: 'b2') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'ss 10/13/2019 19:09:44'!
test23XCanMoveAChipAfterHavingPlaced3
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	
	self assert: terniLapiliGame numberOfChips equals: 6.
	self assert: (terniLapiliGame isXAt: 'b1').
	self assert: (terniLapiliGame isXAt: 'a1') not.	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:55:58'!
test24XCantMoveAChipToAnOccupiedSpace
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self should: [terniLapiliGame moveXChipFrom: 'a1' to: 'b2'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: TerniLapilli positionTakenErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'b2') not.
			self assert: (terniLapiliGame isXAt: 'a1').	
	].
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:03'!
test25XCantMoveAChipFromSpaceWithoutItsChip
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self should: [terniLapiliGame moveXChipFrom: 'a3' to: 'b3'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: TerniLapilli movingFromInvalidPositionErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'b3') not.
			self assert: (terniLapiliGame isXAt: 'a3') not.
			self assert: (terniLapiliGame isOAt: 'a3').	
	].
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'ss 10/13/2019 19:28:08'!
test26OCanMoveChipsAfterHavingPlaced3
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	terniLapiliGame moveOChipFrom: 'a2' to: 'a1'.
	
	self assert: terniLapiliGame numberOfChips equals: 6.
	self assert: (terniLapiliGame isOAt: 'a1').
	self assert: (terniLapiliGame isOAt: 'a2') not.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:27'!
test27OCantPlaceMoreThan3Chips
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	
	self  should: [terniLapiliGame putOAt: 'a1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli cantPlaceMoreChipsErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isOAt: 'a1') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:32'!
test28OCantMoveChipsTwiceInARow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	terniLapiliGame moveOChipFrom: 'a2' to: 'a1'.
	
	self  should: [terniLapiliGame moveOChipFrom: 'b2' to: 'b3']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidTurnErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isOAt: 'b2').
			self assert: (terniLapiliGame isOAt: 'b3') not.
			self assert: terniLapiliGame isPlayingX.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:37'!
test29XCantMoveChipsTwiceInARow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	
	self  should: [terniLapiliGame moveXChipFrom: 'c2' to: 'c1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidTurnErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'c2').
			self assert: (terniLapiliGame isXAt: 'c1') not.
			self assert: terniLapiliGame isPlayingO.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:40'!
test30XCantMoveChipsFromBottomRowtoTopRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self  should: [terniLapiliGame moveXChipFrom: 'a1' to: 'c1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidMovementErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'a1').
			self assert: (terniLapiliGame isXAt: 'c1') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:46'!
test31XCantMoveChipsFromLeftColumntoRightColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self  should: [terniLapiliGame moveXChipFrom: 'a1' to: 'b3']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidMovementErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'a1').
			self assert: (terniLapiliGame isXAt: 'b3') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:54'!
test32OCantMoveChipsFromLeftColumntoRightColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	terniLapiliGame moveXChipFrom: 'a1' to: 'b1'.
	
	self  should: [terniLapiliGame moveOChipFrom: 'a3' to: 'c1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidMovementErrorDescription.
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isOAt: 'a3').
			self assert: (terniLapiliGame isOAt: 'b3') not.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:56:59'!
test33CantPutChipInUnexistingRow
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	self  should: [terniLapiliGame putXAt: 'z1']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli unexistingPositionErrorDescription .
			self assert: terniLapiliGame numberOfChips equals: 0.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:57:03'!
test34CantPutChipInUnexistingColumn
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	self  should: [terniLapiliGame putXAt: 'a9']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli unexistingPositionErrorDescription .
			self assert: terniLapiliGame numberOfChips equals: 0.
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 15:54:34'!
test35CantMoveChipToUnexistingPosition
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'a1'.
	terniLapiliGame putOAt: 'a2'.
	terniLapiliGame putXAt: 'c2'.
	terniLapiliGame putOAt: 'a3'.
	terniLapiliGame putXAt: 'c3'.
	terniLapiliGame putOAt: 'b2'.
	
	self  should: [terniLapiliGame moveXChipFrom: 'a1' to: 'z100']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli unexistingPositionErrorDescription .
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'a1').
	]! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/16/2019 17:10:41'!
test36CantMoveFromSideToAnotherSide
	| terniLapiliGame |
	
	terniLapiliGame := TerniLapilli startNewGame.
	
	terniLapiliGame putXAt: 'b1'.
	terniLapiliGame putOAt: 'a1'.
	terniLapiliGame putXAt: 'a2'.
	terniLapiliGame putOAt: 'b3'.
	terniLapiliGame putXAt: 'a3'.
	terniLapiliGame putOAt: 'c3'.
	
	self should: [terniLapiliGame moveXChipFrom: 'b1' to: 'c2']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
			self assert: error messageText = TerniLapilli invalidMovementErrorDescription .
			self assert: terniLapiliGame numberOfChips equals: 6.
			self assert: (terniLapiliGame isXAt: 'b1').
			self assert: (terniLapiliGame isXAt: 'c2') not.
	]! !


!classDefinition: #TerniLapilli category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'turn xChipPositions oChipPositions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilli methodsFor: 'initialization' stamp: 'a s 10/10/2019 19:28:16'!
initialize
	turn := #X.
	xChipPositions := OrderedCollection new.
	oChipPositions := OrderedCollection new.! !


!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/10/2019 18:39:01'!
isPlayingO
	^turn = #O! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/10/2019 18:36:46'!
isPlayingX
	
	^ turn = #X
	! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/16/2019 18:50:21'!
moveOChipFrom: initialPosition to: nextPosition 
	self state moveOChipFrom: initialPosition to: nextPosition.
	
	turn := #X! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/16/2019 18:50:41'!
moveXChipFrom: initialPosition to: nextPosition
	self state moveXChipFrom: initialPosition to: nextPosition.

	turn := #O! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/16/2019 18:39:21'!
putOAt: aPosition
	self state putOAt: aPosition.

	turn := #X.
	
	! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/16/2019 18:50:54'!
putXAt: aPosition
	self state putXAt: aPosition.

	turn := #O.! !


!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/10/2019 21:09:31'!
hasPlayerOWon
	^self hasWonWithChipsIn: oChipPositions ! !

!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/10/2019 21:09:50'!
hasPlayerXWon
	^self hasWonWithChipsIn: xChipPositions ! !

!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/16/2019 17:14:23'!
isOver
	^self hasPlayerXWon or: self hasPlayerOWon! !


!TerniLapilli methodsFor: 'testing' stamp: 'a s 10/10/2019 19:28:26'!
isOAt: aPosition 
	^oChipPositions includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'a s 10/10/2019 19:28:37'!
isXAt: aPosition 
	^xChipPositions includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'a s 10/10/2019 19:28:45'!
numberOfChips
	^oChipPositions size + xChipPositions size! !


!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 19:49:43'!
chipPositions

	^xChipPositions, oChipPositions ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:12:27'!
hasAWinningColumnIn: chipsPositions

	^(chipsPositions collect: [:chipPosition | chipPosition at: 2]) asSet size = 1 ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 17:14:55'!
hasAWinningDiagonalIn: chipsPositions

	^#('a1' 'b2' 'c3') asSet = chipsPositions asSet or: #('c1' 'b2' 'a3') asSet = chipsPositions asSet! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:12:13'!
hasAWinningRowIn: chipsPositions

	^(chipsPositions collect: [:chipPosition | chipPosition at: 1]) asSet size = 1 ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 17:15:15'!
hasEnoughChipsToWinIn: chipPositions

	^chipPositions size = 3 ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 16:48:44'!
hasWonWithChipsIn: chipsPositions

	^(self hasEnoughChipsToWinIn: chipsPositions) and: [
		(self hasAWinningRowIn: chipsPositions ) or:
		(self hasAWinningColumnIn: chipsPositions) or:
		(self hasAWinningDiagonalIn: chipsPositions)
	]! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 16:25:32'!
isInvalidMovementFrom: initialPosition to: nextPosition 
	| initialPositionRow nextPositionRow initialPositionColumn nextPositionColumn movesFromColumnToAnotherColumn movesFromRowToAnotherRow movesFromASideToAnotherSide |
	
	initialPositionRow := initialPosition at: 1.
	nextPositionRow := nextPosition at: 1.
	
	initialPositionColumn := initialPosition at: 2.
	nextPositionColumn := nextPosition at: 2.
	
	movesFromRowToAnotherRow := (Set with: initialPositionColumn with: nextPositionColumn) = #($1 $3) asSet.
	movesFromColumnToAnotherColumn := (Set with: initialPositionRow with: nextPositionRow) = #($a $c) asSet.
	movesFromASideToAnotherSide := (self isPositionASide: initialPosition) and: (self isPositionASide: nextPosition).
	
	^movesFromRowToAnotherRow or: movesFromColumnToAnotherColumn or: movesFromASideToAnotherSide! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 16:47:04'!
isPositionASide: aPosition

	| initialPositionColumn initialPositionRow |
	initialPositionRow := aPosition at: 1.	
	initialPositionColumn := aPosition at: 2.
	
	^ (initialPositionRow = $b and: initialPositionColumn ~= $2) or:
	   (initialPositionColumn = $2 and: initialPositionRow ~= $b)
! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 16:43:34'!
isValid: aPosition

	^aPosition size = 2 and: 
	  (#($a $b $c) includes: (aPosition at: 1)) and: 
	  (#($1 $2 $3) includes: (aPosition at: 2))! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 16:33:27'!
moveChipIn: playerChipPositions from: initialPosition to: nextPosition 
	playerChipPositions size = 3 ifFalse: [self error: self class cantMoveChipsYetErrorDescription].
	(self isValid: nextPosition) ifFalse: [self error: self class unexistingPositionErrorDescription ].
	(self isInvalidMovementFrom: initialPosition to: nextPosition) ifTrue: [self error: self class invalidMovementErrorDescription ].
	
	(playerChipPositions includes: initialPosition ) ifFalse: [self error: self class movingFromInvalidPositionErrorDescription ].
	(self chipPositions includes: nextPosition) ifTrue: [self error: self class positionTakenErrorDescription ].
	
	playerChipPositions remove: initialPosition.
	playerChipPositions add: nextPosition.! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:49:46'!
moveChipWhenOIsPlayingFrom: initialPosition to: nextPostion

	self moveChipIn: oChipPositions from: initialPosition to: nextPostion ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:49:51'!
moveChipWhenXIsPlayingFrom: initialPosition to: nextPostion

	self moveChipIn: xChipPositions from: initialPosition to: nextPostion ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:40:20'!
putChipIn: playerChipPositions at: aPosition
	(self isValid: aPosition ) ifFalse: [self error: self class unexistingPositionErrorDescription ].
	
	self chipPositions detect: [:chipPosition | chipPosition = aPosition ] 
		ifFound: [:chipPosition | self error: self class positionTakenErrorDescription ]
		ifNone: [playerChipPositions add: aPosition].
	
	! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:37:19'!
putChipWhenOIsPlayingOn: aPosition
	
	self putChipIn: oChipPositions at: aPosition ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:37:42'!
putChipWhenXIsPlayingOn: aPosition
	
	self putChipIn: xChipPositions at: aPosition ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/16/2019 18:39:44'!
state
	^TerniLapilliState newForGame: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 19:04:18'!
cantMoveChipsYetErrorDescription
	^'cant move chips before all have been placed'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 18:58:29'!
cantPlaceMoreChipsErrorDescription
	^'player has ran out of chips'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 18:52:32'!
gameIsAlreadyOverErrorDescription
	^'game over'.! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 20:03:19'!
invalidMovementErrorDescription
	^'invalid movement'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 18:21:46'!
invalidTurnErrorDescription
	^'it is not your turn!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 19:21:05'!
movingFromInvalidPositionErrorDescription
	^'cannot move from an invalid position.'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 18:58:58'!
positionTakenErrorDescription
	^'position is already taken'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 17:21:39'!
startNewGame

	^ self new initialize! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ss 10/13/2019 20:27:04'!
unexistingPositionErrorDescription
	^'position does not exists'! !


!classDefinition: #TerniLapilliState category: #'TerniLapilli-Exercise'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'game'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'a s 10/16/2019 18:41:33'!
initializeWith: aGame

	game := aGame! !


!TerniLapilliState methodsFor: 'playing' stamp: 'a s 10/16/2019 18:05:48'!
moveOChipFrom: initialPosition to: nextPosition 

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'playing' stamp: 'a s 10/16/2019 18:05:53'!
moveXChipFrom: initialPosition to: nextPosition 

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'playing' stamp: 'a s 10/16/2019 18:06:23'!
putOAt: aPosition

	self subclassResponsibility! !

!TerniLapilliState methodsFor: 'playing' stamp: 'a s 10/16/2019 18:06:19'!
putXAt: aPosition

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'TerniLapilli-Exercise'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:01:39'!
canHandle: aGame

	self subclassResponsibility! !

!TerniLapilliState class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:45:49'!
doesNotHaveEnoughChipsFor: aGame

	^aGame numberOfChips < 6
	! !

!TerniLapilliState class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:17:10'!
newForGame: aGame

	^ (self subclasses detect: [:aClassToHandle| aClassToHandle canHandle: aGame ]) newForGame: aGame.! !


!classDefinition: #GameOver category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #GameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!GameOver methodsFor: 'playing' stamp: 'a s 10/16/2019 18:25:46'!
moveOChipFrom: initialPosition to: nextPosition 

	self error: game class gameIsAlreadyOverErrorDescription ! !

!GameOver methodsFor: 'playing' stamp: 'a s 10/16/2019 18:25:50'!
moveXChipFrom: initialPosition to: nextPosition 

	self error: game class gameIsAlreadyOverErrorDescription ! !

!GameOver methodsFor: 'playing' stamp: 'a s 10/16/2019 18:26:14'!
putOAt: aPosition

	self error: game class gameIsAlreadyOverErrorDescription ! !

!GameOver methodsFor: 'playing' stamp: 'a s 10/16/2019 18:26:19'!
putXAt: aPosition

	self error: game class gameIsAlreadyOverErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOver class' category: #'TerniLapilli-Exercise'!
GameOver class
	instanceVariableNames: ''!

!GameOver class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:22:46'!
newForGame: aGame
	
	^self new initializeWith: aGame! !


!GameOver class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:09:36'!
canHandle: aGame

	^ aGame isOver! !


!classDefinition: #OIsPlaying category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #OIsPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OIsPlaying methodsFor: 'playing' stamp: 'a s 10/16/2019 18:28:32'!
moveXChipFrom: initialPosition to: nextPosition 

	self error: game class invalidTurnErrorDescription ! !

!OIsPlaying methodsFor: 'playing' stamp: 'a s 10/16/2019 18:28:46'!
putXAt: aPosition

	self error: game class invalidTurnErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsPlaying class' category: #'TerniLapilli-Exercise'!
OIsPlaying class
	instanceVariableNames: ''!

!OIsPlaying class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:10:29'!
canHandle: aGame

	^ aGame isOver not and: aGame isPlayingO! !


!classDefinition: #OHasChipsLeftToPut category: #'TerniLapilli-Exercise'!
OIsPlaying subclass: #OHasChipsLeftToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OHasChipsLeftToPut methodsFor: 'playing' stamp: 'a s 10/16/2019 18:30:53'!
moveOChipFrom: initialPosition to: nextPosition

	self error: game class cantMoveChipsYetErrorDescription ! !

!OHasChipsLeftToPut methodsFor: 'playing' stamp: 'a s 10/16/2019 18:38:34'!
putOAt: aPosition

	game putChipWhenOIsPlayingOn: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OHasChipsLeftToPut class' category: #'TerniLapilli-Exercise'!
OHasChipsLeftToPut class
	instanceVariableNames: ''!

!OHasChipsLeftToPut class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:46:02'!
canHandle: aGame

	^self doesNotHaveEnoughChipsFor: aGame ! !

!OHasChipsLeftToPut class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:23:44'!
newForGame: aGame
	
	^self new initializeWith: aGame! !


!classDefinition: #OHasEnoughChips category: #'TerniLapilli-Exercise'!
OIsPlaying subclass: #OHasEnoughChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!OHasEnoughChips methodsFor: 'playing' stamp: 'a s 10/16/2019 18:48:25'!
moveOChipFrom: initialPosition to: nextPosition

	game moveChipWhenOIsPlayingFrom: initialPosition to: nextPosition! !

!OHasEnoughChips methodsFor: 'playing' stamp: 'a s 10/16/2019 18:32:01'!
putOAt: aPosition

	self error: game class cantPlaceMoreChipsErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OHasEnoughChips class' category: #'TerniLapilli-Exercise'!
OHasEnoughChips class
	instanceVariableNames: ''!

!OHasEnoughChips class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:46:45'!
canHandle: aGame

	^(self doesNotHaveEnoughChipsFor: aGame) not! !

!OHasEnoughChips class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:23:52'!
newForGame: aGame
	
	^self new initializeWith: aGame! !


!classDefinition: #XIsPlaying category: #'TerniLapilli-Exercise'!
TerniLapilliState subclass: #XIsPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XIsPlaying methodsFor: 'playing' stamp: 'a s 10/16/2019 18:29:17'!
moveOChipFrom: initialPosition to: nextPosition 

	self error: game class invalidTurnErrorDescription ! !

!XIsPlaying methodsFor: 'playing' stamp: 'a s 10/16/2019 18:29:00'!
putOAt: aPosition

	self error: game class invalidTurnErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsPlaying class' category: #'TerniLapilli-Exercise'!
XIsPlaying class
	instanceVariableNames: ''!

!XIsPlaying class methodsFor: 'subclass creation' stamp: 'a s 10/16/2019 18:11:16'!
canHandle: aGame

	^ aGame isOver not and: aGame isPlayingX! !


!classDefinition: #XHasChipsLeftToPut category: #'TerniLapilli-Exercise'!
XIsPlaying subclass: #XHasChipsLeftToPut
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XHasChipsLeftToPut methodsFor: 'playing' stamp: 'a s 10/16/2019 18:31:25'!
moveXChipFrom: initialPosition to: nextPosition

	self error: game class cantMoveChipsYetErrorDescription ! !

!XHasChipsLeftToPut methodsFor: 'playing' stamp: 'a s 10/16/2019 18:38:08'!
putXAt: aPosition

	game putChipWhenXIsPlayingOn: aPosition .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XHasChipsLeftToPut class' category: #'TerniLapilli-Exercise'!
XHasChipsLeftToPut class
	instanceVariableNames: ''!

!XHasChipsLeftToPut class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:46:16'!
canHandle: aGame

	^self doesNotHaveEnoughChipsFor: aGame ! !

!XHasChipsLeftToPut class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:24:08'!
newForGame: aGame
	
	^self new initializeWith: aGame! !


!classDefinition: #XHasEnoughChips category: #'TerniLapilli-Exercise'!
XIsPlaying subclass: #XHasEnoughChips
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Exercise'!

!XHasEnoughChips methodsFor: 'playing' stamp: 'a s 10/16/2019 18:48:47'!
moveXChipFrom: initialPosition to: nextPosition

	game moveChipWhenXIsPlayingFrom: initialPosition to: nextPosition! !

!XHasEnoughChips methodsFor: 'playing' stamp: 'a s 10/16/2019 18:32:22'!
putXAt: aPosition

	self error: game class cantPlaceMoreChipsErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XHasEnoughChips class' category: #'TerniLapilli-Exercise'!
XHasEnoughChips class
	instanceVariableNames: ''!

!XHasEnoughChips class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:46:54'!
canHandle: aGame

	^(self doesNotHaveEnoughChipsFor: aGame) not! !

!XHasEnoughChips class methodsFor: 'instance creation' stamp: 'a s 10/16/2019 18:24:00'!
newForGame: aGame
	
	^self new initializeWith: aGame! !
