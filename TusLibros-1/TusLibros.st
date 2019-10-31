!classDefinition: #CarritoTest category: #TusLibros stamp: 'a s 10/31/2019 16:56:05'!
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

!CarritoTest methodsFor: 'testing' stamp: 'a s 10/31/2019 16:55:07'!
test04ElCarritoContieneUnItemSiEsteFueAgregado

	| carrito |
	
	carrito := Carrito new.
	
	carrito add: 'cosa'.
		
	self assert: (carrito hasItem: 'cosa')
	! !


!classDefinition: #Carrito category: #TusLibros stamp: 'a s 10/31/2019 16:56:05'!
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
