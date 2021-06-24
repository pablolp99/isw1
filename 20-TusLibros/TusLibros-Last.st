!classDefinition: #ApplicationFacadeTest category: 'TusLibros'!
TestCase subclass: #ApplicationFacadeTest
	instanceVariableNames: 'testObjectsFactory validExpirationDate merchantProcessorSuccess merchantProcessorFail validIsbn invalidUserID validUserID wrongPassword correctPassword validCardNumber validCardOwner invalidCardNumber expiratedExpirationDate invalidIsbn defaultCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:02:32'!
setUp 

	| validYear validMonth |

	testObjectsFactory := StoreTestObjectsFactory new.
	defaultCatalog := testObjectsFactory defaultCatalog.

	merchantProcessorSuccess := MerchantProcessorSimulatorSuccess new.
	merchantProcessorFail := MerchantProcessorSimulatorFailed new.
	
	validYear := (GregorianDateTime now year number + 1) asString .
	validMonth := GregorianDateTime now monthOfYear monthNumber + 1 .
	validMonth < 10 ifTrue: [ validMonth := '0', validMonth asString ] ifFalse: [ validMonth := validMonth asString ].
	validExpirationDate := validMonth , validYear .
	validCardNumber := 1234567890123456.
	validCardOwner := 'Bjarne Stroustrup'.
	
	invalidCardNumber := 1111.
	expiratedExpirationDate := '122020'.

	validIsbn := testObjectsFactory itemSellByTheStore .
	invalidIsbn := '1111111111111'.	
	
	invalidUserID := 'Non-registered id'.
	wrongPassword := 'WrongPassword'.
	
	validUserID := '12345'.
	correctPassword := 'CorrectPassword'.
	
	now := self now.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:26:37'!
test01CreateCartForNonRegisteredUser

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self assertErrorCreateCartFor: app with: invalidUserID .
	self assertErrorCreateCartFor: app with: validUserID .! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:19:30'!
