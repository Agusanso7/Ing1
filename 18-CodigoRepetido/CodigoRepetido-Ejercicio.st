!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 19:22:57'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertTimeTakenDoing: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: 50*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 19:23:04'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertTimeTakenDoing: [customerBook removeCustomerNamed: paulMcCartney] takesLessThan: 100 * millisecond

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:35:36'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[self assertErrorExistence: [customerBook addCustomerNamed: '']]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:35:45'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ self assertErrorExistence: [customerBook removeCustomerNamed: 'Paul McCartney']]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:46:51'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook 
		hasActiveCustomers: 0 
		suspendedCustomers: 1 
		AndTotal: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:46:25'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBook: customerBook 
		hasActiveCustomers: 0 
		suspendedCustomers: 0 
		AndTotal: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:36:06'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ self assertErrorExistence: [customerBook suspendCustomerNamed: 'Paul McCartney']]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'asd 9/2/2019 20:36:25'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ self assertErrorExistence: [customerBook suspendCustomerNamed: johnLennon]]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'asd 9/2/2019 20:44:49'!
assertCustomerBook: customerBook 
	hasActiveCustomers: activeCustomers 
	suspendedCustomers: suspendedCustomers 
	AndTotal: totalNumberOfCostumers
	
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalNumberOfCostumers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'asd 9/2/2019 20:35:19'!
assertErrorExistence: failingClosure
	^[failingClosure value. self fail] value! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'asd 9/2/2019 19:33:57'!
assertTimeTakenDoing: closureToMeasure takesLessThan: maxTime
	|millisecondsBeforeRunning millisecondsAfterRunning |
	
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closureToMeasure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < maxTime
	! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'asd 9/2/2019 18:45:51'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'asd 9/2/2019 20:38:28'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'asd 9/2/2019 21:16:14'!
removeCustomerNamed: aName 
 	self forCustomer: aName ifNotIncludedIn: active, suspended Do: [^NotFound signal]. 	
	
	self removeCustomerNamed: aName FromCollection: active.
	self removeCustomerNamed: aName FromCollection: suspended.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'asd 9/2/2019 19:09:47'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'asd 9/2/2019 21:16:21'!
suspendCustomerNamed: aName 

	self forCustomer: aName ifNotIncludedIn: active Do: [^CantSuspend signal].
	active remove: aName.
	suspended add: aName.
	
	
! !


!CustomerBook methodsFor: 'private' stamp: 'asd 9/2/2019 21:13:11'!
forCustomer: aName ifNotIncludedIn: customerList Do: aClosure
	(customerList includes: aName) ifFalse: [^aClosure value].! !

!CustomerBook methodsFor: 'private' stamp: 'asd 9/2/2019 20:13:14'!
removeCustomerNamed: aName FromCollection: collection
	1 to: collection size do:  [ :index |
		aName = (collection at: index)
			ifTrue: [
				collection removeAt: index.
				^aName 
			] 
	].
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
