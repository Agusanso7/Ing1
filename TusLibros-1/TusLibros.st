!classDefinition: #CarritoTest category: #TusLibros stamp: 'a s 10/31/2019 17:10:19'!
TestCase subclass: #CarritoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 16:48:06'!
test01CarritoNuevoEstaVacio

	| carrito |
	
	carrito := Carrito new.
	
	self assert: carrito isEmpty.! !

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 16:44:23'!
test02CarritoConUnItemNoEstaVacio

	| carrito |
	
	carrito := Carrito new.
	
	carrito add: 'elemento'.
	
	self deny: carrito isEmpty
	! !

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 16:52:59'!
test03ElCarritoNoContieneItemsQueNoFueronAgregados

	| carrito |
	
	carrito := Carrito new.
		
	self deny: (carrito hasItem: 'cosa')
	! !

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 17:07:54'!
test04ElCarritoContieneUnItemSiEsteFueAgregado

	| carrito |
	
	carrito := Carrito new.
	
	carrito add: 'cosa'.
		
	self assert: (carrito hasItem: 'cosa')
	! !

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 17:08:01'!
test05ElCarritoContiene0VecesUnItemNoAgregado

	| carrito |
	
	carrito := Carrito new.
	
	self assert: (carrito times: 'algo') equals: 0.! !

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 17:08:49'!
test06ElCarritoContiene2VecesUnItemAgregado2Veces

	| carrito |
	
	carrito := Carrito new.
	
	carrito add: 'cosa'.
	carrito add: 'cosa'.
		
	self assert: (carrito times: 'cosa') equals: 2.
	! !


!classDefinition: #Carrito category: #TusLibros stamp: 'a s 10/31/2019 17:10:19'!
Object subclass: #Carrito
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Carrito methodsFor: 'comparing' stamp: 'a s 10/31/2019 16:47:05'!
isEmpty
	
	^ elements isEmpty! !


!Carrito methodsFor: 'adding' stamp: 'a s 10/31/2019 16:46:05'!
add: anElement
	
	elements add: anElement! !


!Carrito methodsFor: 'initialization' stamp: 'a s 10/31/2019 16:48:59'!
initialize

	elements := OrderedCollection new.! !


!Carrito methodsFor: 'testing' stamp: 'a s 10/31/2019 16:55:28'!
hasItem: anItem

	^ elements includes: anItem
	
	! !

!Carrito methodsFor: 'testing' stamp: 'a s 10/31/2019 17:10:02'!
times: anItem

	^ elements occurrencesOf: anItem! !
