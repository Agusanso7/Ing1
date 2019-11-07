!classDefinition: #CartTest category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestAPITest category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
TestCase subclass: #RestAPITest
	instanceVariableNames: 'testObjectsFactory restapi'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 19:51:56'!
test01ListCartFailsIfIDDoesNotExist

	self should: [restapi listCartWithID: 'some_invalid_id'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
				self assert: error messageText equals: RestAPI cartNotFoundErrorDescription
			]
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 20:15:40'!
test02CreateCartReturnsIDToListCartThatIsEmpty
	| cartID |
	cartID := self createCart.
	
	self assert: (restapi listCartWithID: cartID) isEmpty.
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 20:17:11'!
test03CreateCartReturnsDifferentIDsForEachCart
	| cartIDs |
	
	cartIDs := Set new.
	
	1 to: 4 do: [:n | cartIDs add: self createCart ].
	
	self assert: cartIDs size equals: 4.
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 19:53:53'!
test04AddToCartFailsIfCartDoesNotExist

	self should: [restapi add: 50 of: 'ISBN131231231' toCartWithID: 'some_invalid_id'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
				self assert: error messageText equals: RestAPI cartNotFoundErrorDescription
			]
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 20:16:40'!
test05CanListItemsAfterAddingToExistingCart
	| cartID cart item |
	
	cartID := self createCart.
	item := testObjectsFactory itemSellByTheStore.

	restapi add: 5 of: item toCartWithID: cartID.
	
	cart := restapi listCartWithID: cartID.
	
	self assert: cart size equals: 5.
	self assert: (cart occurrencesOf: item) equals: 5.	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 20:19:02'!
test06CantCreateCartIfClientDoesNotExist
	
	self should: [restapi createCartForClient: 'fake_user' withPassword: 'invalid_password'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
				self assert: error messageText equals: RestAPI userDoesNotExistErrorDescription.
			]
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/7/2019 20:21:15'!
test07CantCreateCartIfClientPasswordIsIncorrect
	
	self should: [restapi createCartForClient: (testObjectsFactory validUser) withPassword: 'invalid_password'] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error | 
				self assert: error messageText equals: RestAPI incorrectPasswordErrorDescription.
			]
	! !


!RestAPITest methodsFor: 'setUp' stamp: 'ss 11/7/2019 19:51:32'!
setUp 
	
	testObjectsFactory := StoreTestObjectsFactory new.
	
	restapi := testObjectsFactory createRestAPI ! !


!RestAPITest methodsFor: 'support' stamp: 'ss 11/7/2019 20:15:24'!
createCart
	^restapi createCartForClient: testObjectsFactory validUser withPassword: testObjectsFactory validPassword 
! !


!classDefinition: #Cart category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'ss 11/7/2019 20:01:54'!
size
	^items size.! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestAPI category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Object subclass: #RestAPI
	instanceVariableNames: 'catalog cartsByID usersStore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestAPI methodsFor: 'assertions' stamp: 'ss 11/7/2019 20:24:53'!
assert: aUser hasPassword: aPassword 

	usersStore at: aUser 
		ifPresent: [:actualPassword | aPassword = actualPassword ifFalse: [self error: self class incorrectPasswordErrorDescription]] 
		ifAbsent: [self error: self class userDoesNotExistErrorDescription].! !

!RestAPI methodsFor: 'assertions' stamp: 'ss 11/7/2019 20:27:38'!
assertCartExistsWithID: aCartID
	 cartsByID at: aCartID ifAbsent: [self error: self class cartNotFoundErrorDescription].! !


!RestAPI methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:30:59'!
add: anAmount of: anISBN toCartWithID: cartID
	| cart |
	cart := self listCartWithID: cartID.
	
	cart add: anAmount of: anISBN.
	
	cartsByID at: cartID put: cart.! !

!RestAPI methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:36:54'!
createCartForClient: clientID withPassword: password 
	| cartID |
	self assert: clientID hasPassword: password.
	
	cartID := self createNewCartID.
	cartsByID at: cartID put: (Cart acceptingItemsOf: catalog).
	
	^cartID ! !

!RestAPI methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:36:38'!
createNewCartID

	^100000 atRandom.! !

!RestAPI methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:30:49'!
listCartWithID: cartID 
	self assertCartExistsWithID: cartID .
	 ^cartsByID at: cartID! !


!RestAPI methodsFor: 'initialization' stamp: 'ss 11/7/2019 19:46:45'!
initialize

	cartsByID := Dictionary new.! !

!RestAPI methodsFor: 'initialization' stamp: 'ss 11/7/2019 20:05:39'!
initializeNewWithCatalog: aCatalog 
	catalog := aCatalog.! !

!RestAPI methodsFor: 'initialization' stamp: 'ss 11/7/2019 20:13:26'!
initializeNewWithCatalog: aCatalog authenticatingOn: aUsersStore 
	catalog := aCatalog.
	usersStore := aUsersStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestAPI class' category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
RestAPI class
	instanceVariableNames: ''!

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/7/2019 19:30:09'!
cartNotFoundErrorDescription
	^'cart not found'! !


!RestAPI class methodsFor: 'instance creation' stamp: 'ss 11/7/2019 20:05:23'!
newWithCatalog: aCatalog 
	^self new initializeNewWithCatalog: aCatalog! !

!RestAPI class methodsFor: 'instance creation' stamp: 'ss 11/7/2019 20:11:11'!
newWithCatalog: aCatalog authenticatingOn: userStore 
	^self new initializeNewWithCatalog: aCatalog authenticatingOn: userStore. ! !


!RestAPI class methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:23:05'!
incorrectPasswordErrorDescription
	^'password is incorrect'! !

!RestAPI class methodsFor: 'as yet unclassified' stamp: 'ss 11/7/2019 20:20:24'!
userDoesNotExistErrorDescription
	^'user does not exist'! !


!classDefinition: #Sale category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'ss 11/7/2019 20:43:41'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:08:33'!
createRestAPI
	^RestAPI newWithCatalog: self defaultCatalog authenticatingOn: self userStore.! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:09:39'!
userStore

	 ^Dictionary new
		at: self validUser put: self validPassword;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:10:14'!
validPassword
	^'top_secret'! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:10:04'!
validUser
	^'a_valid_user'! !