test02CreateCartForRegisteredUserAndCorrectPassword

	| app cartId |
	
	app := self createDefaultCatalogedApp.
	
	cartId := self createCartForValidUserAndCorrectPasswordNowFor: app at: self now.
	
	self assert: (#() asOrderedCollection) equals: (app listCartFor: cartId).! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:19:30'!
test03CreateMultipleCartsWithValidUsers

	| app oneCartId anotherCartId |
	
	app := self createDefaultCatalogedApp.
	
	oneCartId := self createCartForValidUserAndCorrectPasswordNowFor: app at: self now.
	anotherCartId := self createCartForValidUserAndCorrectPasswordNowFor: app at: self now.
	
	self deny: (oneCartId = anotherCartId).! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:23:19'!
test04AddToCartToInvalidCartId

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self 
		should: [ app addToCart: 0 with: invalidIsbn quantity: 1 on: self now ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade invalidCartIdErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:19:30'!
test06AddToCartToValidCartIDAValidISBNWithAValidQuantity

	| app cartId expectedList |
	
	app := self createDefaultCatalogedApp.
	cartId := self createCartForValidUserAndCorrectPasswordNowFor: app at: self now.
	self addValidItemToCart: cartId in: app amount: 1.
	
	expectedList := OrderedCollection new.
	expectedList add: (1@validIsbn).
	
	self assert: (app listCartFor: cartId) equals: expectedList.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:22:05'!
test09CheckOutCartValidCardAndCart

	| app sale salesBook transactionId |
	
	app := self createDefaultCatalogedApp.
	transactionId := (self createTransactionForNewCartWith: 1 on: app createAt: self now checkOutAt: self now) .
		
	sale := (Sale of: StoreTestObjectsFactory new itemSellByTheStorePrice).
	salesBook := app salesBook.
	
	self assert: transactionId equals: 1.
	self assert: (salesBook first total) equals: sale total.
! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:22:05'!
test10CheckOutMultipleCartsWithValidCard

	| app |
	
	app := self createDefaultCatalogedApp.
			
	self deny: 
		(self createTransactionForNewCartWith: 1 on: app createAt: self now checkOutAt: self now ) = (self createTransactionForNewCartWith: 2 on: app createAt: self now checkOutAt: self now )
! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:43:42'!
test11ListPurchasesOfNonExistingUserOrWrongPassword

	| app |
	
	app := self createDefaultCatalogedApp.
	
	self assertErrorListPurchaseOf: app with: invalidUserID password: correctPassword.
	self assertErrorListPurchaseOf: app with: validUserID password: wrongPassword .! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:23:48'!
test12ListPurchasesOfRegisteredUserWithoutPurchases

	| app purchases |
	
	app := self createDefaultCatalogedApp.
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .
	
	self assert: purchases equals: 0@OrderedCollection new.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:22:05'!
test13ListPurchasesOfRegisteredUserWithOnePurchase

	| app purchases result |
	
	app := self createDefaultCatalogedApp.
	self createTransactionForNewCartWith: 1 on: app createAt: self now checkOutAt: self now.
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .
	
	result := 10@(OrderedCollection new).
	(result y) add: 1@validIsbn .
	
	self assert: purchases equals: result.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:22:05'!
test14ListPurchasesOfRegisteredUserWithMultiplePurchases

	| app purchases result |
	
	app := self createDefaultCatalogedApp.
	
	self createTransactionForNewCartWith: 1 on: app createAt: self now checkOutAt: self now .
	self createTransactionForNewCartWith: 2 on: app createAt: self now checkOutAt: self now .
	
	purchases := app listPurchasesFor: validUserID withPassword: correctPassword .
	
	result := 30@(OrderedCollection new).
	(result y) add: 3@validIsbn .
	
	self assert: purchases equals: result.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:22:05'!
test15ListPurchasesOfMultipleUsers

	| app anotherValidUser anotherCartId purchasesAnotherUser purchasesFirstUser resultAnotherUser resultFirstUser |
	
	app := self createDefaultCatalogedApp.
	
	anotherValidUser := '54321' .
	
	self createTransactionForNewCartWith: 1 on: app createAt: self now checkOutAt: self now .
	
	anotherCartId := app createCartForUser: anotherValidUser password: correctPassword on: self now.
	self addValidItemToCart: anotherCartId in: app amount: 2.
	app checkOutCart: anotherCartId withCardNumber: validCardNumber owner: validCardOwner expiresOn: validExpirationDate trought: merchantProcessorSuccess on: self now .
	
	purchasesFirstUser := app listPurchasesFor: validUserID withPassword: correctPassword .
	purchasesAnotherUser := app listPurchasesFor: anotherValidUser withPassword: correctPassword .
	
	resultFirstUser := 10@(OrderedCollection new).
	(resultFirstUser y) add: 1@validIsbn .
	
	resultAnotherUser := 20@(OrderedCollection new).
	(resultAnotherUser y) add: 2@validIsbn .
	
	self assert: purchasesFirstUser equals: resultFirstUser.
	self assert: purchasesAnotherUser equals: resultAnotherUser.! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:19:30'!
test16AddToCartFailsAfter30Minutes

	| app cartId |
	
	app := self createDefaultCatalogedApp.
	
	cartId := self createCartForValidUserAndCorrectPasswordNowFor: app at: self now.
	
	self 
		should: [ app addToCart: cartId with: validIsbn quantity: 1 on: (self now + 30 minutes). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade cartOutOfTimeErrorDescription ]! !

!ApplicationFacadeTest methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 01:23:08'!
test17CheckOutCartFailsAfter30Minutes

	| app now |
	
	app := self createDefaultCatalogedApp.
	now := self now.
	
	self 
		should: [ self createTransactionForNewCartWith: 1 on: app createAt: now checkOutAt: (now + 30 minutes). ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade cartOutOfTimeErrorDescription ]! !


!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:35:09'!
addValidItemToCart: aCartID in: anApp amount: anAmount 
	
	anApp addToCart: aCartID with: validIsbn quantity: anAmount on: self now.! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:25:37'!
assertErrorCreateCartFor: anApp with: anUserID
	
	self 
		should: [ anApp createCartForUser: anUserID password: wrongPassword on: self now ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade authenticationFailedErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:43:08'!
assertErrorListPurchaseOf: anApp with: aUserId password: aPassword
	self 
		should: [ anApp listPurchasesFor: aUserId withPassword: aPassword ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = ApplicationFacade authenticationFailedErrorDescription ].! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 01:19:40'!
createCartForValidUserAndCorrectPasswordNowFor: anApp at: aTime

	^ anApp createCartForUser: validUserID password: correctPassword on: aTime.
	! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:22:34'!
createDefaultCatalogedApp

	^ApplicationFacade forCatalog: defaultCatalog.
! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 01:22:37'!
createTransactionForNewCartWith: anAmount on: anApp createAt: aCreationTime checkOutAt: aCheckOutTime
	
	| cartId |
	cartId := self createCartForValidUserAndCorrectPasswordNowFor: anApp at: aCreationTime.
	self addValidItemToCart: cartId in: anApp amount: anAmount.
	^ anApp checkOutCart: cartId 
			withCardNumber: validCardNumber 
			owner: validCardOwner 
			expiresOn: validExpirationDate 
			trought: merchantProcessorSuccess on: aCheckOutTime .! !

!ApplicationFacadeTest methodsFor: 'private' stamp: 'plp 6/24/2021 00:00:50'!
now

	^ DateAndTime now ! !


!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: MerchantProcessorSimulatorSuccess new
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: MerchantProcessorSimulatorSuccess new
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: MerchantProcessorSimulatorSuccess new
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: MerchantProcessorSimulatorSuccess new
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:52:37'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantProcessor := MerchantProcessorSimulatorSuccess new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
	debitedAmout := merchantProcessor debitedAmount.
	debitedCreditCard := merchantProcessor debitedCreditCard.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'plp 6/22/2021 19:53:17'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard merchantProcessor |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
	merchantProcessor := MerchantProcessorSimulatorFailed new.
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: merchantProcessor
		on: testObjectsFactory today
		registeringOn: salesBook.
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'plp 6/22/2021 19:56:53'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'expirationDate validOwner validNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:28'!
setUp
	
	| today |
	today := GregorianMonthOfYear current.
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:15:29'!
test01CanNotCreateACardWithNumberDigitsNotEqualsTo16

	self 
		should: [ CreditCard withNumber: 1234567890123456123543154154 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
	self 
		should: [ CreditCard withNumber: 123 owner: validOwner expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:15:48'!
test02CanNotCreateACardWithEmptyOwner

	self 
		should: [ CreditCard withNumber: validNumber owner: '' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
	self 
		should: [ CreditCard withNumber: validNumber owner: '    ' expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:00'!
test03CanCreateACardWithValidNumberAndOwner

	|card |
	card := CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.
	
	self assert: card number equals: validNumber.
	self assert: card owner equals: validOwner.
	self assert: card expiresOn equals: expirationDate.

! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 20:16:08'!
test04CanNotCreateACardWithExceededLengthOwner

	self 
		should: [ 
			CreditCard withNumber: validNumber 
				owner: 'este nombre es mas largo de 30 caracteres' 
				expiresOn: expirationDate ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | self assert: anError messageText = CreditCard invalidCardErrorMessage. ].
		
! !


!classDefinition: #ApplicationFacade category: 'TusLibros'!
Object subclass: #ApplicationFacade
	instanceVariableNames: 'lastCartId catalog carts salesBook lastTransactionId cartOwners purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApplicationFacade methodsFor: 'initialization' stamp: 'plp 6/23/2021 22:58:38'!
initializeWith: aCatalog
	
	lastCartId := 0 .
	catalog := aCatalog .
	carts := Dictionary new .
	salesBook := OrderedCollection new .
	lastTransactionId := 0 .
	cartOwners := Dictionary new .
	purchases := Dictionary new . ! !

!ApplicationFacade methodsFor: 'initialization' stamp: 'plp 6/23/2021 21:53:19'!
today

	^ GregorianMonthOfYear current.! !


!ApplicationFacade methodsFor: 'communication' stamp: 'plp 6/24/2021 00:58:44'!
addToCart: aCartId with: anISBN quantity: aQuantity on: on 

	|cart|
	
	cart := (carts at: aCartId ifAbsent: [ 	self error: ApplicationFacade invalidCartIdErrorDescription ]) key.
	
	self assertCartLastActivity: aCartId on: on .
	
	cart add: aQuantity of: anISBN.
	! !

!ApplicationFacade methodsFor: 'communication' stamp: 'plp 6/24/2021 01:15:11'!
checkOutCart: aCartId withCardNumber: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString trought: aProcessor on: on  

	| card cart cashier |

	self assertCartLastActivity: aCartId on: on .
		
	card := self createCardWith: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString .
	cart := 	(carts at: aCartId) key .

	cashier := Cashier 
				toCheckout: cart
				charging: card
				throught: aProcessor
				on: self today
				registeringOn: salesBook .
				
	cashier checkOut .
	
	"Agregar a purchases"
	self addPurchase: aCartId .
	
	lastTransactionId := lastTransactionId + 1 .
	^ lastTransactionId! !

!ApplicationFacade methodsFor: 'communication' stamp: 'plp 6/24/2021 00:47:45'!
createCartForUser: aUserId password: aPassword on: aTimeStamp

	| newCartId newCart |

	self assertAuthentication: aUserId with: aPassword.
	
	lastCartId := lastCartId + 1.
	newCartId := lastCartId .	
	newCart := Cart acceptingItemsOf: catalog.
	
	carts add: newCartId->(newCart->aTimeStamp) . "  timeStamp@newCart "
	cartOwners add: newCartId->aUserId .
	
	^ newCartId ! !

!ApplicationFacade methodsFor: 'communication' stamp: 'plp 6/24/2021 00:49:11'!
listCartFor: aCartId

	| cart list |
	
	cart := (carts at: aCartId ifAbsent: [ 	self error: ApplicationFacade invalidCartIdErrorDescription ]) key.
	list := OrderedCollection new.
	
	
	catalog keysDo: [ 
		:item | 
			(cart occurrencesOf: item) = 0 ifFalse: [
				list add: ( (cart occurrencesOf: item) @ item ).
		].
	].

	^ list! !

!ApplicationFacade methodsFor: 'communication' stamp: 'plp 6/23/2021 23:40:41'!
listPurchasesFor: aUserId withPassword: aPassword
	
	| total collection |
	self assertAuthentication: aUserId with: aPassword .
	collection := 	OrderedCollection new .
	total := 0 .
	
	(purchases at: aUserId ifAbsent: [ ^ total@collection ]) keysAndValuesDo: [ :key :value |
		collection add: (value@key) .
		total := total + (self getTotal: key quantity: value) .
	] .
	
	^ total@collection.! !


!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 23:27:32'!
addPurchase: aCartId
	
	| userId purchasesDict cartItems |
	
	userId := cartOwners at: aCartId .
	
	purchasesDict := purchases at: userId ifAbsent: [ 
		purchases add: userId->Dictionary new .
		purchases at: userId .
	] .
	
	cartItems := self listCartFor: aCartId .
	
	cartItems do: [ :item |
		purchasesDict at: (item y) ifAbsent: [			purchasesDict add: (item y)->0 ] .
		purchasesDict at: (item y) put: ( (purchasesDict at: (item y)) + (item x))
	]
	
	"purchasesCollection add: aCartId ."! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/22/2021 18:34:47'!
assertAuthentication: aUserId with: aPassword

	AuthSimulator authenticateUserId: aUserId withPassword: aPassword.! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 22:10:18'!
createAvailableId

	lastCartId := lastCartId + 1.
	^ lastCartId
	! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 21:07:55'!
createCardWith: aCardNumber owner: aCardOwner expiresOn: aCardExpirationString
	
	| expirationMonth expirationYear expiration |
	
	expirationMonth := (aCardExpirationString 	copyFrom: 1 to: 2) asNumber .
	expirationYear := (aCardExpirationString 	copyFrom: 3 to: 6) asNumber .
	
	expiration := GregorianMonthOfYear yearNumber: expirationYear monthNumber: expirationMonth .
	
	^ CreditCard withNumber: aCardNumber owner: aCardOwner expiresOn: expiration ! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 23:36:18'!
getTotal: anISBN quantity: aQuantity
	
	^ (catalog at: anISBN) * aQuantity ! !

!ApplicationFacade methodsFor: 'private' stamp: 'plp 6/23/2021 22:08:37'!
salesBook
	
	^ salesBook! !


!ApplicationFacade methodsFor: 'assertions' stamp: 'plp 6/24/2021 01:15:46'!
assertCartLastActivity: aCartId on: on
	
	| timeStamp difference |
	timeStamp := (carts at: aCartId) value.
	difference := (on - timeStamp) minutes.
	(difference >= 30) ifTrue: [ self error: ApplicationFacade cartOutOfTimeErrorDescription ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApplicationFacade class' category: 'TusLibros'!
ApplicationFacade class
	instanceVariableNames: ''!

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:21:02'!
authenticationFailedErrorDescription
	
	^ 'Wrong User or Password'! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/24/2021 00:07:01'!
cartOutOfTimeErrorDescription
	
	^ 'The cart has ran out of time due to inactivity'! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:41:04'!
forCatalog: aCatalog

	^ self new initializeWith: aCatalog.! !

!ApplicationFacade class methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 18:55:57'!
invalidCartIdErrorDescription
	
	^ 'Invalid Cart ID'! !


!classDefinition: #AuthSimulator category: 'TusLibros'!
Object subclass: #AuthSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthSimulator class' category: 'TusLibros'!
AuthSimulator class
	instanceVariableNames: ''!

!AuthSimulator class methodsFor: 'as yet unclassified' stamp: 'plp 6/23/2021 23:38:22'!
authenticateUserId: aUserId withPassword: aPassword

	(aUserId = 'Non-registered id' or: (aPassword = 'WrongPassword')) ifTrue: [ self error: ApplicationFacade authenticationFailedErrorDescription ].! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'plp 6/23/2021 21:14:29'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^ self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number owner expiresOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:40'!
expiresOn
	^expiresOn! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:23:41'!
isExpiredOn: aDate 
	
	^expiresOn < aDate.! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:36'!
number
	^ number! !

!CreditCard methodsFor: 'testing' stamp: 'plp 6/22/2021 20:12:32'!
owner
	^owner! !


!CreditCard methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:11:53'!
forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear

	number := aCardNumber. 
	owner := anOwner.
	expiresOn := aMonthOfYear.! !

!CreditCard methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:11:39'!
initializeExpiringOn: aMonth 
	
	expiresOn := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'plp 6/22/2021 20:13:34'!
withNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear
				
	self assertCardNumber: aCardNumber.
	self assertCardOwner: anOwner.

	^ self new forNumber: aCardNumber owner: anOwner expiresOn: aMonthOfYear! !


!CreditCard class methodsFor: 'assertions' stamp: 'plp 6/22/2021 20:13:02'!
assertCardNumber: aCardNumber
	
	((aCardNumber numberOfDigitsInBase: 10) = 16) ifFalse: [ self error: self invalidCardErrorMessage ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'plp 6/22/2021 20:13:09'!
assertCardOwner: anOwner
	
	((anOwner withBlanksTrimmed isEmpty) or: (anOwner size > 30))
		ifTrue: [ self error: self invalidCardErrorMessage ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!CreditCard class methodsFor: 'error-descriptions' stamp: 'plp 6/22/2021 20:13:13'!
invalidCardErrorMessage

	^'Invalid card'.! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:58:10'!
debit: anAmount from: aCreditCard

	self subclassResponsibility.! !


!classDefinition: #MerchantProcessorSimulatorFailed category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MerchantProcessorSimulatorFailed
	instanceVariableNames: 'debitedAmount debitedCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorFailed methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:53:34'!
debit: anAmount from: aCreditCard

	self error: Cashier creditCardHasNoCreditErrorMessage! !


!classDefinition: #MerchantProcessorSimulatorSuccess category: 'TusLibros'!
MerchantProcessorSimulator subclass: #MerchantProcessorSimulatorSuccess
	instanceVariableNames: 'debitedAmount debitedCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:45:45'!
debit: anAmount from: aCreditCard

	debitedAmount := anAmount .
	debitedCreditCard := aCreditCard .! !

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:48:53'!
debitedAmount

	^debitedAmount! !

!MerchantProcessorSimulatorSuccess methodsFor: 'as yet unclassified' stamp: 'plp 6/22/2021 19:49:04'!
debitedCreditCard
	
	^debitedCreditCard! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'plp 6/22/2021 20:21:07'!
expiredCreditCard

	| expirationDate validNumber validOwner |
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) monthNumber: (today monthNumber) - 1.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
	
	^ CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'plp 6/22/2021 20:19:20'!
notExpiredCreditCard
	
	| expirationDate validNumber validOwner |
	expirationDate := GregorianMonthOfYear yearNumber: (today year number) +1 monthNumber: today monthNumber.
	validOwner := 'Alan Kay'.
	validNumber := 1234567890123456.
	
	^ CreditCard withNumber: validNumber owner: validOwner expiresOn: expirationDate.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'plp 6/22/2021 20:21:46'!
initialize

	today := GregorianMonthOfYear current.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
