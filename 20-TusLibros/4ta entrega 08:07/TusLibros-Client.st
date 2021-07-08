!classDefinition: #TusLibrosClientErrorWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientErrorWindow
	instanceVariableNames: 'errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 20:51:53'!
buildErrorRow
	| errorRowLayoutMorph |
	
	errorRowLayoutMorph := LayoutMorph newRow.
	errorRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents: errorMessage).
		
	^errorRowLayoutMorph.! !

!TusLibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 20:53:25'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildErrorRow.! !

!TusLibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 20:45:48'!
defaultExtent

	^ 400@200
	! !

!TusLibrosClientErrorWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 21:24:49'!
initializeWith: anErrorMessage
	errorMessage := anErrorMessage.
	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: 'Error'.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientErrorWindow class' category: 'TusLibros-Client'!
TusLibrosClientErrorWindow class
	instanceVariableNames: ''!

!TusLibrosClientErrorWindow class methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 20:42:43'!
openWith: errorMessage
	
	^self new initializeWith: errorMessage.! !


!classDefinition: #TusLibrosClientHistoryWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientHistoryWindow
	instanceVariableNames: 'historyListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientHistoryWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:27:42'!
buildHistoryColumn

	| historyLayoutMorph homeButtonMorph |

	homeButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #goHome  label: 'Home'.

	historyListMorph := PluggableListMorph model: self model listGetter: #history indexGetter: #historyListIndex indexSetter: #historyListIndex:.
	historyListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:400.
	
	historyLayoutMorph := LayoutMorph newColumn.
	historyLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'History');
	addMorph: historyListMorph;
	addMorph: homeButtonMorph.
	^historyLayoutMorph.! !

!TusLibrosClientHistoryWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:42:01'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildHistoryColumn.
! !

!TusLibrosClientHistoryWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:58:30'!
defaultExtent

	^ 535@485
	
	! !

!TusLibrosClientHistoryWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:10:55'!
goHome

	self closeButtonClicked.
! !

!TusLibrosClientHistoryWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:55:21'!
initializeWith: aTitle and: anUser authenticatedWith: aPassword

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientHistoryWindowModel for: anUser authenticatedWith: aPassword).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientHistoryWindow class' category: 'TusLibros-Client'!
TusLibrosClientHistoryWindow class
	instanceVariableNames: ''!

!TusLibrosClientHistoryWindow class methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:52:46'!
openFor: anUser authenticatedWith: aPassword
	
	^self new initializeWith: 'Tus Libros - History' and: anUser authenticatedWith: aPassword! !


!classDefinition: #TusLibrosClientHomeWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientHomeWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:10:10'!
buildHistoryRow

	| historyRowLayoutMorph historyButtonMorph |
	
	historyButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #showHistory  label: 'My History'.
	
	historyRowLayoutMorph := LayoutMorph newRow.
	historyRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: historyButtonMorph.
		
	^historyRowLayoutMorph.! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:45:32'!
buildLogOutRow

	| logOutRowLayoutMorph logOutButtonMorph |
	
	logOutButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #logOut  label: 'Log Out'.
	
	logOutRowLayoutMorph := LayoutMorph newRow.
	logOutRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: logOutButtonMorph.
		
	^logOutRowLayoutMorph.! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:23:50'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildHistoryRow;
	addMorph: self buildStoreRow;
	addMorph: self buildLogOutRow.
! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:23:50'!
buildStoreRow

	| cartRowLayoutMorph cartButtonMorph |
	
	cartButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #showStore  label: 'Store'.
	
	cartRowLayoutMorph := LayoutMorph newRow.
	cartRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: cartButtonMorph.
		
	^cartRowLayoutMorph.! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:32:03'!
defaultExtent

	^ 535@485
	
	! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:54:53'!
initializeWith: aTitle and: aCartId from: anUser authenticatedWith: aPassword  

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientHomeWindowModel for: aCartId from: anUser authenticatedWith: aPassword).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:39:22'!
logOut

	TusLibrosClientLogInWindow open.
	self closeButtonClicked.! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:50:39'!
showHistory

	TusLibrosClientHistoryWindow openFor: self model user authenticatedWith: self model password.
! !

!TusLibrosClientHomeWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 14:58:01'!
showStore

	TusLibrosClientStoreWindow openFor: self model cartId and: self model user.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientHomeWindow class' category: 'TusLibros-Client'!
TusLibrosClientHomeWindow class
	instanceVariableNames: ''!

