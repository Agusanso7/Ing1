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


!classDefinition: #ReportTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReportTest methodsFor: 'testing - Transfer Net' stamp: 'a s 10/21/2019 21:17:07'!
test01TransferNetOfEmptyAccountIs0

	| account generatedReport |
	account := ReceptiveAccount new.
	
	generatedReport := TransferNet generateStringFor: account.
	
	self assert: generatedReport equals: 'Balance neto por transferencias = 0'.! !

!ReportTest methodsFor: 'testing - Transfer Net' stamp: 'a s 10/21/2019 21:17:12'!
test02TransferNetIsEntryTransactionSum
	| generatedReport destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 30 on: originAccount.
	Transference from: originAccount to: destinationAccount of: 10.
	Transference from: originAccount to: destinationAccount of: 10.
	Transference from: originAccount to: destinationAccount of: 10.
	
	
	generatedReport := TransferNet generateStringFor: destinationAccount .
	
	self assert: generatedReport equals: 'Balance neto por transferencias = 30'

	! !

!ReportTest methodsFor: 'testing - Transfer Net' stamp: 'a s 10/21/2019 21:19:53'!
test03TransferNetIsEntryTransactionSumMinusExitTransactions
	| generatedReport destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 30 on: originAccount.
	Transference from: originAccount to: destinationAccount of: 10.
	Transference from: originAccount to: destinationAccount of: 10.
	Transference from: originAccount to: destinationAccount of: 10.
	Transference from: destinationAccount to: originAccount of: 10.
	
	
	generatedReport := TransferNet generateStringFor: destinationAccount .
	
	self assert: generatedReport equals: 'Balance neto por transferencias = 20'

	! !


!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 20:25:57'!
test01AccountReportForEmptyAccountPrintsBalance0

	| account generatedReport |
	
	account := ReceptiveAccount new.
	generatedReport := AccountReport generateStringFor: account.
	
	self assert: generatedReport equals: 'Balance = 0.'.! !

!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 20:26:43'!
test02AccountReportPrintDepositsAndBalance

	| account generatedReport |
	
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	
	generatedReport := AccountReport generateStringFor: account.
	
	self assert: generatedReport equals: 'Deposito por 10. Balance = 10.'.! !

!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 20:28:15'!
test03AccountReportPrintSeveralDepositsAndBalance

	| account generatedReport |
	
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	Deposit register: 20 on: account.
	Deposit register: 30 on: account.
	
	generatedReport := AccountReport generateStringFor: account.
	
	self assert: generatedReport equals: 'Deposito por 10. Deposito por 20. Deposito por 30. Balance = 60.'.! !

!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 20:33:32'!
test04AccountReportPrintsWithdraws

	| account generatedReport |
	
	account := ReceptiveAccount new.
	Deposit register: 20 on: account.
	Withdraw register: 15 on: account.
	
	generatedReport := AccountReport generateStringFor: account.
	
	self assert: generatedReport equals: 'Deposito por 20. Extraccion por 15. Balance = 5.'.! !

!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 20:36:48'!
test05AccountReportPrintsTransferenceEntry

	| generatedReport destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 20 on: originAccount.
	Transference from: originAccount to: destinationAccount of: 20.
	
	
	generatedReport := AccountReport generateStringFor: destinationAccount .
	
	self assert: generatedReport equals: 'Entrada por transferencia de 20. Balance = 20.'.! !

!ReportTest methodsFor: 'testing - Account Report' stamp: 'a s 10/21/2019 21:19:41'!
test06AccountReportPrintsTransferenceExit

	| generatedReport destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 20 on: originAccount.
	Transference from: originAccount to: destinationAccount of: 20.
	
	
	generatedReport := AccountReport generateStringFor: originAccount .
	
	self assert: generatedReport equals: 'Deposito por 20. Salida por transferencia de 20. Balance = 0.'.! !


