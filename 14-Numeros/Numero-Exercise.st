!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:32:16'!
* aMultiplier 
	
	^ aMultiplier multiplyAnEntero: self	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:43:11'!
+ anAdder 

	^ anAdder addAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:35:48'!
- aSubtrahend 
	
	^ aSubtrahend substractFromAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:30:18'!
/ aDivisor 
	
	^ aDivisor divideAnEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 02:57:47'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 02:57:54'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'jn 4/22/2021 02:58:00'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'jn 4/22/2021 02:58:04'!
hash

	^ value hash! !


!Entero methodsFor: 'initialization' stamp: 'jn 4/22/2021 02:58:15'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'jn 4/22/2021 02:58:23'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^ value! !


!Entero methodsFor: 'printing' stamp: 'jn 4/22/2021 02:58:38'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 16:35:47'!
addAFraccion: anAdderFraccion
	
	^ self denominadorComun: anAdderFraccion operation: [:anEntero :anotherEntero | anEntero + anotherEntero].! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 02:58:47'!
addAnEntero: anAdderEntero
	
	^ self class with: value + anAdderEntero integerValue! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 16:22:49'!
below: aNumerator
	
	self subclassResponsibility. ! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 16:35:47'!
denominadorComun: aFraccion operation: anOperationClosure 
	
	|newNumerator|.
	newNumerator := anOperationClosure value: aFraccion numerator 
								      	value: (self * aFraccion denominator).
	^ newNumerator / aFraccion denominator.! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 02:09:27'!
divideAFraccion: aNumeratorFraccion

	^ aNumeratorFraccion numerator / (aNumeratorFraccion denominator * self)! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 00:30:52'!
divideAnEntero: aNumeratorEntero

	^ Fraccion with: aNumeratorEntero over: self! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 03:08:13'!
fibonacci

	self subclassResponsibility.! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 00:58:10'!
multiplyAFraccion: aMultiplierFraccion
	
	^ aMultiplierFraccion numerator * self / aMultiplierFraccion denominator! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 02:58:54'!
multiplyAnEntero: aMultiplierEntero
		
	^ self class with: value * aMultiplierEntero integerValue! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 16:22:53'!
over: aNumerator
	
	self subclassResponsibility. ! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 16:35:47'!
substractFromAFraccion: aMinuendFraccion
	
	^ self denominadorComun: aMinuendFraccion operation: [:anEntero :anotherEntero | anEntero - anotherEntero].
	! !

!Entero methodsFor: 'private' stamp: 'jn 4/22/2021 02:59:03'!
substractFromAnEntero: aSubstrahendEntero
	
	^self class with: aSubstrahendEntero integerValue - value! !


!Entero methodsFor: 'testing' stamp: 'jn 4/22/2021 02:59:08'!
isNegative
	
	^ value < 0! !

!Entero methodsFor: 'testing' stamp: 'jn 4/22/2021 02:59:12'!
isOne
	
	^ value = 1! !

!Entero methodsFor: 'testing' stamp: 'jn 4/22/2021 02:59:16'!
isZero
	
	^ value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'jn 4/22/2021 03:03:15'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [ ^ Cero new initialize ].
	aValue = 1 ifTrue: [ ^ Uno new initialize ].
	aValue < 0 ifTrue: [ ^ Negativos new initializeWith: aValue].

	^ MayoresAUno new initializeWith: aValue.
! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'private' stamp: 'jn 4/22/2021 15:33:26'!
below: aNumerador

	^ self error: Numero canNotDivideByZeroErrorDescription.
! !

!Cero methodsFor: 'private' stamp: 'jn 4/22/2021 03:11:19'!
fibonacci

	^ Entero with: 1! !

!Cero methodsFor: 'private' stamp: 'jn 4/22/2021 15:38:20'!
over: aDenominador

	^ self.
! !


!Cero methodsFor: 'initialization' stamp: 'jn 4/22/2021 03:02:47'!
initialize  
	
	value := 0.! !


!classDefinition: #MayoresAUno category: 'Numero-Exercise'!
Entero subclass: #MayoresAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayoresAUno methodsFor: 'private' stamp: 'jn 4/22/2021 15:39:12'!
below: aNumerador

	^ aNumerador over: self.! !

!MayoresAUno methodsFor: 'private' stamp: 'jn 4/22/2021 15:52:56'!
createFraccion: aNumerador
	
	^ Fraccion new initializeWith: aNumerador over: self