!TusLibrosClientHomeWindow class methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 21:50:45'!
openFor: aCartId from: anUser authenticatedWith: aPassword
	
	^self new initializeWith: 'Tus Libros - Home' and: aCartId from: anUser authenticatedWith: aPassword! !


!classDefinition: #TusLibrosClientLogInWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientLogInWindow
	instanceVariableNames: 'userTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 23:24:32'!
buildCreateCartRow
	| createCartRowLayoutMorph createCartButtonMorph |
	
	 
	createCartButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendCreateCartRequest  label: 'Log In'.
	
	createCartRowLayoutMorph := LayoutMorph newRow.
	createCartRowLayoutMorph separation: 25;
	axisEdgeWeight: 0.5;
 	addMorph: createCartButtonMorph.
		
	^createCartRowLayoutMorph.! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 20:37:21'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildUserRow;
	addMorph: self buildPasswordRow;
	addMorph: self buildCreateCartRow.
! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 22:28:11'!
buildPasswordRow
	| passwordRowLayoutMorph |
	
	passwordTextBoxMorph := TextModelMorph textProvider: self model textGetter: #passwordText textSetter: #passwordText:. 
	passwordTextBoxMorph textMorph setProperty: #keyStroke: toValue: [ :key | passwordTextBoxMorph textMorph acceptContents ] .
	passwordTextBoxMorph  morphHeight: 30; borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
	
	passwordRowLayoutMorph := LayoutMorph newRow.
	passwordRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'Password:');
 	addMorph: passwordTextBoxMorph.
		
	^passwordRowLayoutMorph.! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 22:29:46'!
buildUserRow
	| userRowLayoutMorph |
	
	userTextBoxMorph := TextModelMorph textProvider: self model textGetter: #userText textSetter: #userText:. 
	userTextBoxMorph textMorph setProperty: #keyStroke: toValue: [ :key | userTextBoxMorph textMorph acceptContents ] .
	userTextBoxMorph  morphHeight: 30; borderWidth: 1; borderColor: Color skyBlue; morphWidth: 300. 
	
	userRowLayoutMorph := LayoutMorph newRow.
	userRowLayoutMorph separation: 25;
	addMorph: (LabelMorph contents:'User:       ');
 	addMorph: userTextBoxMorph.
		
	^userRowLayoutMorph.! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 22:31:02'!
defaultExtent

	^ 535@485
	! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/8/2021 03:22:52'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientLogInWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self model when: #authenticationFailed send: #showError to: self.	
	self model when: #successfullLogIn send: #showHome to: self.	
! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/8/2021 03:22:52'!
showError 

	TusLibrosClientErrorWindow openWith: self model errorMessage! !

!TusLibrosClientLogInWindow methodsFor: 'initialization' stamp: 'JN 7/7/2021 22:33:42'!
showHome 

	TusLibrosClientHomeWindow 
		openFor: (self model cartId)
		from: (self model userText)
		authenticatedWith: (self model passwordText).
		
	self closeButtonClicked.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientLogInWindow class' category: 'TusLibros-Client'!
TusLibrosClientLogInWindow class
	instanceVariableNames: ''!

!TusLibrosClientLogInWindow class methodsFor: 'instance creation' stamp: 'JN 7/7/2021 14:10:42'!
open
	
	^self new initializeWith: 'Tus Libros'.! !


!classDefinition: #TusLibrosClientLogInWindowModel category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientLogInWindowModel
	instanceVariableNames: 'user cartId restInterface password errorMessage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 21:52:28'!
cartId

	^cartId! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 20:41:59'!
errorMessage

	^errorMessage! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 02:58:12'!
initialize

	cartId := nil.
	restInterface := TusLibrosClientRest new.
	user := ''.
	password := ''.
	errorMessage := ''.! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 19:37:17'!
passwordText

	^password! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 19:37:31'!
passwordText: aPassword

	password := aPassword.
	^true.! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 02:07:34'!
sendCreateCartRequest
	[ 
		cartId := restInterface createCartFor: user authenticatedWith: password.
		self triggerEvent: #successfullLogIn with: self.
	]	
		on: Error 
		do: [ :anError |
			errorMessage := 'Authentication Failed'.
			self triggerEvent: #authenticationFailed with: self.
		].
	
	
	! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 18:56:36'!
userText

	^user! !

!TusLibrosClientLogInWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 18:57:01'!
userText: aUser

	user := aUser.
	^true.! !


!classDefinition: #TusLibrosClientRest category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientRest
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 12:16:30'!
add: quantityToAdd of: anItem to: cartId

	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'quantity'.quantityToAdd.},
		{'isbn'.anItem substrings first },
		{'cartId'.cartId }.		
	endpoint := '/addToCart'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 16:00:01'!
