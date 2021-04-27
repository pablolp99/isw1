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
	instanceVariableNames: 'emptyStack sixStringsStack sentenceFinder twoElementStack oneElementStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:16:35'!
test001EmptyPrefixInEmptyStackRaisesError

	self
		should: [ sentenceFinder find: '' in: emptyStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:16:40'!
test002CantFindValidPrefixInEmptyStack

	self assert: (sentenceFinder find: 'Algo' in: emptyStack) isEmpty! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:08:36'!
test003BlankSpacePrefixInEmptyStackRaisesError

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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:09:46'!
test004EmptyPrefixInOneElementStackRaisesError

	self
		should: [ sentenceFinder find: '' in: oneElementStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:10:21'!
test005BlankSpacePrefixInOneElementStackRaisesError

	self
		should: [ sentenceFinder find: ' ' in: oneElementStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpaceDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:10:59'!
test006ValidPrefixInOneElementStackMatch

	self assert: (sentenceFinder find: 'One' in: oneElementStack) = (OrderedCollection with: 'One').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:11:21'!
test007ValidPrefixInOneElementStackDoesNotMatch

	self assert: (sentenceFinder find: 'Two' in: oneElementStack) = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:12:35'!
test008EmptyPrefixInNonEmptyStackRaisesError

	self
		should: [ sentenceFinder find: '' in: sixStringsStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:13:09'!
test009BlankSpacePrefixInNonEmptyStackRaisesError
	
	self
		should: [ sentenceFinder find: ' ' in: sixStringsStack ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpaceDescription ].! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:13:47'!
test010ValidPrefixInNonEmptyStackMatchesOneString
	
	self assert: ( sentenceFinder find: 'win' in: sixStringsStack ) = (OrderedCollection with: 'winning eleven').! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:14:15'!
test011ValidPrefixInNonEmptyStackDoesNotMatch
	
	self assert: ( sentenceFinder find: 'Cr7' in: sixStringsStack ) = (OrderedCollection new).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:48:01'!
test012ValidPrefixInNonEmptyStackMatchesMultipleStrings

	| comparingResult |

	comparingResult := (OrderedCollection with: 'Messierra' with: 'Messirve' with: 'Me beneficia')	.

	self assert: ( sentenceFinder find: 'Me' in: sixStringsStack ) = comparingResult.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'plp 4/26/2021 21:16:24'!
test013NonEmptyStackPreservesAfterFind
	
	| stack |
	
	stack := OOStack new.
	stack push: 'Hola'.
	stack push: 'Chau'.
	
	sentenceFinder find: 'Ho' in: twoElementStack .
	
	stack size timesRepeat: 	[ self assert: (stack pop) = twoElementStack pop].! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'plp 4/26/2021 21:02:22'!
setUp
	
	sentenceFinder := SentenceFinderByPrefix new.
	
	emptyStack := OOStack new.
	
	oneElementStack := OOStack new.
	oneElementStack push: 'One'.
	
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

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:45:57'!
dumpStringsFrom: aStack

	| reversedStack stringsCollection |
	reversedStack := OOStack new.
	stringsCollection := OrderedCollection new.
		
	aStack size timesRepeat: 	[ self popStringFrom: aStack pushTo: reversedStack andAddTo: stringsCollection ].
		
	self reverseStack: reversedStack to: aStack.
	
	^ stringsCollection ! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:21:53'!
findPrefix: aPrefix in: stringsCollection
	
	^ stringsCollection select: [ :aString | aString beginsWith: aPrefix ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:19:34'!
hasPrefixSpaces: aPrefix

	(aPrefix includesSubString: ' ') ifTrue: [self error: self class prefixWithSpaceDescription ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:19:06'!
isPrefixEmpty: aPrefix

	(aPrefix = '') ifTrue: [self error: self class prefixIsEmptyDescription].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:18:50'!
isPrefixValid: aPrefix

	self hasPrefixSpaces: aPrefix.
	self isPrefixEmpty: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:47:04'!
popStringFrom: aStack pushTo: aReversedStack andAddTo: stringsCollection

	| aStackElement |

	aStackElement := (aStack pop).
	aReversedStack push: aStackElement.	
	stringsCollection addFirst: aStackElement.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'plp 4/26/2021 21:33:31'!
reverseStack: aReversedStack to: aStack

	aReversedStack size timesRepeat: 	[ aStack push: aReversedStack pop ]! !


!SentenceFinderByPrefix methodsFor: 'public' stamp: 'plp 4/26/2021 21:46:24'!
find: aPrefix in: aStack

	| stringsCollection |

	self isPrefixValid: aPrefix.
	
	stringsCollection := self dumpStringsFrom: aStack.

	^ self findPrefix: aPrefix in: stringsCollection ! !

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

!StackElement methodsFor: 'public' stamp: 'plp 4/26/2021 17:24:33'!
elementValue

	^ self subclassResponsibility! !


!classDefinition: #Base category: 'Stack-Exercise'!
StackElement subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'errors' stamp: 'plp 4/26/2021 17:03:09'!
stackEmptyError

	self error: self class stackEmptyErrorDescription ! !


!Base methodsFor: 'public' stamp: 'plp 4/26/2021 17:21:44'!
elementValue

	self stackEmptyError! !

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

!Value methodsFor: 'public' stamp: 'plp 4/26/2021 17:21:44'!
elementValue

	^ value! !


!Value methodsFor: 'initialization' stamp: 'plp 4/26/2021 16:58:10'!
initializeWith: anElement

	value := anElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Value class' category: 'Stack-Exercise'!
Value class
	instanceVariableNames: 'value'!

!Value class methodsFor: 'as yet unclassified' stamp: 'plp 4/26/2021 17:22:28'!
with: anElement

	^ Value new initializeWith: anElement! !

