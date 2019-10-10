!classDefinition: #MarsRoverTest category: #'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:21:10'!
test01roverStaysInSamePositionWhenThereAreNoMovements

	| marsRover |
	
	marsRover := MarsRover newAt: 0@0 withOrientation: self north.
	
	marsRover do: ''.
	
	self assert: marsRover position equals: 0@0.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:21:45'!
test02RoverStaysInSamePositionWhenIntialPositionChanges

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: ''.
	
	self assert: marsRover position equals: 1@1.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:22:14'!
test03RoverMovesForward

	| marsRover |
	
	marsRover := MarsRover newAt: 0@0 withOrientation: self north.
	
	marsRover do: 'f'.
	
	self assert: marsRover position equals: 0@1.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:22:22'!
test04RoverMovesBackwards

	| marsRover |
	
	marsRover := MarsRover newAt: 0@0 withOrientation: self north.
	
	marsRover do: 'b'.
	
	self assert: marsRover position equals: 0@-1.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:22:41'!
test05RoverEndsInSamePositionWhenMovingBackAndForth

	| marsRover |
	
	marsRover := MarsRover newAt: 0@0 withOrientation: self north.
	
	marsRover do: 'bf'.
	
	self assert: marsRover position equals: 0@0.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:23:21'!
test06RoverMovesBackwardFromAnotherInitialPosition
	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'b'.
	
	self assert: marsRover position equals: 1@0.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:24:11'!
test07RoverEndsInSamePlaceWhenMovingBackAndForthFromAnotherPosition

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'bf'.
	
	self assert: marsRover position equals: 1@1.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:25:20'!
test08RoverAdvancesOnePositionAfterMovingBackAndForth

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'bff'.
	
	self assert: marsRover position equals: 1@2.! !

!MarsRoverTest methodsFor: 'testing movement' stamp: 'a s 10/9/2019 19:25:38'!
test09RoverRetrocedesOnePositionAfterMovingBackAndForth

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'bbf'.
	
	self assert: marsRover position equals: 1@0.! !


!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:26:30'!
test10RoverMovesToTheRightAfterRotatingRight

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'rf'.
	
	self assert: marsRover position equals: 2@1.! !

!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:27:06'!
test11RoverMovesDownAfterRotatingTwiceToTheRight

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'rrf'.

	self assert: marsRover position equals: 1@0.! !

!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:27:44'!
test12RoverMovesLeftAfterRotatingThriceToTheRight

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'rrrf'.

	self assert: marsRover position equals: 0@1.! !

!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:28:39'!
test13RoverMovesUpAfterRotatingFourTimeToTheRight

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'rrrrf'.

	self assert: marsRover position equals: 1@2.! !

!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:29:00'!
test14RoverMovesLeftAfterRotatingToTheLeft

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'lf'.

	self assert: marsRover position equals: 0@1.! !

!MarsRoverTest methodsFor: 'testing rotation' stamp: 'a s 10/9/2019 19:29:24'!
test15RoverMovesDiownAfterRotatingTwiceToTheLeft

	| marsRover |
	
	marsRover := MarsRover newAt: 1@1 withOrientation: self north.
	
	marsRover do: 'llf'.

	self assert: marsRover position equals: 1@0.! !


!MarsRoverTest methodsFor: 'orientations' stamp: 'a s 10/9/2019 18:42:34'!
east
	^East new! !

!MarsRoverTest methodsFor: 'orientations' stamp: 'a s 10/9/2019 18:42:28'!
north
	^North new! !

!MarsRoverTest methodsFor: 'orientations' stamp: 'a s 10/9/2019 18:42:52'!
south
	^South new! !

!MarsRoverTest methodsFor: 'orientations' stamp: 'a s 10/9/2019 18:42:42'!
west
	^West new! !


!MarsRoverTest methodsFor: 'testing invalid' stamp: 'a s 10/10/2019 16:50:27'!
test16invalidMoveError

	| marsRover |
	
	marsRover := MarsRover newAt: 0@0 withOrientation: self east.

	self should: [marsRover do: 'fasdfs'] raise: Error description: MarsRover invalidSequenceOfMoverErrorDescription.
! !


!classDefinition: #MarsRover category: #'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation singleActionForMove'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'private' stamp: 'a s 10/9/2019 19:13:21'!
doSingleMove: aMove
	(self singleActionForMove at: aMove) value! !

!MarsRover methodsFor: 'private' stamp: 'a s 10/10/2019 16:45:22'!
isInvalidSequenceOfMoves: aSecuenceOfMoves

	aSecuenceOfMoves do: [:aMove | (self isValidSingleMove: aMove) ifFalse: [^true]. ].
	^false
	! !

!MarsRover methodsFor: 'private' stamp: 'a s 10/10/2019 16:46:45'!
isValidSingleMove: aMove

	^ aMove=$f or: aMove=$b or: aMove=$r or: aMove=$l! !

