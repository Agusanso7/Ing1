!classDefinition: #CartTest category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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


!classDefinition: #CashierTest category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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


!CashierTest methodsFor: 'merchant processor behaviour' stamp: 'ss 11/11/2019 18:18:41'!
debitBehaviour: aBlock

	debitBehavior  := aBlock! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestAPITest category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
TestCase subclass: #RestAPITest
	instanceVariableNames: 'testObjectsFactory restapi merchantProcessorMock presentTime'
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

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 17:57:38'!
test08ListPurchrasesBeginsEmptyWhenRestAPIIsCreated
	
	| purchrasesByClient |
	purchrasesByClient :=  restapi listPurchrasesMadeByClient: testObjectsFactory validUser 
		withPassword: testObjectsFactory validPassword.
	
	self assert: purchrasesByClient isEmpty! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 19:02:15'!
test09CheckoutMakesPaymentAndAddsPurchrases
	| purchrasesByClient aCartID |
	
	aCartID := self createCart.
	
	restapi add: 2 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.
	
	restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard .
	
	purchrasesByClient :=  restapi listPurchrasesMadeByClient: testObjectsFactory validUser 
		withPassword: testObjectsFactory validPassword.
	
	self assert: purchrasesByClient size equals: 2.
	self assert: (purchrasesByClient occurrencesOf: testObjectsFactory itemSellByTheStore ) equals: 2. 	
	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 19:06:49'!
test10CheckoutFailsIfCartDoesNotExist

	self should: [restapi checkout: '0' with: testObjectsFactory notExpiredCreditCard] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI cartNotFoundErrorDescription. 
			self assert: restapi salesBook isEmpty.
		]  .	
	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 19:10:58'!
test11CheckoutFailsIfCartIsEmpty
	| aCartID |
	aCartID := self createCart.

	self should: [restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI cartIsEmptyErrorDescription. 
			self assert: restapi salesBook isEmpty.
		]  .	
	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 19:30:31'!
test12CheckoutDebitsTheAmountOfthePurchrase
	| aCartID debittedAmount debittedCard creditCard |
	
	aCartID := self createCart.
	creditCard := testObjectsFactory notExpiredCreditCard.
	
	restapi add: 1 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.
	
	merchantProcessorMock debitBehaviour: [:amount :card | 
		debittedAmount := amount.
		debittedCard := card.
	].
	
	restapi checkout: aCartID with: creditCard.
	
	self assert: debittedAmount equals: testObjectsFactory itemSellByTheStorePrice .
	self assert: debittedCard equals: creditCard .


	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 21:05:14'!
test13CheckoutACartTwiceFails
	| aCartID |
	
	aCartID := self createCart.
	
	restapi add: 1 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.
	
	restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard .
	
	self should: [restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard .] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI sessionIsNotActiveErrorDescription.
			self assert: restapi salesBook size equals: 1.
			]


	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 21:05:14'!
test14AddToCartAfterCheckoutFails
	| aCartID |
	
	aCartID := self createCart.
	
	restapi add: 1 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.
	
	restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard .
	
	self should: [restapi add: 1 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI sessionIsNotActiveErrorDescription.
			self assert: restapi salesBook size equals: 1.
			]


	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 21:05:14'!
test15ListCartFailsIfCartIsDisabled
	| aCartID |
	
	aCartID := self createCart.
	
	restapi add: 1 of: testObjectsFactory itemSellByTheStore toCartWithID: aCartID.
	
	restapi checkout: aCartID with: testObjectsFactory notExpiredCreditCard .
	
	self should: [restapi listCartWithID: aCartID ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI sessionIsNotActiveErrorDescription.
			self assert: restapi salesBook size equals: 1.
			]


	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 21:20:16'!
test16CantListCartAfter30MinutesOfInactivity
	| aCartID |
	
	aCartID := self createCart.
	self advanceTime30Minutes .
	
	self should: [restapi listCartWithID: aCartID ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:error |
			self assert: error messageText equals: RestAPI sessionIsNotActiveErrorDescription.
						]


	
	
	! !

!RestAPITest methodsFor: 'testing' stamp: 'ss 11/11/2019 21:32:07'!
test17ListRefreshesCartLifetime
	| aCartID |
	
	aCartID := self createCart.
	self advanceTime15Minutes .
	
	restapi listCartWithID: aCartID.
	
	self advanceTime15Minutes .
	
	self deny: (restapi listCartWithID: aCartID) isNil



	

	
	
	! !