checkOutCart: aCartId forUser: anUser

	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'user'.anUser.},
		{'cartId'.aCartId}.		
	endpoint := '/checkOutCart'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/7/2021 14:17:51'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'. ! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/7/2021 21:19:00'!
createCartFor: user authenticatedWith: password

	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'user'.user.},
		{'password'.password}.		
	endpoint := '/createCart'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 16:31:47'!
getHistoryFor: user authenticatedWith: password

	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'user'.user.},
		{'password'.password}.		
	endpoint := '/listPurchases'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 02:05:28'!
listCart: cartId
		
	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'cartId'.cartId.}.		
	endpoint := '/listCart'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 02:14:03'!
listCatalog

	| resp endpoint |
			
	endpoint := '/listCatalog'.
	resp := WebClient httpGet: (self url,endpoint).
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !

!TusLibrosClientRest methodsFor: 'sending requests' stamp: 'JN 7/8/2021 12:53:31'!
remove: anItem from: cartId

	| resp fieldDict endpoint |
	fieldDict := Dictionary newFromPairs: 
		{'isbn'.anItem substrings first },
		{'cartId'.cartId }.		
	endpoint := '/removeFromCart'.
	resp := WebClient htmlSubmit: (self url,endpoint) fields: fieldDict.
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: (resp content)].! !


!TusLibrosClientRest methodsFor: 'initialization' stamp: 'JN 7/7/2021 14:17:39'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosClientRest methodsFor: 'initialization' stamp: 'JN 7/7/2021 14:17:31'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosClientStoreWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientStoreWindow
	instanceVariableNames: 'quantityTextBoxMorph catalogListMorph cartListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:51:28'!
buildCartActionsRow

	| removeFromCartButton buttonsRowLayoutMorph |
	
	removeFromCartButton := PluggableButtonMorph model: self model stateGetter: nil action: #sendRemoveFromCartRequest  label: 'Remove'.

	
	buttonsRowLayoutMorph := LayoutMorph newRow.
	buttonsRowLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	morphHeight: 100;
	addMorph: removeFromCartButton.

	^buttonsRowLayoutMorph.! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:22:05'!
buildCartColumn

	| catalogColumnLayoutMorph checkOutButtonMorph |

	checkOutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil action: #sendCheckOutCartRequest  label: 'Check Out'.

	cartListMorph := PluggableListMorph model: self model listGetter: #cart indexGetter: #cartListIndex indexSetter: #cartListIndex:.
	cartListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:400.
	
	catalogColumnLayoutMorph := LayoutMorph newColumn.
	catalogColumnLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Cart');
	addMorph: cartListMorph;
	addMorph: self buildCartActionsRow;
	addMorph: checkOutButtonMorph.
	^catalogColumnLayoutMorph.! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:56:24'!
buildCatalogActionsRow

	| addToCartButton buttonsRowLayoutMorph |
	
	addToCartButton := PluggableButtonMorph model: self model stateGetter: nil action: #sendAddToCartRequest  label: 'Add To Cart'.
	quantityTextBoxMorph := TextModelMorph textProvider: self model textGetter: #quantityToAddText textSetter: #quantityToAddText:. 
	quantityTextBoxMorph textMorph setProperty: #keyStroke: toValue: [ :key | quantityTextBoxMorph textMorph acceptContents ] .
	quantityTextBoxMorph  morphHeight: 30; borderWidth: 1; borderColor: Color skyBlue; morphWidth: 50. 
	
	
	
	buttonsRowLayoutMorph := LayoutMorph newRow.
	buttonsRowLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	morphHeight: 100;
	addMorph: (LabelMorph contents:'Quantity:');
	addMorph: quantityTextBoxMorph;
	addMorph: addToCartButton.

	^buttonsRowLayoutMorph.! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:48:49'!
buildCatalogColumn

	| catalogColumnLayoutMorph goHomeButtonMorph |

	goHomeButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #goHome  label: 'Home'.
	
	catalogListMorph := PluggableListMorph model: self model listGetter: #catalog indexGetter: #itemsListIndex indexSetter: #itemsListIndex:.
	catalogListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:400.
	
	catalogColumnLayoutMorph := LayoutMorph newColumn.
	catalogColumnLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Catalog');
	addMorph: catalogListMorph;
	addMorph: self buildCatalogActionsRow;
	addMorph: goHomeButtonMorph.
	^catalogColumnLayoutMorph.! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:22:05'!
buildMorphicWindow
		
	self layoutMorph beRow;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self buildCatalogColumn;
	addMorph: self buildCartColumn .
! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:32:46'!
defaultExtent

	^ 1135@485
	! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:33:01'!
goHome

	self closeButtonClicked.

	! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:01:41'!
initializeWith: aTitle andCart: aCartId andUser: aUser

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientStoreWindowModel for: aCartId and: aUser).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
	self model when: #throwError send: #showError to: self.	
	self model when: #refreshCart send: #refreshCart to: self.	
	self model when: #showTicket send: #showTicket to: self.	
! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:00:18'!
refreshCart

	cartListMorph updateList.
	cartListMorph setSelectionIndex: 0.
	

	! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:04:50'!
showError 

	TusLibrosClientErrorWindow openWith: self model errorMessage

	! !

!TusLibrosClientStoreWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:23:30'!
showTicket

	TusLibrosClientTicketWindow openWith: self model ticket.
	self closeButtonClicked.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientStoreWindow class' category: 'TusLibros-Client'!
TusLibrosClientStoreWindow class
	instanceVariableNames: ''!

!TusLibrosClientStoreWindow class methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 14:57:39'!
openFor: aCartId and: aUser
	
	^self new initializeWith: 'Tus Libros - Store' andCart: aCartId andUser: aUser.! !


!classDefinition: #TusLibrosClientTicketWindow category: 'TusLibros-Client'!
Panel subclass: #TusLibrosClientTicketWindow
	instanceVariableNames: 'ticketListMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientTicketWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:22:37'!
buildMorphicWindow
	
	self layoutMorph beColumn;
	separation: 0;
	axisEdgeWeight: 0;
	addMorph: self buildTicketColumn .
! !

!TusLibrosClientTicketWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:45:28'!
buildTicketColumn

	| ticketLayoutMorph logOutButtonMorph |

	logOutButtonMorph := PluggableButtonMorph model: self stateGetter: nil action: #logOut  label: 'Log Out'.

	ticketListMorph := PluggableListMorph model: self model listGetter: #ticket indexGetter: #ticketListIndex indexSetter: #ticketListIndex:.
	ticketListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:400.
	
	ticketLayoutMorph := LayoutMorph newColumn.
	ticketLayoutMorph separation: 5;
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Ticket');
	addMorph: ticketListMorph;
	addMorph: logOutButtonMorph.
	^ticketLayoutMorph.! !

!TusLibrosClientTicketWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:28:16'!
defaultExtent

	^ 535@485
	! !

!TusLibrosClientTicketWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:11:31'!
initializeWith: aTitle and: ticket

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientTicketWindowModel for: ticket).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
	
! !

!TusLibrosClientTicketWindow methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:23:16'!
logOut

	TusLibrosClientLogInWindow open.
	self closeButtonClicked.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientTicketWindow class' category: 'TusLibros-Client'!
TusLibrosClientTicketWindow class
	instanceVariableNames: ''!

!TusLibrosClientTicketWindow class methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:10:31'!
openWith: ticket 
	
	^self new initializeWith: 'Tus Libros - Ticket' and: ticket.! !


!classDefinition: #TusLibrosClientHistoryWindowModel category: 'TusLibros-Client'!
Object subclass: #TusLibrosClientHistoryWindowModel
	instanceVariableNames: 'user password restInterface history historySelectedIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:29:31'!
history 

	^history! !

!TusLibrosClientHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:41:31'!
historyListIndex

	^historySelectedIndex.! !

!TusLibrosClientHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:41:24'!
historyListIndex: index

	historySelectedIndex := index.! !

!TusLibrosClientHistoryWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:31:06'!
initializeWith: anUser authenticatedWith: aPassword

	user := anUser.
	password := aPassword.
	restInterface := TusLibrosClientRest new.
	history := restInterface getHistoryFor: user authenticatedWith: password.
	historySelectedIndex := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientHistoryWindowModel class' category: 'TusLibros-Client'!
TusLibrosClientHistoryWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientHistoryWindowModel class methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:55:49'!
for: anUser authenticatedWith: aPassword

	^self new initializeWith: anUser authenticatedWith: aPassword.! !


!classDefinition: #TusLibrosClientHomeWindowModel category: 'TusLibros-Client'!
Object subclass: #TusLibrosClientHomeWindowModel
	instanceVariableNames: 'cartId user password restInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientHomeWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:24:13'!
cartId

	^cartId! !

!TusLibrosClientHomeWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 02:58:12'!
initializeWith: aCartId from: anUser authenticatedWith: aPassword.

	cartId := aCartId.
	user := anUser.
	password := aPassword.
	restInterface := TusLibrosClientRest new.
