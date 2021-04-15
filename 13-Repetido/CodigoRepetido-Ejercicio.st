!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 14:59:23'!
assertTimeToRun: aClosure withLessThan: someTimeInMilliseconds
	
	self assert: ((self timeToRun: aClosure ) < (someTimeInMilliseconds * millisecond))
	
! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/14/2021 17:04:00'!
do: aClosure thenSuspendCustomer: aCustomerName thenCheckIfSuspended: anotherCustomerName

	| customerBook |
	
	customerBook := aClosure value.
	
	self  ifClosureEvaluation: [ customerBook suspendCustomerNamed: aCustomerName. ] 
		raisesError: CantSuspend
		thenExecute: [ :anError | 
						self assert: (customerBook numberOfCustomers = 1
							   and: (customerBook includesCustomerNamed: anotherCustomerName)) ]! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 15:19:27'!
georgeHarrison 
	^'George Harrison'! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 13:39:24'!
getCurrentTimeInMilliseconds
	
	^ Time millisecondClockValue * millisecond.! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 14:46:25'!
ifClosureEvaluation: aClosureEvaluation raisesError: raiseError thenExecute: aClosureExecution

	[ aClosureEvaluation value . 
	self fail ]
		on: raiseError
		do: aClosureExecution! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 15:19:13'!
johnLennon 
	^'John Lennon'! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/14/2021 17:25:48'!
newCustomerBookThen: aClosure
	| customerBook |
	
	customerBook := CustomerBook new.
	
	^aClosure value: customerBook! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/14/2021 17:29:44'!
newCustomerBookWithCustomer: aCustomerName
	^self newCustomerBookThen: [ :aCustomerBook | aCustomerBook addCustomerNamed: aCustomerName ]! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 15:08:14'!
newCustomerBookWithCustomer: aCustomerName then: aClosure

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomer: aCustomerName.
	aClosure value: customerBook .! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/14/2021 17:29:07'!
newCustomerBookWithCustomerSuspended: aCustomerName
	^ ( self newCustomerBookWithCustomer: aCustomerName ) suspendCustomerNamed: aCustomerName! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 16:08:16'!
newCustomerBookWithCustomerSuspended: aCustomerName then: aClosure hasActiveCustomers: activeValue hasSuspendedCustomers: suspendedValue hasCustomers: customersValue andAssert: anAssertingClosure
	| customerBook | 
	
	customerBook := self newCustomerBookWithCustomerSuspended: aCustomerName.
	aClosure value: customerBook.	
	
	self assert: ((activeValue = customerBook numberOfActiveCustomers)
		   and: (suspendedValue = customerBook numberOfSuspendedCustomers)
		   and: (customersValue = customerBook numberOfCustomers)
		   and: (anAssertingClosure value:(customerBook includesCustomerNamed: aCustomerName)))
	! !

!CustomerBookTest methodsFor: 'methods' stamp: 'jn 4/15/2021 15:10:01'!
paulMcCartney 
	^'Paul McCartney'! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:04:01'!
timeToRun: aClosure

	| millisecondsBeforeRunning millisecondsAfterRunning |
	  
	millisecondsBeforeRunning := self getCurrentTimeInMilliseconds .
	aClosure value.
	millisecondsAfterRunning := self getCurrentTimeInMilliseconds .
	
	^ millisecondsAfterRunning - millisecondsBeforeRunning! !


!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:22:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	| johnLennon |
	johnLennon := self johnLennon.
	
	self newCustomerBookThen: [:aCustomerBook |
		self assertTimeToRun: [ aCustomerBook addCustomerNamed: johnLennon. ] withLessThan: 50
	]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:19:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |
	paulMcCartney := self paulMcCartney. 
	
	self newCustomerBookWithCustomer: paulMcCartney then: [:aCustomerBook |
			self assertTimeToRun: [ aCustomerBook removeCustomerNamed: paulMcCartney. ] withLessThan: 100
		]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/14/2021 17:31:02'!
test03CanNotAddACustomerWithEmptyName 
			
	self newCustomerBookThen: [:aCustomerBook |
		self  ifClosureEvaluation: [ aCustomerBook addCustomerNamed: ''. ] 
			raisesError: Error 
			thenExecute: [ :anError |
						self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. 			
						self assert: aCustomerBook isEmpty ].
	]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:20:03'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
	johnLennon := self johnLennon. 
	
	self newCustomerBookWithCustomer: johnLennon then: [:aCustomerBook |
			self  ifClosureEvaluation: [ aCustomerBook removeCustomerNamed: (self paulMcCartney) . ]
				raisesError: NotFound 
				thenExecute: [ :anError | 
							self assert: ((aCustomerBook numberOfCustomers = 1)
							          and: (aCustomerBook includesCustomerNamed: johnLennon)) ]
		]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:38:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney |
	paulMcCartney := self paulMcCartney.
	
	self newCustomerBookWithCustomerSuspended: paulMcCartney
	              then: [:customerBook | nil ] 
			hasActiveCustomers: 0 
			hasSuspendedCustomers: 1 
			hasCustomers: 1 
			andAssert: [ 	:aBooleanClosure | aBooleanClosure ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:29:37'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook
	
	| paulMcCartney |
	paulMcCartney := self paulMcCartney. 
	
	self newCustomerBookWithCustomerSuspended: paulMcCartney
	              then: [:customerBook | customerBook removeCustomerNamed: paulMcCartney. ] 
			hasActiveCustomers: 0 
			hasSuspendedCustomers: 0 
			hasCustomers: 0 
			andAssert: [ 	:aBooleanClosure | aBooleanClosure not ].


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:20:28'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
	johnLennon := self johnLennon.
	
	self do: [ self newCustomerBookWithCustomer: johnLennon. ] 
		thenSuspendCustomer: (self georgeHarrison) 
		thenCheckIfSuspended: johnLennon! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jn 4/15/2021 15:20:33'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |		
	johnLennon := self johnLennon.

	self do: [ self newCustomerBookWithCustomerSuspended: johnLennon. ] 
		thenSuspendCustomer: johnLennon 
		thenCheckIfSuspended: johnLennon ! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
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


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'methods' stamp: 'plp 4/13/2021 16:10:49'!
filterOrderedCollection: aCollection withName: aName
	
	1 to: aCollection size do: 
		[ :index |
			aName = (aCollection at: index)
				ifTrue: [
			aCollection removeAt: index.
			^ aName.
		] 
	].

	^ NotFound signal.! !

!CustomerBook methodsFor: 'methods' stamp: 'jn 4/15/2021 14:41:13'!
printError: aClosure 

	self error: (aClosure value: self class)! !


!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 16:26:21'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 15:50:14'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 16:17:19'!
removeCustomerNamed: aName 
	
	[self filterOrderedCollection: active withName: aName.]
		on: NotFound 
		do: [	self filterOrderedCollection: suspended withName: aName.]! !

!CustomerBook methodsFor: 'customer management' stamp: 'jn 4/15/2021 14:39:47'!
signalCustomerAlreadyExists 

	self printError: [:class | class customerAlreadyExistsErrorMessage]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'jn 4/15/2021 14:39:58'!
signalCustomerNameCannotBeEmpty 

	self printError: [:class | class customerCanNotBeEmptyErrorMessage]

! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