!classDefinition: #TransferenceTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceTest methodsFor: 'testing' stamp: 'a s 10/21/2019 19:58:46'!
test01TransferenceMustHavePositiveAmount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: originAccount.
	
	self should: [Transference from: originAccount to: destinationAccount of: -1] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Transference valueMustBePositiveErrorDescription.
			self assert: originAccount balance equals: 100. 
			self assert: destinationAccount balance equals: 0.
			]
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'a s 10/21/2019 19:58:52'!
test02TransferenceOriginMustHaveEnoughFunds

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: originAccount.
	
	self should: [Transference from: originAccount to: destinationAccount of: 200] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: error messageText equals: Transference originAccountDoesNotHaveEnoughFunds.
			self assert: originAccount balance equals: 100. 
			self assert: destinationAccount balance equals: 0.
			]
	! !

!TransferenceTest methodsFor: 'testing' stamp: 'a s 10/21/2019 19:58:57'!
test03TransferenceRemoveAmountFromOriginAndAddsItToDestination

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	
	Deposit register: 100 on: originAccount.

	Transference from: originAccount to: destinationAccount of: 100.
	
	self assert: originAccount balance equals: 0. 
	self assert: destinationAccount balance equals: 100
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


!AccountTransaction methodsFor: 'report' stamp: 'a s 10/21/2019 20:56:15'!
reportTransactionTo: aReport
	self subclassResponsibility! !

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


!Deposit methodsFor: 'report' stamp: 'a s 10/21/2019 20:55:09'!
reportTransactionTo: aReport
	^aReport reportAsDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferenceTransaction category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #TransferenceTransaction
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceTransaction methodsFor: 'initialization' stamp: 'a s 10/21/2019 19:52:49'!
initializeWith: aTransference

	transference := aTransference ! !


!TransferenceTransaction methodsFor: 'value' stamp: 'a s 10/21/2019 20:38:03'!
value
	^transference value! !

!TransferenceTransaction methodsFor: 'value' stamp: 'a s 10/21/2019 19:53:08'!
valueForBalance
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferenceTransaction class' category: #'Portfolio-Ejercicio'!
TransferenceTransaction class
	instanceVariableNames: ''!

!TransferenceTransaction class methodsFor: 'as yet unclassified' stamp: 'a s 10/21/2019 19:54:22'!
from: aTransference 
	^self new initializeWith: aTransference ! !


!classDefinition: #TransferenceEntry category: #'Portfolio-Ejercicio'!
TransferenceTransaction subclass: #TransferenceEntry
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceEntry methodsFor: 'value' stamp: 'a s 10/21/2019 20:38:10'!
valueForBalance
	^self value! !


!TransferenceEntry methodsFor: 'report' stamp: 'a s 10/21/2019 20:55:16'!
reportTransactionTo: aReport
	^aReport reportAsTransferenceEntry: self.! !


!classDefinition: #TransferenceExit category: #'Portfolio-Ejercicio'!
TransferenceTransaction subclass: #TransferenceExit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferenceExit methodsFor: 'value' stamp: 'a s 10/21/2019 20:38:15'!
valueForBalance
	^self value negated ! !


!TransferenceExit methodsFor: 'report' stamp: 'a s 10/21/2019 20:55:22'!
reportTransactionTo: aReport
	^aReport reportAsTransferenceExit: self.! !


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


!Withdraw methodsFor: 'report' stamp: 'a s 10/21/2019 20:55:26'!
reportTransactionTo: aReport
	^aReport reportAsWithdraw: self.! !

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


!classDefinition: #Report category: #'Portfolio-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Report methodsFor: 'initialization' stamp: 'a s 10/21/2019 21:02:40'!
initializeFor: anAccount

	account := anAccount! !


!Report methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:05:06'!
reportAsDeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:05:28'!
reportAsTransferenceEntry: aTransferenceEntry
	self subclassResponsibility ! !

!Report methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:05:35'!
reportAsTransferenceExit: aTransferenceExit
	self subclassResponsibility ! !

!Report methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:05:16'!
reportAsWithdraw: aWithdraw
	self subclassResponsibility ! !


!Report methodsFor: 'report' stamp: 'a s 10/21/2019 21:04:47'!
generate
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'Portfolio-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'a s 10/21/2019 21:02:51'!
generateStringFor: anAccount
	| report |
	report := self new initializeFor: anAccount.
	
	^report generate! !


