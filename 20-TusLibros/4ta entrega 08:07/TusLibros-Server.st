!classDefinition: #TusLibrosServerRestInterface category: 'TusLibros-Server'!
Panel subclass: #TusLibrosServerRestInterface
	instanceVariableNames: 'webServer port tusLibrosFacade tusLibros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 15:43:50'!
checkOutCart: cartId forUser: user

	| card |
	card := (self usersCards) at: user ifAbsent: [ self error: 'Invalid Card'].
	^tusLibros checkOutCartIdentifiedAs: cartId 
				withCreditCardNumbered: card key 
				ownedBy:  user
				expiringOn: card value.
	! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 16:33:03'!
initializeWith: aPortNumber

	tusLibros := self tusLibrosFacade.
		
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: self port.
	
	webServer addService: '/createCart' action:[:request | 
		[ | password user | 
			user := (request fields at: 'user').
			password := (request fields at: 'password').
			request send200Response: (WebUtils jsonEncode: (tusLibros createCartFor: user authenticatedWith: password)) 
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/listCatalog' action:[:request | 
		[ 
			request send200Response: (WebUtils jsonEncode: (self listParsedCatalog)) 
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/listCart' action:[:request | 
		[ | cartId items | 
			cartId := (request fields at: 'cartId') asNumber .
			items := tusLibros listCartIdentifiedAs: cartId.
			request send200Response: (WebUtils jsonEncode: (self parseItems: items)) 
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/addToCart' action:[:request | 
		[ | cartId isbn quantity | 
			cartId := (request fields at: 'cartId') asNumber.
			isbn := (request fields at: 'isbn').
			quantity := (request fields at: 'quantity') asNumber.
			tusLibros add: quantity of: isbn  toCartIdentifiedAs: cartId.
			request send200Response: (WebUtils jsonEncode: true).
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/removeFromCart' action:[:request | 
		[ | cartId isbn | 
			cartId := (request fields at: 'cartId') asNumber.
			isbn := (request fields at: 'isbn').
			tusLibros remove: isbn fromCartIdentifiedAd: cartId.
			request send200Response: (WebUtils jsonEncode: true).
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/checkOutCart' action:[:request | 
		[ | cartId user ticket | 
			cartId := (request fields at: 'cartId') asNumber.
			user := (request fields at: 'user').
			ticket := self checkOutCart: cartId forUser: user.
			request send200Response: (WebUtils jsonEncode: (self parseTicket: ticket)) 
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	
	webServer addService: '/listPurchases' action:[:request | 
		[ | password user purchases | 
			user := (request fields at: 'user').
			password := (request fields at: 'password').
			purchases := tusLibros listPurchasesOf: user authenticatingWith: password.
			request send200Response: (WebUtils jsonEncode: (self parsePurchases: purchases)) 
		] 
		on: Error 
		do: [ :anError |
			request send400Response: (anError messageText) ]].
	! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 13:47:11'!
listCatalog

	^ tusLibros listCatalog! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 13:57:31'!
listParsedCatalog

	| parsedCatalog |
	
	parsedCatalog := OrderedCollection new.
	(self listCatalog) keysAndValuesDo: [:isbn :item | 
		parsedCatalog add: ( isbn , ' - ' , item key , ' - $' , item value asString)].

	^parsedCatalog asArray.! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 14:00:36'!
parseItems: items

		
	| catalog parsedItems |
	catalog := self listCatalog.
	parsedItems := OrderedCollection new.
	parsedItems := items collect: [:isbn | (isbn , ' - ' ,(catalog at: isbn) key)].
	^parsedItems asArray.
! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 16:40:53'!
parsePurchases: purchases
	| parsed catalog |
	parsed := OrderedCollection new.
	catalog := self listCatalog.
	purchases keysAndValuesDo: [:isbn :quantity | | title | 
		title:= (catalog at: isbn) key.
		parsed add: isbn, ' - ', title,  ' - $' , quantity asString ].
^	parsed asArray.! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 16:50:14'!
parseTicket: ticket
	| ticketParsed catalog |
	ticketParsed := OrderedCollection new.
	catalog := self listCatalog.
	ticket lineItemsDo: [ :item | | title | 
		title := (catalog at: item item) key.
		ticketParsed add: (item item, ' - ', title ,' - $' , item total asString) ].
	ticketParsed add: 'Total: $',ticket total asString.
	^ticketParsed asArray.
! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/7/2021 14:30:35'!
port
	
	^port ifNil: [port:=8080].
	! !

!TusLibrosServerRestInterface methodsFor: 'initialization' stamp: 'JN 7/8/2021 14:51:57'!
usersCards
	| usersCards testObjects |
	usersCards := Dictionary new.
	testObjects := StoreTestObjectsFactory new .
	usersCards add: self validUser -> (testObjects notExpiredCreditCardNumber -> testObjects notExpiredMonthOfYear).
	usersCards add: self validUserInvalidCard -> (testObjects notExpiredCreditCardNumber -> testObjects expiredMonthOfYear ).
	^usersCards.! !


!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/7/2021 14:44:43'!
createSalesBook

	^OrderedCollection new! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/8/2021 15:57:27'!
debit: anAmount from: aCreditCard
! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/7/2021 14:45:00'!
merchantProcessor

	^self! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/7/2021 15:31:47'!
tusLibrosFacade

	| clock testObjectsFactory |
	testObjectsFactory := StoreTestObjectsFactory new.
	clock := ManualClock now: testObjectsFactory today.
	^ TusLibrosSystemFacade
		authenticatingWith: self validUsersAndPasswords
		acceptingItemsOf: testObjectsFactory defaultCatalog
		registeringOn: self createSalesBook
		debitingThrought: self merchantProcessor
		measuringTimeWith: clock.! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/7/2021 14:44:19'!
validUser

	^'validUser'! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/8/2021 14:27:07'!
validUserInvalidCard

	^'validUserInvalidCard'! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/7/2021 14:44:12'!
validUserPassword

	^'validUserPassword'! !

!TusLibrosServerRestInterface methodsFor: 'facade' stamp: 'JN 7/8/2021 14:26:58'!
validUsersAndPasswords

	^Dictionary new
		at: self validUser put: self validUserPassword;
		at: self validUserInvalidCard put: self validUserPassword;
		yourself! !


!TusLibrosServerRestInterface methodsFor: 'enabling services' stamp: 'JN 7/7/2021 14:29:35'!
destroy
	
	webServer ifNotNil:[webServer destroy].
	! !

!TusLibrosServerRestInterface methodsFor: 'enabling services' stamp: 'JN 7/7/2021 14:30:06'!
startListening
	
	webServer startListener.

	^'Listening on port: ', self port asString.
	! !

!TusLibrosServerRestInterface methodsFor: 'enabling services' stamp: 'JN 7/7/2021 14:30:13'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerRestInterface class' category: 'TusLibros-Server'!
TusLibrosServerRestInterface class
	instanceVariableNames: ''!

!TusLibrosServerRestInterface class methodsFor: 'instance creation' stamp: 'JN 7/7/2021 14:24:39'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber.! !
