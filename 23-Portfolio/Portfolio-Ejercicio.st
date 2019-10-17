!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 18:51:35'!
test01PortfolioHasEmptyBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 18:51:21'!
test02PortfolioWithOneAccountHasAccountBalance

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account. 
	
	portfolio add: account.
	
	self assert: portfolio balance equals: account balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 18:54:29'!
test03PortfolioWithMultipleAccountsHasBalanceSum

	| portfolio account1 account2 account3 |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Deposit register: 100 on: account2. 
	Deposit register: 100 on: account3. 
	
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	
	self assert: portfolio balance equals: 300.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:00:38'!
test04PortfolioHasNoTransactionWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:08:06'!
test05PortfolioHasAllAccountsTransactions

	| portfolio account1 account2 account3 transaction1 transaction2 transaction3 transactions |
	
	portfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	transaction1 := Deposit register: 100 on: account1.
	transaction2 := Deposit register: 100 on: account2. 
	transaction3 := Deposit register: 100 on: account3. 
	
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	
	transactions := portfolio transactions.
	
	self assert: transactions size equals: 3.
	self assert: transactions includes: transaction1.
	self assert: transactions includes: transaction2.
	self assert: transactions includes: transaction3.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:10:55'!
test06PortfolioDoesNotRegisterTransactionOfAccountsThatItDoesNotOwn

	| portfolio account transaction |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account. 
	
	self assert: (portfolio hasRegistered: transaction) not.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:11:52'!
test07PortfolioHasRegisteredTransactionOfAccountsThatItDoesOwn

	| portfolio account transaction |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 100 on: account. 
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:31:25'!
test08PortfolioCantHaveTheSameAccountMoreThanOnce

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new. 
	
	portfolio add: account.
	Deposit register: 100 on: account.

	self should: [portfolio add: account ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
				self assert: exception messageText equals: Portfolio accountAlreadyExistsErrorDescription.
				self assert: portfolio balance equals: 100
			]! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:34:05'!
test09PortfolioWithEmptyPortfolioHasSameBalance

	| account portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new. 
	
	portfolio2 add: account.
	Deposit register: 100 on: account.
	
	portfolio1 add: portfolio2.
	
	self assert: portfolio1 balance equals: 100
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'a s 10/17/2019 19:54:11'!
test10PortfolioCantHaveAPortfolioWithAnAccountItAlreadyHas

	| account portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new. 
	
	Deposit register: 100 on: account.
	
	portfolio1 add: account.
	portfolio2 add: account.
	
	self should: [portfolio1 add: portfolio2 ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
				self assert: exception messageText equals: Portfolio accountAlreadyExistsErrorDescription.
				self assert: portfolio1 balance equals: 100
			]
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

!Deposit methodsFor: 'value' stamp: 'a s 10/17/2019 19:28:00'!
valueForBalance

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'a s 10/17/2019 18:29:38'!
value

	^ value! !

!Withdraw methodsFor: 'value' stamp: 'a s 10/17/2019 19:28:10'!
valueForBalance

	^ value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinantialEntity category: #'Portfolio-Ejercicio'!
Object subclass: #FinantialEntity
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinantialEntity methodsFor: 'balance' stamp: 'a s 10/17/2019 19:40:44'!
balance
	self subclassResponsibility ! !


!FinantialEntity methodsFor: 'testing' stamp: 'a s 10/17/2019 19:40:56'!
hasRegistered: aTransaction
	self subclassResponsibility ! !


!FinantialEntity methodsFor: 'transactions' stamp: 'a s 10/17/2019 19:40:47'!
transactions
	self subclassResponsibility ! !


!FinantialEntity methodsFor: 'private' stamp: 'a s 10/17/2019 19:43:25'!
accountTree
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinantialEntity subclass: #Portfolio
	instanceVariableNames: 'finantialEntities'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'a s 10/17/2019 18:57:03'!
balance
	
	^finantialEntities sum: [:aFinantialEntity | aFinantialEntity balance] ifEmpty: [^0]! !


!Portfolio methodsFor: 'initialization' stamp: 'a s 10/17/2019 18:55:20'!
initialize

	finantialEntities := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'a s 10/17/2019 19:07:36'!
transactions

	^(finantialEntities collect: [:aFinantialEntity | aFinantialEntity transactions ]) flatten! !


!Portfolio methodsFor: 'testing' stamp: 'a s 10/17/2019 19:59:28'!
hasNoRepeatedAccountsFor: aFinantialEntity
	^(self accountTree intersection: aFinantialEntity accountTree) isEmpty
	! !

!Portfolio methodsFor: 'testing' stamp: 'a s 10/17/2019 19:12:16'!
hasRegistered: aTransaction 

	^self transactions includes: aTransaction ! !


!Portfolio methodsFor: 'content' stamp: 'a s 10/17/2019 19:59:12'!
add: aFinantialEntity

	(self hasNoRepeatedAccountsFor: aFinantialEntity) ifFalse: [self error: self class accountAlreadyExistsErrorDescription ].
	finantialEntities add: aFinantialEntity ! !


!Portfolio methodsFor: 'private' stamp: 'a s 10/17/2019 19:51:40'!
accountTree
	^finantialEntities collect: [:aFinantialEntity | aFinantialEntity accountTree] 
		andFold: [:leftTree :rightTree | leftTree, rightTree ]  
		ifEmpty: [OrderedCollection new]. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error descriptions' stamp: 'a s 10/17/2019 19:18:40'!
accountAlreadyExistsErrorDescription
	^'account already exists'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinantialEntity subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'a s 10/17/2019 19:27:44'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueForBalance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'a s 10/17/2019 19:44:55'!
accountTree
	^OrderedCollection with: self! !
