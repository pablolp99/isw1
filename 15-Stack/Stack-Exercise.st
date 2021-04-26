!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 4/22/2021 17:25:26'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstObject'.
	secondPushedObject := 'secondObject'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'emptyStack sixStringsStack sentenceFinder twoElementStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:05:21'!
test01EmptyStackAnyPrefix

	self assert: (sentenceFinder find: 'Algo' in: emptyStack) isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:12:52'!
test02CantFindEmptyPrefix

	self
		should: [ sentenceFinder find: '' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:20:52'!
test03CantFindEmptySpacePrefix

	self
		should: [ sentenceFinder find: ' ' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpaceDescription ].
		
	self
		should: [ sentenceFinder find: 'Messi ' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpaceDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:25:53'!
test04MatchesOneString
	
	self assert: ( sentenceFinder find: 'win' in: sixStringsStack ) = (OrderedCollection with: 'winning eleven').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:26:45'!
test05DoesNotMatchAny
	
	self assert: ( sentenceFinder find: 'Cr7' in: sixStringsStack ) = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:30:34'!
test06MatchesManyStrings

	| comparingResult |

	comparingResult := (OrderedCollection with: 'Me beneficia' with: 'Messirve' with: 'Messierra')	.

	self assert: ( sentenceFinder find: 'Me' in: sixStringsStack ) = comparingResult.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:43:55'!
test07StackMaintainsOrder
	
	| stack |
	
	stack := OOStack new.
	stack push: 'Hola'.
	stack push: 'Chau'.
	
	sentenceFinder find: 'Ho' in: twoElementStack .
	
	stack size timesRepeat: 	[ self assert: (stack pop) = twoElementStack pop].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 18:45:58'!
test08StringExistsButPrefixNot

	self assert: ( sentenceFinder find: 'eleven' in: sixStringsStack ) = (OrderedCollection new).! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'plp 4/26/2021 18:42:41'!
setUp
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	emptyStack := OOStack new.
	
	twoElementStack := OOStack new.
	twoElementStack push: 'Hola'.
	twoElementStack push: 'Chau'.
	
	sixStringsStack := OOStack new.
	sixStringsStack push: 'Winter is here'.
	sixStringsStack push: 'Winning eleven'.
	sixStringsStack push: 'winning eleven'.
	sixStringsStack push: 'Messierra'.
	sixStringsStack push: 'Messirve'.
	sixStringsStack push: 'Me beneficia'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'public' stamp: 'plp 4/26/2021 17:08:14'!
isEmpty
	
	^ self size = 0! !

!OOStack methodsFor: 'public' stamp: 'plp 4/26/2021 15:30:26'!
pop
	
	| last |
	last := self lastElement.
	elements removeLast.
	^ last.! !

!OOStack methodsFor: 'public' stamp: 'plp 4/26/2021 17:22:28'!
push: anElement
	
	elements addLast: (Value with: anElement).
	! !

!OOStack methodsFor: 'public' stamp: 'plp 4/26/2021 16:52:36'!
size

	^ elements size - 1! !

!OOStack methodsFor: 'public' stamp: 'plp 4/26/2021 17:02:41'!
top
	
	^ self lastElement! !


!OOStack methodsFor: 'initialization' stamp: 'plp 4/26/2021 17:20:14'!
initialize
	
	elements := OrderedCollection new.
	elements addLast: (Base new)! !


!OOStack methodsFor: 'errors' stamp: 'plp 4/26/2021 15:25:49'!
stackEmptyError

	self error: self class stackEmptyErrorDescription ! !


!OOStack methodsFor: 'private' stamp: 'plp 4/26/2021 17:21:29'!
lastElement

	^ elements last elementValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 4/22/2021 17:22:41'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 18:19:35'!
find: aPrefix in: aStack

	| reverseStack stackSize aStackElement prefixCollection |

	(aPrefix = '') ifTrue: [self error: self class prefixIsEmptyDescription].
	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixWithSpaceDescription ].
	
	stackSize := aStack size.
	reverseStack := OOStack new.
	prefixCollection := OrderedCollection new.
	
	stackSize timesRepeat: 	[
			aStackElement := (aStack pop).
			reverseStack push: aStackElement.		
			prefixCollection addLast: aStackElement ].
		
	stackSize timesRepeat: 	[
			aStack push: reverseStack pop ].

	^ prefixCollection select: [ :aString | aString beginsWith: aPrefix ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 18:09:38'!
prefixIsEmptyDescription

	^ 'Prefijo esta vacio!!!!!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 18:19:15'!
prefixWithSpaceDescription

	^ 'El prefijo contiene un espacio!!!!!!'! !


!classDefinition: #StackElement category: 'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:24:33'!
elementValue

	^ self subclassResponsibility! !


!classDefinition: #Base category: 'Stack-Exercise'!
StackElement subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:21:44'!
elementValue

	self stackEmptyError! !

!Base methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:03:09'!
stackEmptyError

	self error: self class stackEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Base class' category: 'Stack-Exercise'!
Base class
	instanceVariableNames: ''!

!Base class methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:03:19'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!!!!!'! !


!classDefinition: #Value category: 'Stack-Exercise'!
StackElement subclass: #Value
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Value methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:21:44'!
elementValue

	^ value! !

!Value methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 16:58:10'!
initializeWith: anElement

	value := anElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Value class' category: 'Stack-Exercise'!
Value class
	instanceVariableNames: 'value'!

!Value class methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:22:28'!
with: anElement

	^ Value new initializeWith: anElement! !

