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


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 16:26:21'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 16:10:49'!
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

!CustomerBook methodsFor: 'customer management' stamp: 'plp 4/13/2021 16:27:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !


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

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:11:07'!
assertThatCustomerBook: aCustomerBook hasActiveCustomers: activeValue hasSuspendedCustomers: suspendedValue hasCustomers: customersValue andAssert: anAssertingClosure
	self assert: activeValue equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedValue equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: customersValue equals: aCustomerBook numberOfCustomers.
	self assert: anAssertingClosure value! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 16:46:45'!
customerBookWithAClosure: aClosure suspend: aCustomerName alreadySuspended: anotherCustomerName

	| customerBook |
	
	customerBook := aClosure value.
	
	self  ifClosureEvaluation: [ customerBook suspendCustomerNamed: aCustomerName. ] 
		raisesError: CantSuspend
		thenExecute: [ :anError | 
						self assert: customerBook numberOfCustomers = 1.
						self assert: (customerBook includesCustomerNamed: anotherCustomerName) ]! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 13:39:24'!
getCurrentTimeInMilliseconds
	
	^ Time millisecondClockValue * millisecond.! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 14:46:25'!
ifClosureEvaluation: aClosureEvaluation raisesError: raiseError thenExecute: aClosureExecution

	[ aClosureEvaluation value . 
	self fail ]
		on: raiseError
		do: aClosureExecution! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:12:47'!
newCustomerBookWithCustomer: aCustomerName

	^ CustomerBook new addCustomerNamed: aCustomerName ! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:22:49'!
newCustomerBookWithCustomerSuspended: aCustomerName

	^ ( CustomerBook new addCustomerNamed: aCustomerName ) suspendCustomerNamed: aCustomerName! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:04:01'!
timeToRun: aClosure

	| millisecondsBeforeRunning millisecondsAfterRunning |
	  
	millisecondsBeforeRunning := self getCurrentTimeInMilliseconds .
	aClosure value.
	millisecondsAfterRunning := self getCurrentTimeInMilliseconds .
	
	^ millisecondsAfterRunning - millisecondsBeforeRunning! !

!CustomerBookTest methodsFor: 'methods' stamp: 'plp 4/13/2021 15:24:52'!
timeToRun: aClosure withLessThan: someTimeInMilliseconds
	
	^ (self timeToRun: aClosure ) < (someTimeInMilliseconds * millisecond)
	
! !


!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 15:24:35'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assert: (self timeToRun: [ customerBook addCustomerNamed: 'John Lennon'. ] withLessThan: 50)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 15:24:40'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomer: paulMcCartney .

	self assert: 	(self timeToRun: [ customerBook removeCustomerNamed: paulMcCartney. ] withLessThan: 100)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 14:45:05'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self  ifClosureEvaluation: [ customerBook addCustomerNamed: ''. ] 
		raisesError: Error 
		thenExecute: [ :anError |
					self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. 			
					self assert: customerBook isEmpty ].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 15:18:26'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook := self newCustomerBookWithCustomer: johnLennon.

	self  ifClosureEvaluation: [ customerBook removeCustomerNamed: 'Paul McCartney'. ]
		raisesError: NotFound 
		thenExecute: [ :anError | 
					self assert: customerBook numberOfCustomers = 1.
					self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 15:23:04'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomerSuspended: paulMcCartney.
	
	self assertThatCustomerBook: customerBook 
			hasActiveCustomers: 0 
			hasSuspendedCustomers: 1 
			hasCustomers: 1 
			andAssert: [	 customerBook includesCustomerNamed: paulMcCartney. ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 15:23:15'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self newCustomerBookWithCustomerSuspended: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatCustomerBook: customerBook 
			hasActiveCustomers: 0 
			hasSuspendedCustomers: 0 
			hasCustomers: 0 
			andAssert: [ (customerBook includesCustomerNamed: paulMcCartney) not ].


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 16:45:51'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
	
	johnLennon := 'John Lennon'.
	
	self  customerBookWithAClosure: [ self newCustomerBookWithCustomer: johnLennon. ] 
		suspend: 'George Harrison' 
		alreadySuspended: johnLennon ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'plp 4/13/2021 16:47:35'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.

	self customerBookWithAClosure: [ self newCustomerBookWithCustomerSuspended: johnLennon. ] 
		suspend: johnLennon 
		alreadySuspended: johnLennon ! !