! !

!TusLibrosClientHomeWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:07:36'!
password

	^password! !

!TusLibrosClientHomeWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 23:07:26'!
user

	^user! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientHomeWindowModel class' category: 'TusLibros-Client'!
TusLibrosClientHomeWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientHomeWindowModel class methodsFor: 'as yet unclassified' stamp: 'JN 7/7/2021 22:42:03'!
for: aCartId from: anUser authenticatedWith: aPassword

	^self new initializeWith: aCartId from: anUser authenticatedWith: aPassword.! !


!classDefinition: #TusLibrosClientStoreWindowModel category: 'TusLibros-Client'!
Object subclass: #TusLibrosClientStoreWindowModel
	instanceVariableNames: 'cartId restInterface cart catalogSelectedIndex cartSelectedIndex quantityToAdd catalog errorMessage user ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:22:29'!
cart
	self refreshCart.
	^cart.
! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:54:17'!
cartListIndex
	
	^cartSelectedIndex.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:54:28'!
cartListIndex: anIndex
	
	cartSelectedIndex := anIndex.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:49:05'!
catalog
	
	^catalog.
! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:05:44'!
errorMessage

	^errorMessage! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 14:56:23'!
initializeWith: aCartId and: aUser

	cartId := aCartId.
	user := aUser.
	restInterface := TusLibrosClientRest new.
	catalog := restInterface listCatalog.
	cart := OrderedCollection new.
	catalogSelectedIndex := 0.
	cartSelectedIndex := 0.
	quantityToAdd := '1'.
	errorMessage := ''.
	
! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:49:37'!
itemsListIndex
	
	^catalogSelectedIndex.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:49:48'!
itemsListIndex: anIndex
	
	catalogSelectedIndex := anIndex.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:42:50'!
quantityToAddText
	
	^quantityToAdd.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:43:01'!
quantityToAddText: aQuantity
	
	quantityToAdd := aQuantity.
! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 11:59:32'!
refreshCart

	cart := restInterface listCart: cartId.! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 13:51:49'!
sendAddToCartRequest
	[ | item | 
		item := (catalog at: catalogSelectedIndex).
		restInterface add: quantityToAdd of: item to: cartId.
		self triggerEvent: #refreshCart with: self.
	]	
		on: Error 
		do: [ :anError |
			errorMessage := 'Add Item To Cart Failed'. 
			self triggerEvent: #throwError with: self.
		].
	! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:49:09'!
sendCheckOutCartRequest
       [ 
		ticket := restInterface checkOutCart: cartId forUser: user.
		self triggerEvent: #showTicket with: self.
	]	
		on: Error 
		do: [ :anError |
			errorMessage := 'Invalid Card'. 
			self triggerEvent: #throwError with: self.
		].
	! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 12:59:29'!
sendRemoveFromCartRequest

	[ | item | 
		item := (cart at: cartSelectedIndex).
		restInterface remove: item from: cartId .
		self triggerEvent: #refreshCart with: self.
	]	
		on: Error 
		do: [ :anError |
			errorMessage := 'Remove Item To Cart Failed'. 
			self triggerEvent: #throwError with: self.
		].
	! !

!TusLibrosClientStoreWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:03:24'!
ticket
	^ticket! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientStoreWindowModel class' category: 'TusLibros-Client'!
TusLibrosClientStoreWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientStoreWindowModel class methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 14:55:47'!
for: aCartId and: user

	^self new initializeWith: aCartId and: user.! !


!classDefinition: #TusLibrosClientTicketWindowModel category: 'TusLibros-Client'!
Object subclass: #TusLibrosClientTicketWindowModel
	instanceVariableNames: 'ticket ticketSelectedIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Client'!

!TusLibrosClientTicketWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:17:54'!
initializeWith: aTicket

	ticket := aTicket.
	ticketSelectedIndex := 0.
	! !

!TusLibrosClientTicketWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:17:01'!
ticket 

	^ticket
	! !

!TusLibrosClientTicketWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:17:44'!
ticketListIndex
	
	^ticketSelectedIndex.! !

!TusLibrosClientTicketWindowModel methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:17:34'!
ticketListIndex: anIndex
	
	ticketSelectedIndex := anIndex.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientTicketWindowModel class' category: 'TusLibros-Client'!
TusLibrosClientTicketWindowModel class
	instanceVariableNames: ''!

!TusLibrosClientTicketWindowModel class methodsFor: 'as yet unclassified' stamp: 'JN 7/8/2021 16:11:51'!
for: ticket

	^self new initializeWith: ticket.! !
