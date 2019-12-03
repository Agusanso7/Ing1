!classDefinition: #Book category: #'TusLibros-Model'!
Object subclass: #Book
	instanceVariableNames: 'name isbn author description price'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Book methodsFor: 'initialization' stamp: 'ss 12/2/2019 20:26:30'!
initializeNamed: aName by: anAuthor withISBN: anISBN withDescription: aDescription withPrice: aPrice

	name := aName.
	author := anAuthor.
	isbn := anISBN.
	description  := aDescription.
	price := aPrice.
	! !


!Book methodsFor: 'accessing' stamp: 'ss 12/2/2019 20:27:33'!
author
	^author! !

!Book methodsFor: 'accessing' stamp: 'ss 12/2/2019 20:27:41'!
description
	^description ! !

!Book methodsFor: 'accessing' stamp: 'ss 12/2/2019 20:27:53'!
isbn
	^isbn ! !

!Book methodsFor: 'accessing' stamp: 'ss 12/2/2019 20:27:28'!
name
	^name! !

!Book methodsFor: 'accessing' stamp: 'ss 12/2/2019 20:26:56'!
price
	^price! !


!Book methodsFor: 'testing' stamp: 'ss 12/2/2019 20:28:39'!
= aBook
	^isbn = aBook isbn! !

!Book methodsFor: 'testing' stamp: 'ss 12/2/2019 20:28:51'!
hash
	^isbn hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Book class' category: #'TusLibros-Model'!
Book class
	instanceVariableNames: ''!

!Book class methodsFor: 'instance creation' stamp: 'ss 12/2/2019 20:26:43'!
named: aName by: anAuthor withISBN: anISBN withDescription: aDescription withPrice: aPrice
	^self new initializeNamed: aName by: anAuthor withISBN: anISBN withDescription: aDescription withPrice: aPrice ! !


!classDefinition: #Cart category: #'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'ss 12/2/2019 20:47:34'!
assertIsValidItem: anItemISBN

	(catalog includesKey: anItemISBN) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'ss 11/25/2019 19:15:35'!
size
	^items size! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !


!Cart methodsFor: 'removing' stamp: 'ss 11/25/2019 19:14:59'!
remove: anItem
	items remove: anItem ifAbsent: [self error: self class itemIsNotInCartErrorDescription].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !

!Cart class methodsFor: 'error messages' stamp: 'ss 11/25/2019 19:12:54'!
itemIsNotInCartErrorDescription
	^'item is not in cart'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'ss 12/2/2019 18:21:51'!
checkOutCartWithCreditCard: aCreditCard

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: aCreditCard
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

!CartSession methodsFor: 'cart' stamp: 'ss 11/25/2019 19:22:51'!
removeFromCart: aBook 
	^cart remove: aBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: #'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ss 12/2/2019 19:38:51'!
registerSale

	salesBook register: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'ss 12/2/2019 20:47:54'!
totalOf: anItemISBN quantity: aQuantity

	^(cart catalog at: anItemISBN) price * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #Clock category: #'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #CreditCard category: #'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'accessing' stamp: 'ss 12/2/2019 18:12:26'!
expiration
	^expiration copy! !

!CreditCard methodsFor: 'accessing' stamp: 'ss 12/2/2019 18:12:18'!
number
	^number copy! !


!CreditCard methodsFor: 'testing' stamp: 'ss 12/2/2019 18:12:02'!
= aCreditCard

	^number = aCreditCard number and: [expiration = aCreditCard expiration].! !

!CreditCard methodsFor: 'testing' stamp: 'ss 12/2/2019 20:29:03'!
hash
	^number hash! !

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'ss 12/2/2019 18:08:23'!
initializeWithNumber: aCreditCardNumber expiringOn: aMonth

	number := aCreditCardNumber.
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ss 12/2/2019 18:06:36'!
withNumber: aCreditCardNumber expiringOn: aMonth

	^self new initializeWithNumber: aCreditCardNumber expiringOn: aMonth! !


!classDefinition: #LineItem category: #'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'ss 12/2/2019 19:14:57'!
quantity

	^ quantity ! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: #'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'ss 11/25/2019 18:57:22'!
