!classDefinition: #TusLibrosTest category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 18:46:23'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:11:16'!
createCashier
	
	^Cashier newOn: self date registeringOn: OrderedCollection new.! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:03:35'!
date
	^FixedGregorianDate yearNumber: 2019 month: February dayNumber: 20 ! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:43:22'!
defaultCatalog
	
	| catalog |
	
	catalog := Dictionary new.
	catalog at: self itemSellByTheStore put: self priceOfItemSellByTheStore.
	
	^catalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:36:21'!
expiredCreditCard
	^CreditCard withNumber: 1231231 
		name: 'hola' 
		expiration: (GregorianMonthOfYear yearNumber: 2018 month: December). ! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 18:46:42'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 18:47:02'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:41:46'!
priceOfItemSellByTheStore
	
	^200 * peso! !

!TusLibrosTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:36:15'!
validCreditCard

	^CreditCard withNumber: 1231231 
		name: 'hola' 
		expiration: (GregorianMonthOfYear yearNumber: 2019 month: December).! !


!classDefinition: #CartTest category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
TusLibrosTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'a s 11/4/2019 20:47:23'!
test09EmptyCartHasAPriceOf0

	| cart |
	
	cart := self createCart.
	
	self assert: cart price equals: 0! !

!CartTest methodsFor: 'tests' stamp: 'a s 11/4/2019 20:48:16'!
test10CartPriceIsTheSumOfTheItemsPrice

	| cart |
	
	cart := self createCart.
	
	cart add: 5 of: self itemSellByTheStore.
	
	self assert: cart price equals: 5*self priceOfItemSellByTheStore ! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'a s 11/4/2019 20:54:43'!
assertOn: aLedger at: anIndex wasSold: anItem withAmount: anAmount 
	| ledgerEntry |
	
	ledgerEntry := aLedger at: anIndex.

	self assert: (ledgerEntry at: 1) equals: anItem.
	self assert: (ledgerEntry at: 2) equals: anAmount.
	! !


!CashierTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:09:47'!
test01CantCheckoutEmptyCart
	
	| emptyCart cashier |
	emptyCart := self createCart. 
	cashier := self createCashier.

	self should: [cashier checkoutCart: emptyCart withCreditCard: self validCreditCard]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:error | 
			self assert: error messageText equals: Cashier cantCheckoutEmptyCartErrorDescription.
			self assert: cashier ledger isEmpty 
	]! !

!CashierTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:56:22'!
test02CheckoutCartWithOneItemSavesCartSoldItemsInLedger
	
	| aCart aCashier |
	
	aCart := self createCart.
	aCart add: 2 of: self itemSellByTheStore.
	 
	aCashier := self createCashier.
	aCashier checkoutCart: aCart withCreditCard: self validCreditCard.
	
	self assertOn: aCashier ledger at: 1 wasSold: self itemSellByTheStore withAmount: 2! !

!CashierTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:09:25'!
test03CantCheckoutWithExpiredCreditCard
	
	| aCart aCashier |
	
	aCart := self createCart.
	aCart add: self itemSellByTheStore.
	 
	aCashier := self createCashier.
	self should: [aCashier checkoutCart: aCart withCreditCard: self expiredCreditCard] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: Cashier expiredCreditCardErrorDescription.
			self assert: aCashier ledger isEmpty 
		].
	
	! !


!classDefinition: #CreditCardTest category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
TusLibrosTest subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:04:46'!
test01CreditCardIsExpiredIfItReachedExpirationDate
	| aCreditCard |
	
	aCreditCard := self expiredCreditCard.
	
	self assert: (aCreditCard isExpiredFrom: self date). ! !

!CreditCardTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:04:56'!
test02CreditCardIsNotExpiredIfItHasNotReachedExpiration
	| aCreditCard |
	
	aCreditCard := self validCreditCard .
	
	self deny: (aCreditCard isExpiredFrom: self date). ! !

!CreditCardTest methodsFor: 'testing' stamp: 'a s 11/4/2019 20:33:38'!
test03CreditCardIsNotValidIfNameContainsNumbers

	self should: [CreditCard withNumber: 123 name: '123' expiration: self date monthOfYear ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: CreditCard invalidNameErrorDescription
			]! !


!classDefinition: #Cart category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'a s 11/4/2019 20:43:50'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'a s 11/4/2019 21:13:47'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'a s 11/4/2019 20:48:54'!
price
	^items sum: [:item | self priceOf: item] ifEmpty: [0] ! !

!Cart methodsFor: 'queries' stamp: 'a s 11/4/2019 20:49:17'!
priceOf: anItem
	^catalog at: anItem ! !

!Cart methodsFor: 'queries' stamp: 'a s 11/4/2019 21:18:21'!
uniqueItemsDo: aBlock
	items asSet do: aBlock! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
Object subclass: #Cashier
	instanceVariableNames: 'ledger date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout' stamp: 'a s 11/4/2019 21:20:51'!
checkoutCart: aCart withCreditCard: aCreditCard
	aCart isEmpty ifTrue: [self error: self class cantCheckoutEmptyCartErrorDescription].
	(aCreditCard isExpiredFrom: date) ifTrue: [self error: self class expiredCreditCardErrorDescription ].

	self recordSalesOnLedgerFor: aCart ! !


!Cashier methodsFor: 'initialization' stamp: 'a s 11/4/2019 20:10:36'!
initializeOn: aDate registeringOn: aLedger
	date := aDate.
	ledger := aLedger 
	
	! !


!Cashier methodsFor: 'private' stamp: 'a s 11/4/2019 21:20:41'!
recordSalesOnLedgerFor: aCart

	aCart  uniqueItemsDo: [:item | | occurrencesOfItem |
		occurrencesOfItem := aCart occurrencesOf: item.
		ledger add: (Array with: item with: occurrencesOfItem)
	]! !


!Cashier methodsFor: 'accessing' stamp: 'a s 11/4/2019 20:10:54'!
ledger 
	^ledger copy
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error descriptions' stamp: 'a s 11/4/2019 18:51:16'!
cantCheckoutEmptyCartErrorDescription
	^'cant checkout empty cart'! !

!Cashier class methodsFor: 'error descriptions' stamp: 'a s 11/4/2019 19:35:33'!
expiredCreditCardErrorDescription
	^'credit card is expired'! !


!Cashier class methodsFor: 'instance creation' stamp: 'a s 11/4/2019 20:10:18'!
newOn: aDate registeringOn: aLedger
	^self new initializeOn: aDate registeringOn: aLedger.! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
Object subclass: #CreditCard
	instanceVariableNames: 'number name expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'a s 11/4/2019 19:41:02'!
initializeWithNumber: aNumber name: aName expiration: anExpiration 
	number := aNumber.
	name := aName.
	expiration := anExpiration.! !


!CreditCard methodsFor: 'validation' stamp: 'a s 11/4/2019 20:01:45'!
isExpiredFrom: aDate
	^expiration < (aDate monthOfYear) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'a s 11/4/2019 21:22:25'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'a s 11/4/2019 20:35:52'!
withNumber: aNumber name: aName expiration: anExpiration 
	(self validName: aName) ifFalse: [self error: self invalidNameErrorDescription ].
	
	^self new initializeWithNumber: aNumber name: aName expiration: anExpiration ! !


!CreditCard class methodsFor: 'error descriptions' stamp: 'a s 11/4/2019 20:34:00'!
invalidNameErrorDescription
	^'invalid name'! !


!CreditCard class methodsFor: 'validating' stamp: 'a s 11/4/2019 20:35:18'!
validName: aName
	^aName allSatisfy: [:aChar | aChar isLetter].! !