!RestAPITest methodsFor: 'setUp' stamp: 'ss 11/11/2019 21:16:30'!
setUp 
	
	testObjectsFactory := StoreTestObjectsFactory new.
	
	merchantProcessorMock := CashierTest new.
	merchantProcessorMock debitBehaviour: [:amount :card | ].
	
	restapi := RestAPI newWithCatalog: testObjectsFactory defaultCatalog 
		authenticatingOn: testObjectsFactory userStore 
		sendingPaymentsTo: merchantProcessorMock
		withTimeProvider: self.
		
	presentTime := DateAndTime now.! !


!RestAPITest methodsFor: 'time provider protocol' stamp: 'ss 11/11/2019 21:15:57'!
now
	^presentTime! !


!RestAPITest methodsFor: 'support' stamp: 'ss 11/11/2019 21:29:18'!
advanceTime15Minutes
	presentTime := presentTime + (Duration minutes: 15)! !

!RestAPITest methodsFor: 'support' stamp: 'ss 11/11/2019 21:18:27'!
advanceTime30Minutes
	presentTime := presentTime + (Duration minutes: 30)! !

!RestAPITest methodsFor: 'support' stamp: 'ss 11/7/2019 20:15:24'!
createCart
	^restapi createCartForClient: testObjectsFactory validUser withPassword: testObjectsFactory validPassword 
! !


!classDefinition: #Cart category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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


!Cart methodsFor: 'as yet unclassified' stamp: 'ss 11/11/2019 18:56:46'!
itemsDo: aBlockClosure 
	
	items do: [:item | aBlockClosure value: item].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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


!classDefinition: #CreditCard category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #RestAPI category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
Object subclass: #RestAPI
	instanceVariableNames: 'catalog usersStore merchantProcessor purchrasesByClient salesBook sessions timeProvider'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestAPI methodsFor: 'assertions' stamp: 'ss 11/7/2019 20:24:53'!
assert: aUser hasPassword: aPassword 

	usersStore at: aUser 
		ifPresent: [:actualPassword | aPassword = actualPassword ifFalse: [self error: self class incorrectPasswordErrorDescription]] 
		ifAbsent: [self error: self class userDoesNotExistErrorDescription].! !

!RestAPI methodsFor: 'assertions' stamp: 'ss 11/11/2019 21:23:43'!
assertSessionIsActive: aSession

	(aSession isActiveOn: self now) ifFalse: [self error: self class sessionIsNotActiveErrorDescription ]! !


!RestAPI methodsFor: 'private' stamp: 'ss 11/11/2019 21:23:54'!
now
	^timeProvider now! !

!RestAPI methodsFor: 'private' stamp: 'ss 11/11/2019 21:33:56'!
sessionWithCartID: aCartID
	| session |
	
	session := sessions detect: [:aSession | aSession cartID = aCartID ] ifNone: [self error: self class cartNotFoundErrorDescription ].
		
	self assertSessionIsActive: session.
	
	^session.! !


!RestAPI methodsFor: 'protocol' stamp: 'ss 11/11/2019 20:24:37'!
add: anAmount of: anISBN toCartWithID: cartID
	| cart |
	cart := self listCartWithID: cartID.
	
	cart add: anAmount of: anISBN.! !

!RestAPI methodsFor: 'protocol' stamp: 'ss 11/11/2019 21:06:23'!
checkout: cartID with: aCreditCard 

	| session purchrases |
	
	session := self sessionWithCartID: cartID.
	session cart isEmpty ifTrue: [self error: self class cartIsEmptyErrorDescription].
	
	(Cashier
		toCheckout: session cart 
		charging: aCreditCard 
		throught: merchantProcessor 
		on: DateAndTime now 
		registeringOn: salesBook) checkOut.
	
	purchrases := purchrasesByClient at: session ownerID ifAbsentPut: [Bag new].
	session cart itemsDo: [:item | purchrases add: item].
	
	session disable.! !

!RestAPI methodsFor: 'protocol' stamp: 'ss 11/11/2019 21:24:07'!
createCartForClient: clientID withPassword: password 
	| cart session |
	self assert: clientID hasPassword: password.
	
	cart :=  Cart acceptingItemsOf: catalog.
	session := Session fromOwner: clientID withCart: cart withCurrentTime: self now.
	
	sessions add: session.
		
	^session cartID . ! !

!RestAPI methodsFor: 'protocol' stamp: 'ss 11/11/2019 21:31:09'!
listCartWithID: cartID 	
	 | session |
	
	session := (self sessionWithCartID: cartID).
	
	session refreshActivityAt: self now.
	
	^session cart.! !