!MarsRover methodsFor: 'private' stamp: 'a s 10/9/2019 19:11:24'!
singleActionForMove
	singleActionForMove ifNil: [
		singleActionForMove := Dictionary new.
		singleActionForMove at: $f put: [orientation moveForward: self].
		singleActionForMove at: $b put: [orientation moveBackwards: self].
		singleActionForMove at: $l put: [orientation := orientation left].
		singleActionForMove at: $r put: [orientation := orientation right].	
	].
	^singleActionForMove.! !


!MarsRover methodsFor: 'moving' stamp: 'a s 10/10/2019 16:45:30'!
do: aSecuenceOfMoves

	(self isInvalidSequenceOfMoves: aSecuenceOfMoves) ifTrue: [self error: self class invalidSequenceOfMoverErrorDescription].

	aSecuenceOfMoves do: [ :aMove | self doSingleMove: aMove].
! !


!MarsRover methodsFor: 'accessing' stamp: 'a s 10/7/2019 17:27:43'!
position

	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'a s 10/9/2019 18:15:22'!
initializeAt: aPosition withOrientation: anOrientation
	position := aPosition. 
	orientation := anOrientation
	! !


!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:54:16'!
moveBackwardsToEast
	position := position - (1@0)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:54:33'!
moveBackwardsToNorth
	position := position - (0@1)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:54:46'!
moveBackwardsToSouth
	position := position + (0@1)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:54:57'!
moveBackwardsToWest
	position := position + (1@0)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:50:51'!
moveForwardToEast
	position := position + (1@0)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:51:00'!
moveForwardToNorth
	position := position + (0@1)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:51:17'!
moveForwardToSouth
	position := position - (0@1)! !

!MarsRover methodsFor: 'private movements' stamp: 'a s 10/9/2019 18:51:09'!
moveForwardToWest
	position := position - (1@0)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'a s 10/10/2019 16:15:39'!
invalidSequenceOfMoverErrorDescription
	^ 'The sequence of moves is invalid !!!!'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'a s 10/9/2019 18:59:32'!
newAt: aPosition withOrientation: anOrientation
	
	^ self new initializeAt: aPosition withOrientation: anOrientation.! !


!classDefinition: #Orientation category: #'MarsRover-Exercise'!
Object subclass: #Orientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:35:13'!
= anObject
	self class = anObject class! !

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:35:53'!
hash
	self class printString hash! !

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:40:40'!
isEast
	^self class = East! !

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:40:19'!
isNorth
	^self class = North! !

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:40:26'!
isSouth
	^self class = South! !

!Orientation methodsFor: 'testing' stamp: 'a s 10/9/2019 18:40:34'!
isWest
	^self class = West! !


!Orientation methodsFor: 'movement' stamp: 'a s 10/9/2019 18:52:55'!
moveBackwards: roverToMove
	self subclassResponsibility ! !

!Orientation methodsFor: 'movement' stamp: 'a s 10/9/2019 18:52:41'!
moveForward: roverToMove
	self subclassResponsibility ! !


!Orientation methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:46:09'!
left
	self subclassResponsibility ! !

!Orientation methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:34:46'!
right
	self subclassResponsibility ! !


!classDefinition: #East category: #'MarsRover-Exercise'!
Orientation subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'movement' stamp: 'a s 10/9/2019 18:53:15'!
moveBackwards: roverToMove
	roverToMove moveBackwardsToEast.! !

!East methodsFor: 'movement' stamp: 'a s 10/9/2019 18:49:40'!
moveForward: roverToMove
	roverToMove moveForwardToEast.! !


!East methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:46:21'!
left
	^North new! !

!East methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:36:28'!
right
	^South new! !


!classDefinition: #North category: #'MarsRover-Exercise'!
Orientation subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'movement' stamp: 'a s 10/9/2019 18:53:27'!
moveBackwards: roverToMove
	roverToMove moveBackwardsToNorth.! !

!North methodsFor: 'movement' stamp: 'a s 10/9/2019 18:49:58'!
moveForward: roverToMove
	roverToMove moveForwardToNorth.! !


!North methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:46:32'!
left
	^West new! !

!North methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:36:41'!
right
	^East new! !


!classDefinition: #South category: #'MarsRover-Exercise'!
Orientation subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'movement' stamp: 'a s 10/9/2019 18:53:36'!
moveBackwards: roverToMove
	roverToMove moveBackwardsToSouth.! !

!South methodsFor: 'movement' stamp: 'a s 10/9/2019 18:50:08'!
moveForward: roverToMove
	roverToMove moveForwardToSouth.! !


!South methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:46:45'!
left
	^East new! !

!South methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:36:59'!
right
	^West new! !


!classDefinition: #West category: #'MarsRover-Exercise'!
Orientation subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:46:54'!
left
	^South new! !

!West methodsFor: 'rotating' stamp: 'a s 10/9/2019 18:37:08'!
right
	^North new! !


!West methodsFor: 'movement' stamp: 'a s 10/9/2019 18:53:45'!
moveBackwards: roverToMove
	roverToMove moveBackwardsToWest.! !

!West methodsFor: 'movement' stamp: 'a s 10/9/2019 18:50:15'!
moveForward: roverToMove
	roverToMove moveForwardToWest.! !