debit: anAmount from: aCreditCard

	"self subclassResponsibility" ! !


!classDefinition: #Sale category: #'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #SalesBook category: #'TusLibros-Model'!
Object subclass: #SalesBook
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!SalesBook methodsFor: 'accessing' stamp: 'ss 12/2/2019 19:41:19'!
at: anIndex
	^sales at: anIndex.! !

!SalesBook methodsFor: 'accessing' stamp: 'ss 12/2/2019 19:41:03'!
size
	^sales size! !


!SalesBook methodsFor: 'testing' stamp: 'ss 12/2/2019 19:40:26'!
isEmpty
	^sales isEmpty! !


!SalesBook methodsFor: 'initialization' stamp: 'ss 12/2/2019 19:36:17'!
initialize
	sales := OrderedCollection new.! !


!SalesBook methodsFor: 'registering' stamp: 'ss 12/2/2019 19:38:37'!
register: aSale
	sales add: aSale.! !


!SalesBook methodsFor: 'sales by user' stamp: 'ss 12/2/2019 19:51:22'!
boughtBooksBy: aUser 
	| boughtBooks |
	
	boughtBooks := Set new.
	self lineItemsBy: aUser do: [:aLineItem | boughtBooks add: aLineItem item].
	
	^boughtBooks 
	! !

!SalesBook methodsFor: 'sales by user' stamp: 'ss 12/2/2019 19:52:24'!
lineItemsBy: aUser do: aBlock 
	(self salesBy: aUser) do: [:aSale | aSale lineItemsDo: aBlock]! !

!SalesBook methodsFor: 'sales by user' stamp: 'ss 12/2/2019 19:59:07'!
purchrasesBy: aUser
	|purchrases|

	purchrases := Dictionary new.
	
	(self boughtBooksBy: aUser) do: [:aBook | 
		purchrases at: aBook put: (self purchrasesOf: aBook by: aUser) 
	].

	^purchrases 


	! !

!SalesBook methodsFor: 'sales by user' stamp: 'ss 12/2/2019 19:56:26'!
purchrasesOf: aBook by: aUser 
	| quantity total |
	total := 0.
	quantity := 0.
	
	self lineItemsBy: aUser do: [:aLineItem | 
		aLineItem item = aBook ifTrue: [
			total := total + aLineItem total.
			quantity := quantity + aLineItem quantity .
			]
	].

	^LineItem of: aBook quantity: quantity total: total.! !

!SalesBook methodsFor: 'sales by user' stamp: 'ss 12/2/2019 19:43:56'!
salesBy: aUser

	^sales select: [:aSale | aSale wasDoneBy: aUser]! !


!classDefinition: #Ticket category: #'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosRestAPI category: #'TusLibros-Model'!
Object subclass: #TusLibrosRestAPI
	instanceVariableNames: 'port webserver systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestAPI methodsFor: 'initialization' stamp: 'ss 12/3/2019 18:52:08'!
initializeWith: aPortNumber

	systemFacade := self createSystemFacade.
	
	port:= aPortNumber.
	
	webserver := WebServer new listenOn: aPortNumber.
	
	self setupServices.
	
	
	
	! !


!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 11/25/2019 17:55:00'!
destroy
	
	webserver ifNotNil:[webserver destroy].! !

!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 12/3/2019 18:48:32'!
errorHandlerFor: aRequest

	^ [:anError | | jsonResponse | 
		jsonResponse :=  (WebUtils jsonEncode: (Dictionary new at: 'message' put: anError messageText ; yourself )).
		aRequest send404Response: jsonResponse  
			do: [:resp | resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
	]! !

!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 12/3/2019 18:40:16'!
send200JSONResponse: aBody for: aRequest
	aRequest send200Response: (WebUtils jsonEncode: aBody)
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.]
	
	! !