!RestAPI methodsFor: 'protocol' stamp: 'ss 11/11/2019 18:58:06'!
listPurchrasesMadeByClient: clientID withPassword: password 
	self assert: clientID hasPassword: password.
	
	^purchrasesByClient at: clientID ifAbsent: [Bag new]. 
	! !


!RestAPI methodsFor: 'testing' stamp: 'ss 11/11/2019 19:48:50'!
salesBook
	^salesBook copy.! !


!RestAPI methodsFor: 'initialization' stamp: 'ss 11/11/2019 21:14:18'!
initializeNewWithCatalog: aCatalog authenticatingOn: aUsersStore sendingPaymentsTo: aMerchantProcessor withTimeProvider: aTimeProvider
	catalog := aCatalog.
	usersStore := aUsersStore.
	merchantProcessor := aMerchantProcessor.
	purchrasesByClient  := Dictionary  new.
	salesBook  := OrderedCollection new.
	sessions := OrderedCollection new.
	timeProvider := aTimeProvider.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestAPI class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
RestAPI class
	instanceVariableNames: ''!

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/11/2019 19:10:28'!
cartIsEmptyErrorDescription
	^'cart is empty'! !

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/7/2019 19:30:09'!
cartNotFoundErrorDescription
	^'cart not found'! !

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/7/2019 20:23:05'!
incorrectPasswordErrorDescription
	^'password is incorrect'! !

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/11/2019 21:05:14'!
sessionIsNotActiveErrorDescription
	^'session is not active'! !

!RestAPI class methodsFor: 'error descriptions' stamp: 'ss 11/7/2019 20:20:24'!
userDoesNotExistErrorDescription
	^'user does not exist'! !


!RestAPI class methodsFor: 'instance creation' stamp: 'ss 11/11/2019 21:13:42'!
newWithCatalog: aCatalog authenticatingOn: userStore sendingPaymentsTo: aMerchantProcessor withTimeProvider: aTimeProvider

	^self new 
		initializeNewWithCatalog: aCatalog 
		authenticatingOn: userStore 
		sendingPaymentsTo: aMerchantProcessor 
		withTimeProvider: aTimeProvider.! !


!classDefinition: #Sale category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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

!classDefinition: 'Sale class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #Session category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
Object subclass: #Session
	instanceVariableNames: 'cart ownerID disabled cartID lastActivity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Session methodsFor: 'testing' stamp: 'ss 11/11/2019 21:26:51'!
isActiveOn: aTime
	^disabled not and: [(aTime - lastActivity) minutes < 30].! !


!Session methodsFor: 'accessing' stamp: 'ss 11/11/2019 20:00:43'!
cart
	^cart! !

!Session methodsFor: 'accessing' stamp: 'ss 11/11/2019 20:58:16'!
cartID
	^cartID! !

!Session methodsFor: 'accessing' stamp: 'ss 11/11/2019 20:01:09'!
id
	^id! !

!Session methodsFor: 'accessing' stamp: 'ss 11/11/2019 20:00:56'!
ownerID
	^ownerID! !


!Session methodsFor: 'initialization' stamp: 'ss 11/11/2019 21:20:59'!
initializeWithOwner: aClientID withCart: aCart WithCartID: aCartID withCurrentTime: aTime	
	cart := aCart.
	cartID := aCartID.
	ownerID  := aClientID.
	lastActivity := aTime.
	disabled := false.! !


!Session methodsFor: 'disabling' stamp: 'ss 11/11/2019 20:12:06'!
disable
	disabled := true! !


!Session methodsFor: 'as yet unclassified' stamp: 'ss 11/11/2019 21:31:35'!
refreshActivityAt: aTime 
	lastActivity := aTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Session class' category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
Session class
	instanceVariableNames: ''!

!Session class methodsFor: 'instance creation' stamp: 'ss 11/11/2019 21:21:20'!
fromOwner: aClientID withCart: aCart  withCurrentTime: aTime

	^self new initializeWithOwner: aClientID withCart: aCart WithCartID: self generateCartID withCurrentTime: aTime.! !

!Session class methodsFor: 'instance creation' stamp: 'ss 11/11/2019 20:17:56'!
generateCartID
	^100000 atRandom.! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'ss 11/11/2019 21:35:23'!
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


!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/11/2019 18:32:13'!
anotherUser
	^'another_valid_user'! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/11/2019 18:32:27'!
userStore

	 ^Dictionary new
		at: self validUser put: self validPassword;
		at: self anotherUser put: self validPassword;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:10:14'!
validPassword
	^'top_secret'! !

!StoreTestObjectsFactory methodsFor: 'REST API' stamp: 'ss 11/7/2019 20:10:04'!
validUser
	^'a_valid_user'! !
