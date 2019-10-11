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

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:11:51'!
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:48:06'!
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

!TerniLapilliTest methodsFor: 'testing' stamp: 'a s 10/10/2019 19:50:46'!
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

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/10/2019 19:50:57'!
putOAt: aPosition
	self isPlayingO ifFalse: [self error: self class invalidTurnErrorDescription ].
	
	self chipPositions detect: [:chipPosition | chipPosition = aPosition ] 
		ifFound: [:chipPosition | self error: self class positionTakenErrorDescription ]
		ifNone: [
			oChipPositions add: aPosition.
			turn := #X.
		].
	
	! !

!TerniLapilli methodsFor: 'playing' stamp: 'a s 10/10/2019 19:50:11'!
putXAt: aPosition
	self isPlayingX ifFalse: [self error: self class invalidTurnErrorDescription ].
	
	self chipPositions detect: [:chipPosition | chipPosition = aPosition ] 
		ifFound: [:chipPosition | self error: self class positionTakenErrorDescription ]
		ifNone: [
			xChipPositions add: aPosition.
			turn := #O.
		].! !


!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/10/2019 21:09:31'!
hasPlayerOWon
	^self hasWonWithChipsIn: oChipPositions ! !

!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/10/2019 21:09:50'!
hasPlayerXWon
	^self hasWonWithChipsIn: xChipPositions ! !

!TerniLapilli methodsFor: 'winning' stamp: 'a s 10/10/2019 21:00:36'!
isOver
	^self hasPlayerXWon or: [self hasPlayerOWon]! !


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

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:14:46'!
hasAWinningDiagonalIn: chipsPositions

	^#('a1' 'b2' 'c3') asSet = chipsPositions asSet or: [#('c1' 'b2' 'a3') asSet = chipsPositions asSet ]! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:12:13'!
hasAWinningRowIn: chipsPositions

	^(chipsPositions collect: [:chipPosition | chipPosition at: 1]) asSet size = 1 ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:11:00'!
hasEnoughChipsToWinIn: chipPositions
	^chipPositions size = 3 ! !

!TerniLapilli methodsFor: 'private' stamp: 'a s 10/10/2019 21:14:46'!
hasWonWithChipsIn: chipsPositions
	^(self hasEnoughChipsToWinIn: chipsPositions) and: [
		(self hasAWinningRowIn: chipsPositions ) or: [
			(self hasAWinningColumnIn: chipsPositions) or: [
				self hasAWinningDiagonalIn: chipsPositions 
			]
		]
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'TerniLapilli-Exercise'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 18:21:46'!
invalidTurnErrorDescription
	^'it is not your turn!!'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 18:58:58'!
positionTakenErrorDescription
	^'position is already taken'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 17:21:39'!
startNewGame

	^ self new initialize! !