!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 12/3/2019 18:52:08'!
setupServices

	webserver addService: '/createCart' action: [:request | | cartID  |	
		[
			cartID := systemFacade createCartFor: (request fields at: 'username') authenticatedWith: (request fields at: 'password').
		
			self send200JSONResponse: (Dictionary new at: 'cart_id' put: cartID; yourself ) 
				for: request
		]
		on: Error do: (self errorHandlerFor: request)
	].
	
	webserver addService: '/listCart' action: [:request | | cartContent |	
		cartContent := systemFacade listCartIdentifiedAs: (request fields at: 'id') asInteger .
		
		self send200JSONResponse: cartContent asArray for: request.
	
	].
	
	webserver addService: '/addToCart' action: [:request | |cartContent |	
		systemFacade add: (request fields at: 'quantity') asInteger 
			of: (request fields at: 'isbn') 
			toCartIdentifiedAs: (request fields at: 'cart_id') asInteger. 

		self send200JSONResponse: String new for: request	
	].
	
	webserver addService: '/removeFromCart' action: [:request | |cartContent |
		systemFacade remove: (request fields at: 'isbn')  fromCartIdentifiedAs: (request fields at: 'cart_id') asInteger.

		self send200JSONResponse: String new for: request	

	].
	
	webserver addService: '/listPurchrases' action: [:request | |purchrases |	
		purchrases := systemFacade listPurchasesOf:  (request fields at: 'username') 
			authenticatingWith: (request fields at: 'password').
			
		self send200JSONResponse: (self lineItemsResponse: purchrases values)
			for: request.
	].
	
	webserver addService: '/checkout' action: [:request | |userCreditCard ticket |
		[
			userCreditCard := systemFacade creditCardFor: (request fields at: 'username') 
				authenticatedWith: (request fields at: 'password').
		
		 	ticket := systemFacade checkOutCartIdentifiedAs: (request fields at: 'cart_id') asInteger 
				withCreditCard: userCreditCard.
		
			self send200JSONResponse: (self ticketResponse: ticket)
				 for: request.
		] 
		on: Error do: (self errorHandlerFor: request)
	].
	
	webserver addService: '/catalog' action: [:request |
		self send200JSONResponse:  (self catalogResponse: systemFacade catalog) 
				 for: request 
	]! !

!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 11/25/2019 17:54:30'!
startListening
	
	webserver startListener.

	^ 'Listening on port: ', port asString.! !

!TusLibrosRestAPI methodsFor: 'server' stamp: 'ss 11/25/2019 17:54:46'!
stopListening
	
	webserver stopListener.
	
	^'Stopped listening from port: ',  port asString! !


!TusLibrosRestAPI methodsFor: 'responses' stamp: 'ss 12/2/2019 20:52:06'!
catalogResponse: aCatalog
	| response  |
	
	response := OrderedCollection new.

	aCatalog values do: [:aBook | | bookResponse | 
		bookResponse := Dictionary new.
		
		bookResponse at: 'name' put: aBook name.
		bookResponse at: 'author' put: aBook author .
		bookResponse at: 'isbn' put: aBook isbn .
		bookResponse at: 'description' put: aBook description .
		bookResponse at: 'price' put: aBook price.
		
		response add: bookResponse.
	].
	
	^response asArray
	! !

!TusLibrosRestAPI methodsFor: 'responses' stamp: 'ss 12/2/2019 20:52:15'!
lineItemsResponse: aListOfLineItems
	| lineItemsResponse |
	
	lineItemsResponse := OrderedCollection new.
	
	aListOfLineItems do: [:aLineItem | | lineItemResponse |
		lineItemResponse := Dictionary new.
		
		lineItemResponse at: 'name' put: aLineItem item.
		lineItemResponse at: 'quantity' put: aLineItem quantity .
		lineItemResponse at: 'total' put: aLineItem total.
		
		lineItemsResponse add: lineItemResponse.
	].

	^lineItemsResponse asArray 

	
	! !

!TusLibrosRestAPI methodsFor: 'responses' stamp: 'ss 12/2/2019 20:52:21'!
ticketResponse: aTicket
	| response lineItems |
	
	response := Dictionary new.
	response at: 'total' put: aTicket total.
	
	lineItems := OrderedCollection new.	
	aTicket lineItemsDo: [:aLineItem | lineItems add: aLineItem ].

	response at: 'items' put: (self lineItemsResponse: lineItems) .
	
	^response 
	! !


