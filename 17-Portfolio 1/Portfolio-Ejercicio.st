!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:15:52'!
test01portfolioHasZeroBalanceWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:17:31'!
test02portfolioHasNoneTransactionsWhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions equals: OrderedCollection new.

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:18:46'!
test03portfolioHasBalanceEqualsToSumOfAccountsBalance

	| portfolio account anotherAccount |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	portfolio add: account.
	portfolio add: anotherAccount.
	
	Deposit register: 30 on: anotherAccount.

	self assert: (account balance + anotherAccount balance) equals: portfolio balance.
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 00:18:20'!
test04portfolioTransactionsEqualsToAllAccountsTransactions

	| portfolio account anotherAccount aDeposit aWithdraw anotherDeposit |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	aDeposit := Deposit register: 100 on: account.
	aWithdraw := Withdraw register: 50 on: account.
		
	portfolio add: account.
	portfolio add: anotherAccount.
	
	anotherDeposit := Deposit register: 30 on: anotherAccount.
		
	self assert: portfolio transactions size equals: 3.
	self assert: portfolio transactions includes: aDeposit.
	self assert: portfolio transactions includes: aWithdraw.
	self assert: portfolio transactions includes: anotherDeposit.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:24:15'!
test05portfolioKnowsRegisteredTransactionsInAccounts

	| portfolio account anotherAccount deposit1 deposit2 withdraw |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	deposit1 := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	portfolio add: account.
	portfolio add: anotherAccount.
	
	deposit2 := Deposit register: 30 on: anotherAccount.
		
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: withdraw).

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:23:53'!
test06portfolioDoesNotKnowNotRegisteredTransactionsInAccounts

	| deposit withdraw portfolio |
	
	portfolio := Portfolio new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered:withdraw).

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 17:46:53'!
test07portfolioOnlyAcceptsValidReceptiveAccounts

	| portfolio |
	
	portfolio := Portfolio new.

	self should: [ portfolio add: 'invalid account' ] 
		raise: Error
		withExceptionDo: [ :error | self assert: error class equals: MessageNotUnderstood ] 	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 15:08:11'!
test08portolioDoesNotAcceptsDuplicatedAccounts

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.

	portfolio add: account.
	
	self should: [ portfolio add: account ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Portfolio financialAccountAlreadyExistsDescription  ] 	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/23/2021 18:27:14'!
test09portfolioHasBalanceEqualsToBalancesOfPortfoliosAndAccounts

	| portfolio childPortfolio account anotherAccount|
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.

	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	anotherAccount := ReceptiveAccount new.
	Deposit register: 90 on: anotherAccount.

	childPortfolio add: account.
	portfolio add: childPortfolio.
	portfolio add: anotherAccount.
	
	self assert: portfolio balance equals: (account balance + anotherAccount balance).	
		

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 00:17:17'!
test10portfolioTransactionsEqualsToTransactionsOfPortfoliosAndAccounts

	| portfolio childPortfolio account anotherAccount aDeposit aWithdraw anotherDeposit |
	
	portfolio := Portfolio new.
	childPortfolio := Portfolio new.

	account := ReceptiveAccount new.
	aDeposit := Deposit register: 100 on: account.
	aWithdraw := Withdraw register: 50 on: account.
	
	anotherAccount := ReceptiveAccount new.
	anotherDeposit := Deposit register: 90 on: anotherAccount.

	childPortfolio add: account.
	portfolio add: childPortfolio.
	portfolio add: anotherAccount.
	
	self assert: portfolio transactions size equals: 3.
	self assert: portfolio transactions includes: aDeposit.
	self assert: portfolio transactions includes: aWithdraw.
	self assert: portfolio transactions includes: anotherDeposit.
		

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 15:24:20'!
test11portfolioOnlyAcceptsValidPortfolios

	| portfolio |
	
	portfolio := Portfolio new.

	self should: [ portfolio add: 'invalid portfolio' ] 
		raise: Error
		withExceptionDo: [ :error | self assert: error class equals: MessageNotUnderstood ] 	

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 15:24:31'!
test12portfolioDoesNotAcceptsDuplicatedPortfolios

	| portfolio anotherPortfolio |
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.

	portfolio add: anotherPortfolio.

	self should: [ portfolio add: anotherPortfolio ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Portfolio financialAccountAlreadyExistsDescription  ] 

	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jn 5/24/2021 15:27:32'!
test13portfolioDoesNotAcceptsDuplicatedAccountingsRecursively

	| portfolio1 portfolio2 portfolio3 portfolio4 account anotherAccount |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account := ReceptiveAccount new.
	anotherAccount := ReceptiveAccount new.

	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	portfolio2 add: account.
	portfolio4 add: anotherAccount.
	
	portfolio1 add: portfolio2.
	portfolio3 add: portfolio4.
	portfolio3 add: portfolio2.

	self should: [ 	portfolio1 add: portfolio3. ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Portfolio financialAccountAlreadyExistsDescription  ].
	
	self should: [ 		portfolio3 add: anotherAccount ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Portfolio financialAccountAlreadyExistsDescription  ]


	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'jn 5/17/2021 21:55:54'!
