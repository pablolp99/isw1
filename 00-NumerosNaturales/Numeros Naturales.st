!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'axioms' stamp: 'jn 4/5/2021 20:23:29'!
next

	^II! !


!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 02:36:52'!
* unFactor

	^unFactor! !

!I class methodsFor: 'operations' stamp: 'jn 4/5/2021 20:46:12'!
+ unSumando

	^unSumando next! !

!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:16:48'!
- unMinuendo

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:16:51'!
/ unDividendo

	self < unDividendo ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [^self].! !

!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:16:55'!
< unNumero

	^self name < unNumero name! !

!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:16:58'!
div: unDividendo

	self < unDividendo ifTrue: [^self error: self descripcionDeErrorDeLaDivisionNoEsNatural] ifFalse: [^self].! !

!I class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:17:02'!
substractFrom: minuendo 

	^minuendo previous! !


!I class methodsFor: 'errors' stamp: 'jn 4/8/2021 15:16:29'!
descripcionDeErrorDeLaDivisionNoEsNatural

	^'La division no es natural.'! !

!I class methodsFor: 'errors' stamp: 'jn 4/8/2021 15:21:51'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor.'! !

!I class methodsFor: 'errors' stamp: 'jn 4/8/2021 15:16:37'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Numeros negativos no son naturales'! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 02:37:03'!
* unFactor

	^(self previous * unFactor) + unFactor! !

!II class methodsFor: 'operations' stamp: 'jn 4/5/2021 20:56:03'!
+ unSumando

	^self previous + unSumando next! !

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:17:33'!
- sustraendo

	^sustraendo substractFrom: self  
! !

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:23:46'!
/ unDividendo

	^self < unDividendo ifTrue: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [
		self div: unDividendo
	].
	
	! !

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:17:38'!
< unNumero

	^self name < unNumero name! !

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:17:41'!
div: unDividendo

	self < unDividendo ifTrue: [^self error: self descripcionDeErrorDeLaDivisionNoEsNatural] ifFalse: [
		self = unDividendo ifTrue: [^I] ifFalse:[
			^(self - unDividendo div: unDividendo) + I
			]
		].! !

!II class methodsFor: 'operations' stamp: 'jn 4/8/2021 15:17:45'!
substractFrom: minuendo

	^self previous substractFrom: minuendo previous! !


!II class methodsFor: 'errors' stamp: 'jn 4/8/2021 15:17:19'!
descripcionDeErrorDeLaDivisionNoEsNatural

	^'La division no es natural.'! !

!II class methodsFor: 'errors' stamp: 'jn 4/8/2021 15:17:23'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'No se puede dividir por un numero mayor.'! !


!II class methodsFor: 'axioms' stamp: 'jn 4/8/2021 15:17:09'!
next

	next ifNil:[
		next:=self createChildNamed: self name, 'I'.
		next previous: self.
	].
	^next
! !

!II class methodsFor: 'axioms' stamp: 'jn 4/8/2021 15:17:12'!
previous

	^previous! !

!II class methodsFor: 'axioms' stamp: 'jn 4/8/2021 15:17:15'!
previous: aPreviousNumber

	previous:=aPreviousNumber! !


!II class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIII.
	previous := IIIIIII.! !


!classDefinition: #IIIIIIIII category: 'Numeros Naturales'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIII.
	previous := IIIIIIII.! !


!classDefinition: #IIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIII.
	previous := IIIIIIIII.! !


!classDefinition: #IIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIII.
	previous := IIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIII.
	previous := IIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIII subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIII.
	previous := IIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIII subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIIIIIIIIIIIIIIIIIIIIIII.
	previous := IIIIIIIIIIIIIIIIIIIIIIIIII.! !


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIII category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIIIIIIIIIIIIIIIIIIIIIII class' category: 'Numeros Naturales'!
IIIIIIIIIIIIIIIIIIIIIIIIIIII class
	instanceVariableNames: ''!

!IIIIIIIIIIIIIIIIIIIIIIIIIIII class methodsFor: 'as yet unclassified' stamp: 'jn 4/8/2021 15:24:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIIIIIIIIIIIIIIIIIIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!
IIIIIIIII initializeAfterFileIn!
IIIIIIIIII initializeAfterFileIn!
IIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!
IIIIIIIIIIIIIIIIIIIIIIIIIIII initializeAfterFileIn!