!TusLibrosRestAPI methodsFor: 'parsing' stamp: 'ss 11/25/2019 18:56:05'!
parseMonthOfYear: aString
	
	| delimiterIndex parsedMonthNumber parsedYearNumber |
	delimiterIndex := aString findDelimiters: '/' startingAt: 1.
	
	parsedMonthNumber := (aString copyFrom: 1 to: delimiterIndex-1) asInteger .
	parsedYearNumber := (aString copyFrom: delimiterIndex+1 to: aString size) asInteger.
	
	^Month  
		month: parsedMonthNumber 
		year: parsedYearNumber 
	
	
	
	! !


!TusLibrosRestAPI methodsFor: 'private' stamp: 'ss 12/2/2019 19:37:07'!
createSalesBook

	^SalesBook new! !

!TusLibrosRestAPI methodsFor: 'private' stamp: 'ss 12/3/2019 18:51:13'!
createSystemFacade

	^ TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: self defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: MerchantProcessor new
		measuringTimeWith: DateAndTime 
		storingCreditCardsOn: self userCreditCard! !

!TusLibrosRestAPI methodsFor: 'private' stamp: 'ss 12/2/2019 20:35:35'!
defaultCatalog

	| aBook anotherBook |
	aBook := Book named: 'the history of books' 
		by: 'booky mcbooks' 
		withISBN: '123' 
		withDescription: 'booky takes us through the history of books'
		withPrice: 550.
	
	anotherBook := Book named: 'who let the books out?'
		by: 'Pages mcbooks' 
		withISBN: '987654' 
		withDescription: 'pages asks important questions such as: who let the books out?'
		withPrice: 314.

	^ Dictionary new
		at: aBook isbn put: aBook;
		at: anotherBook isbn put: anotherBook ;
		yourself ! !

!TusLibrosRestAPI methodsFor: 'private' stamp: 'ss 12/2/2019 18:56:28'!
userCreditCard
	| notExpiredCreditCard today expiredCreditCard |
	
	today := DateAndTime today.
	
	expiredCreditCard :=  CreditCard withNumber: '321321' 
		expiringOn: (Month month: today monthIndex year: today yearNumber -1).
		
	notExpiredCreditCard :=  CreditCard withNumber: '123123' 
		expiringOn:(Month month: today monthIndex year: today yearNumber +1).
	

	^Dictionary new
		at: 'user' put: notExpiredCreditCard;
		at: 'expired' put: expiredCreditCard;
		yourself! !

!TusLibrosRestAPI methodsFor: 'private' stamp: 'ss 12/2/2019 18:32:17'!
validUsersAndPasswords

	^Dictionary new
		at: 'user' put: 'pass';
		at: 'expired' put: 'pass';
		yourself! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestAPI class' category: #'TusLibros-Model'!
TusLibrosRestAPI class
	instanceVariableNames: ''!

!TusLibrosRestAPI class methodsFor: 'instance creation' stamp: 'ss 11/25/2019 17:55:43'!
listeningOn: aPortNumber 
	^self new initializeWith: aPortNumber ! !


!classDefinition: #TusLibrosSystemFacade category: #'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions usersCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'ss 12/2/2019 17:56:07'!
creditCardFor: aUser authenticatedWith: aPassword 
	self if: aUser authenticatesWith: aPassword do: [ 
		^usersCreditCard at: aUser. 
	].! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'accessing' stamp: 'ss 11/25/2019 19:00:55'!
catalog
	^catalog copy! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ss 12/2/2019 19:01:32'!
checkOutCartIdentifiedAs: aCartId withCreditCard: aCreditCard 

	^self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession checkOutCartWithCreditCard: aCreditCard]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ss 12/2/2019 19:49:26'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ salesBook purchrasesBy: aUser ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'ss 11/25/2019 19:21:31'!
remove: aBook fromCartIdentifiedAs: aCartId 
	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeFromCart: aBook]
	! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'ss 12/2/2019 19:34:41'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'ss 12/2/2019 17:58:08'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock 
	storingCreditCardsOn: aUsersCreditCardStore 

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.
	
	usersCreditCard := aUsersCreditCardStore.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: #'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'ss 12/2/2019 17:59:11'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock 
	storingCreditCardsOn: aUsersCreditCardStore 

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock storingCreditCardsOn: aUsersCreditCardStore! !