addToBalance: aBalance 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'jn 5/17/2021 21:50:40'!
addToBalance: aBalance

	^ aBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'jn 5/17/2021 21:45:23'!
addToBalance: aBalance

	^ aBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAccount category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAccount methodsFor: 'transactions' stamp: 'jn 5/24/2021 00:28:06'!
transactions

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'testing' stamp: 'jn 5/24/2021 00:29:15'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'balance' stamp: 'jn 5/24/2021 00:28:29'!
balance

	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'initialization' stamp: 'jn 5/24/2021 00:40:40'!
initialize
	
	self subclassResponsibility ! !


!FinancialAccount methodsFor: 'private' stamp: 'jn 5/24/2021 15:07:47'!
addToPortfolio: aPortfolio

	aPortfolio addFinancialAccount: self.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #Portfolio
	instanceVariableNames: 'parents financialAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'jn 5/24/2021 15:23:13'!
initialize
	
	financialAccounts := Set new.	
	parents := Set new.
! !


!Portfolio methodsFor: 'balance' stamp: 'jn 5/24/2021 14:35:32'!
balance

	^ financialAccounts sum: [:accounting | accounting balance ] ifEmpty: [0].! !


!Portfolio methodsFor: 'transactions' stamp: 'jn 5/24/2021 14:36:00'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	financialAccounts do: [:accounting | transactions addAll: accounting transactions].
	^transactions copy.! !


!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/23/2021 19:01:30'!
addParent: aParentPortfolio 
	
	parents add: aParentPortfolio.
! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:16:49'!
hasAnyDuplicatedWith: aFinancialAccountToAdd
	parents isEmpty 
		ifTrue: [ ^ self hasDuplicatesWith: aFinancialAccountToAdd ]
		ifFalse:[ ^ parents anySatisfy: [ :aPortfolio | aPortfolio hasAnyDuplicatedWith: aFinancialAccountToAdd ]]
! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:18:47'!
hasDuplicatesWith: aFinancialAccountToAdd
	(aFinancialAccountToAdd relatedWith: self)
		ifTrue: [ ^ true ]
		ifFalse:[ ^ financialAccounts anySatisfy: [ :aFinancialAccount | 
				aFinancialAccount hasDuplicatesWith: aFinancialAccountToAdd ]].! !

!Portfolio methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:21:17'!
relatedWith: aFinancialAccount
	(self = aFinancialAccount)
		ifTrue: [ ^ true ]
		ifFalse:[ ^ financialAccounts anySatisfy: [ :aFinancialAccountToAdd | 
				aFinancialAccountToAdd relatedWith: aFinancialAccount ]].
! !


!Portfolio methodsFor: 'error' stamp: 'jn 5/24/2021 15:08:52'!
financialAccountAlreadyExistsInPortfolio

	self error: self class financialAccountAlreadyExistsDescription ! !


!Portfolio methodsFor: 'private' stamp: 'jn 5/24/2021 15:20:10'!
addFinancialAccount: aFinancialAccountToAdd
	
	(self hasAnyDuplicatedWith: aFinancialAccountToAdd) 
		ifTrue: [ self financialAccountAlreadyExistsInPortfolio ] 
		ifFalse: [ 
			financialAccounts add: aFinancialAccountToAdd. 
			aFinancialAccountToAdd addParent: self.
		]
! !


!Portfolio methodsFor: 'add' stamp: 'jn 5/24/2021 00:47:29'!
add: anAccounting 
	
	anAccounting addToPortfolio: self.
! !


!Portfolio methodsFor: 'testing' stamp: 'jn 5/23/2021 17:13:23'!
hasRegistered: aTransaction 
	
	^ self transactions includes: aTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'jn 5/24/2021 15:08:11'!
financialAccountAlreadyExistsDescription 
	
	^'Portfolio already exists in portfolio.'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jn 5/24/2021 02:04:22'!
initialize

	transactions := OrderedCollection new.
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jn 5/17/2021 21:57:24'!
balance
	| totalBalance |
	totalBalance := 0.
	transactions do: [:aTransaction |  totalBalance := aTransaction addToBalance: totalBalance ].
	
	^totalBalance.
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:20:43'!
addParent: aParentPortfolio

	! !

!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:19:39'!
hasDuplicatesWith: aFinancialAccount

	^ aFinancialAccount relatedWith: self
		! !

!ReceptiveAccount methodsFor: 'duplicated - private' stamp: 'jn 5/24/2021 15:19:13'!
relatedWith: aFinancialAccount
	
	^ self = aFinancialAccount
! !