! !

!MayoresAUno methodsFor: 'private' stamp: 'jn 4/22/2021 03:11:06'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !

!MayoresAUno methodsFor: 'private' stamp: 'jn 4/22/2021 15:52:01'!
over: aDenominador
	| greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := self greatestCommonDivisorWith: aDenominador. 
   	numerator := self // greatestCommonDivisor.
    	denominator := aDenominador // greatestCommonDivisor.
	
	^ denominator createFraccion: numerator.! !


!classDefinition: #Negativos category: 'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'private' stamp: 'jn 4/22/2021 15:42:11'!
below: aNumerador

     ^ aNumerador over: self.
! !

!Negativos methodsFor: 'private' stamp: 'jn 4/22/2021 15:53:08'!
createFraccion: aNumerador
	
	^ Fraccion new initializeWith: aNumerador over: self
! !

!Negativos methodsFor: 'private' stamp: 'jn 4/22/2021 03:07:19'!
fibonacci

	^ self error: Entero negativeFibonacciErrorDescription! !

!Negativos methodsFor: 'private' stamp: 'jn 4/22/2021 15:58:46'!
over: aDenominador

	^ aDenominador createFraccion: self
! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'private' stamp: 'jn 4/22/2021 16:13:21'!
below: aNumerador

     ^ aNumerador

! !

!Uno methodsFor: 'private' stamp: 'jn 4/22/2021 15:53:24'!
createFraccion: aNumerador
	
	^ aNumerador
! !

!Uno methodsFor: 'private' stamp: 'jn 4/22/2021 03:09:22'!
fibonacci

	^ self! !

!Uno methodsFor: 'private' stamp: 'jn 4/22/2021 15:59:07'!
over: aDenominador

	^ aDenominador createFraccion: self
! !


!Uno methodsFor: 'initialization' stamp: 'jn 4/22/2021 03:02:58'!
initialize  
	
	value := 1.! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:38:55'!
* aMultiplier 
	
	^ aMultiplier multiplyAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:43:31'!
+ anAdder 
	
	^ anAdder addAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:40:52'!
- aSubtrahend 
  
	^ aSubtrahend substractFromAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jn 4/22/2021 00:40:59'!
/ aDivisor 
	
	^ aDivisor divideAFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'jn 4/22/2021 16:21:05'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].

	numerator := aNumerator.
	denominator := aDenominator
! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:06:02'!
addAFraccion: anAdderFraccion
	
	^ anAdderFraccion crossMultiplyWith: self operation: [:anEntero :anotherEntero | anEntero + anotherEntero]! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 00:56:34'!
addAnEntero: anAdderEntero
	
	^ anAdderEntero addAFraccion: self.! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:21:00'!
crossMultiplyWith: aFraccion operation: anOperationClosure
	
	| newNumerator newDenominator |.	
	newNumerator := anOperationClosure value: (aFraccion numerator * denominator) 
									value: (aFraccion denominator * numerator).
       newDenominator := aFraccion denominator * denominator.
       ^ newNumerator / newDenominator! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:06:16'!
divideAFraccion: aNumeratorFraccion

	^ self invertAndMultiplyBy: aNumeratorFraccion! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:06:16'!
divideAnEntero: aNumeratorEntero

	^ self invertAndMultiplyBy: aNumeratorEntero! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:06:16'!
invertAndMultiplyBy: aNumber

	^ aNumber * denominator / numerator! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:04:33'!
multiplyAFraccion: aMultiplierFraccion
	
	^ aMultiplierFraccion * numerator / denominator! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 00:59:28'!
multiplyAnEntero: aMultiplierEntero

	^ aMultiplierEntero multiplyAFraccion: self! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:06:02'!
substractFromAFraccion: aMinuendFraccion

	^ self crossMultiplyWith: aMinuendFraccion operation: [:anEntero :anotherEntero | anEntero - anotherEntero]! !

!Fraccion methodsFor: 'private' stamp: 'jn 4/22/2021 02:45:59'!
substractFromAnEntero: aMinuendEntero
	
	^ (aMinuendEntero substractFromAFraccion: self) negated .! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'jn 4/22/2021 16:18:04'!
with: aDividend over: aDivisor

	^ aDivisor below: aDividend! !