!classDefinition: #AccountReport category: #'Portfolio-Ejercicio'!
Report subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountReport methodsFor: 'report' stamp: 'a s 10/21/2019 20:59:38'!
generate
	| generatedReport |
	
	generatedReport := account transactions inject: '' into: [:partialReport :transaction | partialReport, (self reportLineFor: transaction)].
	
	generatedReport := generatedReport, 'Balance = ', account balance asString , '.'.
	
	^generatedReport 
	
	
	! !


!AccountReport methodsFor: 'private' stamp: 'a s 10/21/2019 20:59:18'!
reportLineFor: aTransaction
	^(aTransaction reportTransactionTo: self), ' ', aTransaction value asString, '. '! !


!AccountReport methodsFor: 'report transactions' stamp: 'a s 10/21/2019 20:57:28'!
reportAsDeposit: aDeposit

	^ 'Deposito por'! !

!AccountReport methodsFor: 'report transactions' stamp: 'a s 10/21/2019 20:57:33'!
reportAsTransferenceEntry: aTransferenceEntry

	^ 'Entrada por transferencia de'! !

!AccountReport methodsFor: 'report transactions' stamp: 'a s 10/21/2019 20:57:41'!
reportAsTransferenceExit: aTransferenceExit

	^ 'Salida por transferencia de'! !

!AccountReport methodsFor: 'report transactions' stamp: 'a s 10/21/2019 20:57:46'!
reportAsWithdraw: aWithdraw

	^ 'Extraccion por'! !


!classDefinition: #TransferNet category: #'Portfolio-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransferNet methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:16:18'!
reportADeposit: aDeposit
	^0! !

!TransferNet methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:16:30'!
reportAWithdraw: aWithdraw
	^0! !

!TransferNet methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:15:58'!
reportAsTransferenceEntry: aTransferenceEntry
	^aTransferenceEntry value! !

!TransferNet methodsFor: 'report transactions' stamp: 'a s 10/21/2019 21:19:11'!
reportAsTransferenceExit: aTransferenceExit
	^aTransferenceExit value negated ! !


!TransferNet methodsFor: 'report' stamp: 'a s 10/21/2019 21:17:47'!
generate
	| netBalance |
	
	netBalance := account transactions sum: [:transaction |
		transaction reportTransactionTo: self	
	] ifEmpty: [0].

	^'Balance neto por transferencias = ', netBalance asString! !


!classDefinition: #Transference category: #'Portfolio-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'entryTransaction exitTransaction value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'a s 10/21/2019 19:57:54'!
initializeWithOrigin: originAccount destination: destinationAccount andValue: aValue

	aValue positive ifFalse: [self error: self class valueMustBePositiveErrorDescription].
	originAccount balance >= aValue ifFalse: [self error: self class originAccountDoesNotHaveEnoughFunds ].
	
	entryTransaction := TransferenceEntry from: self.
	exitTransaction := TransferenceExit from: self.
	
	value := aValue ! !


!Transference methodsFor: 'transactions' stamp: 'a s 10/21/2019 19:50:30'!
entryTransaction
	^entryTransaction ! !

!Transference methodsFor: 'transactions' stamp: 'a s 10/21/2019 19:50:37'!
exitTransaction
	^exitTransaction ! !


!Transference methodsFor: 'value' stamp: 'a s 10/21/2019 19:58:08'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'Portfolio-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'a s 10/21/2019 19:57:25'!
from: originAccount to: destinationAccount of: aValue 
	| transference |
	
	transference := self new initializeWithOrigin: originAccount destination: destinationAccount andValue: aValue.
	originAccount register: transference exitTransaction.
	destinationAccount register: transference entryTransaction.
	
	^transference! !


!Transference class methodsFor: 'error descriptions' stamp: 'a s 10/21/2019 19:24:35'!
originAccountDoesNotHaveEnoughFunds
	^'origin account does not have enough funds'! !

!Transference class methodsFor: 'error descriptions' stamp: 'a s 10/21/2019 19:56:35'!
valueMustBePositiveErrorDescription
	^'value must be positive'! !
