!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'a s 9/16/2019 21:06:29'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentences matchingPrefix nonMatchingPrefix emptyStack loadedStack matchingSentences nonMatchingSentences allSentences prefixWithSpaces emptyPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:04:40'!
test01FindWithEmptyStackDoesNotMatchAnything! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 18:57:38'!
test02FindWithLoadedStackReturnsMatchingSentences! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:01:52'!
test03FindWithLoadedStackDoesNotReturnNonMatchingSentences! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:02:13'!
test04FindWithEmptyStackDoesNotChangeTheStack! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:02:24'!
test05FindWithLoadedStackDoesNotChangeTheStack! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:03:06'!
test06FindWithEmptyPrefixFails! !

!SentenceFinderByPrefixTest methodsFor: 'testing' stamp: 'ss 9/18/2019 19:03:19'!
test07FindWithPrefixIncludingSpacesFails! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'ss 9/18/2019 19:04:09'!
setUp

	matchingSentences := OrderedCollection new.
	
	matchingSentences addLast: 'the first sentence'.
	
	matchingSentences addLast: 'the second sentence'.
	
	matchingSentences addLast: 'the many sentence?'.
	
	
	nonMatchingSentences := OrderedCollection new.
		
	nonMatchingSentences addLast: 'this sentence does not match'.
	
	nonMatchingSentences addLast: 'this sentence does not match either'.
	
	
	allSentences := OrderedCollection new.
	allSentences addAll: nonMatchingSentences.
	allSentences addAll: matchingSentences.
	
	matchingPrefix := 'the'.
	
	nonMatchingPrefix := 'nope'.
	
	prefixWithSpaces := 's p a c e s'.

	emptyPrefix := ''.
	
	emptyStack := OOStack new.
	
	loadedStack := OOStack new.
	allSentences do: [:sentence | loadedStack push: sentence].! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'currentStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'a s 9/16/2019 21:08:45'!
isEmpty

	^currentStackElement amountOfElements = 0! !

!OOStack methodsFor: 'accesing' stamp: 'a s 9/16/2019 21:01:42'!
size

	^currentStackElement amountOfElements ! !

!OOStack methodsFor: 'accesing' stamp: 'a s 9/16/2019 21:02:11'!
top

	^currentStackElement value! !


!OOStack methodsFor: 'removing' stamp: 'a s 9/16/2019 21:12:52'!
pop
	|currentStackElementValue|

	currentStackElementValue := currentStackElement value.
	currentStackElement := currentStackElement remove.
	^currentStackElementValue.! !


!OOStack methodsFor: 'initialization' stamp: 'a s 9/16/2019 20:57:53'!
initialize

	currentStackElement := BottomStackElement new! !


!OOStack methodsFor: 'adding' stamp: 'a s 9/16/2019 21:01:12'!
push: anElementToPush

	currentStackElement := currentStackElement addOnTop: anElementToPush ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackToSearch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'ss 9/18/2019 19:07:28'!
find: prefix
	|matchingSentences allSentences|
	
	prefix isEmpty ifTrue: [self error: self class emptyPrefixErrorDescription].
	(prefix includes: ' ') ifTrue: [self error: self class emptyPrefixErrorDescription].

	allSentences  := OrderedCollection new.	
	matchingSentences  := OrderedCollection new.

	[stackToSearch isEmpty ] whileFalse: [
		|topSentence|
		topSentence := stackToSearch pop.
		allSentences addFirst: topSentence.
		(topSentence beginsWith: prefix) ifTrue: [matchingSentences addLast: topSentence]. 
	].

	allSentences do: [ :sentence | stackToSearch push: sentence ].

	^matchingSentences.
	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'a s 9/16/2019 21:22:07'!
initializeWithStack: aStackToSearch

	stackToSearch := aStackToSearch 

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'a s 9/16/2019 21:21:11'!
newWithStack: aStack

	self new initializeWithStack: aStack! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ss 9/18/2019 19:09:37'!
emptyPrefixErrorDescription

	^'prefix cannot be empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'ss 9/18/2019 19:09:50'!
prefixWithSpacesErrorDescription

	^'prefix cannot contain spaces'! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #BottomStackElement category: #'Stack-Exercise'!
StackElement subclass: #BottomStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BottomStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 21:04:17'!
addOnTop: aNewValue

	^TopStackElement newWithValue: aNewValue AndWithPreviousElement: self! !

!BottomStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 20:53:46'!
amountOfElements
	
	^0! !

!BottomStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 21:13:54'!
remove
	
	self error: OOStack stackEmptyErrorDescription! !

!BottomStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 21:14:03'!
value
	
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #TopStackElement category: #'Stack-Exercise'!
StackElement subclass: #TopStackElement
	instanceVariableNames: 'value previousElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!TopStackElement methodsFor: 'initialization' stamp: 'a s 9/16/2019 20:48:14'!
initializeWithValue: aValue AndWithPreviousElement: thePreviousElement

	previousElement := thePreviousElement.
	value := aValue.! !


!TopStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 21:04:49'!
addOnTop: aNewValue

	^self class newWithValue: aNewValue AndWithPreviousElement: self! !

!TopStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 21:06:54'!
amountOfElements
	
	^previousElement amountOfElements + 1! !

!TopStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 20:51:09'!
remove

	^previousElement 	! !

!TopStackElement methodsFor: 'as yet unclassified' stamp: 'a s 9/16/2019 20:49:49'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TopStackElement class' category: #'Stack-Exercise'!
TopStackElement class
	instanceVariableNames: ''!

!TopStackElement class methodsFor: 'initialization' stamp: 'a s 9/16/2019 21:03:29'!
newWithValue: aValue AndWithPreviousElement: previousElement

	^self new initializeWithValue: aValue AndWithPreviousElement: previousElement ! !
