!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 20:51:02'!
* unNumeroDePeano

	^ unNumeroDePeano ! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 18:50:35'!
+ unNumeroDePeano

	^ unNumeroDePeano next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:59:03'!
- unNumeroDePeano
	"
	self assert: false.
	"
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:19:36'!
/ unNumeroDePeano
	
	unNumeroDePeano  > self ifTrue:[
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].

	^ I.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:16:59'!
> unNumeroDePeano
	^ false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:16:30'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor!!'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:58:56'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados!!'! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 18:25:18'!
next

	^ II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 19:10:01'!
previous

	self assert: false.! !

!I class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:12:02'!
restaInversa: unNumeroDePeano

	^ unNumeroDePeano previous.! !


!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:15:57'!
* unNumeroDePeano
	"|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self.
	] ifFalse:[
			resultado := self * unNumeroDePeano previous + self.
	].

	^ resultado"
	
	^ self previous * unNumeroDePeano  + unNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 18:56:52'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:08:58'!
- unNumeroDePeano
	"
	|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self previous.
	] ifFalse:[
			resultado := self previous - unNumeroDePeano  previous.
	].

	^ resultado
	"
	^ unNumeroDePeano restaInversa: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:15:26'!
/ unNumeroDePeano

	unNumeroDePeano  > self ifTrue:[
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].

	self = unNumeroDePeano  ifTrue:[
		^ I.
	] ifFalse:[
		^ I + (self - unNumeroDePeano  / unNumeroDePeano). 
	].! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:18:39'!
> unNumeroDePeano

	unNumeroDePeano = I ifTrue:[
		^ true
	] ifFalse: [
		^ self previous  > unNumeroDePeano  previous
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:16:16'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor!!'.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:00:56'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados!!'! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:26:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 19:05:32'!
next

	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].

	^ next! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 18:57:55'!
previous

	^ previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 19:04:46'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/26/2019 18:38:59'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 13:11:18'!
restaInversa: unNumeroDePeano

	^ self previous restaInversa: unNumeroDePeano previous.! !


!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
* unNumeroDePeano
	"|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self.
	] ifFalse:[
			resultado := self * unNumeroDePeano previous + self.
	].

	^ resultado"
	
	^ self previous * unNumeroDePeano  + unNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
- unNumeroDePeano
	"
	|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self previous.
	] ifFalse:[
			resultado := self previous - unNumeroDePeano  previous.
	].

	^ resultado
	"
	^ unNumeroDePeano restaInversa: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
/ unNumeroDePeano

	unNumeroDePeano  > self ifTrue:[
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].

	self = unNumeroDePeano  ifTrue:[
		^ I.
	] ifFalse:[
		^ I + (self - unNumeroDePeano  / unNumeroDePeano). 
	].! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
> unNumeroDePeano

	unNumeroDePeano = I ifTrue:[
		^ true
	] ifFalse: [
		^ self previous  > unNumeroDePeano  previous
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor!!'.! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados!!'! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:26:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
next

	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].

	^ next! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
previous

	^ previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
restaInversa: unNumeroDePeano

	^ self previous restaInversa: unNumeroDePeano previous.! !


!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
* unNumeroDePeano
	"|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self.
	] ifFalse:[
			resultado := self * unNumeroDePeano previous + self.
	].

	^ resultado"
	
	^ self previous * unNumeroDePeano  + unNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
+ unNumeroDePeano

	^ self previous + unNumeroDePeano next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
- unNumeroDePeano
	"
	|resultado|	

	unNumeroDePeano = I ifTrue: [
			resultado := self previous.
	] ifFalse:[
			resultado := self previous - unNumeroDePeano  previous.
	].

	^ resultado
	"
	^ unNumeroDePeano restaInversa: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:22:24'!
/ unNumeroDePeano

	unNumeroDePeano  > self ifTrue:[
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].

	self = unNumeroDePeano  ifTrue:[
		^ I
	] ifFalse:[
		^ I + (self - unNumeroDePeano  / unNumeroDePeano). 
	].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
> unNumeroDePeano

	unNumeroDePeano = I ifTrue:[
		^ true
	] ifFalse: [
		^ self previous  > unNumeroDePeano  previous
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^ 'No se puede dividir por un numero mayor!!'.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados!!'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:26:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
next

	next ifNil: [
		next := self cloneNamed: self name, 'I'.
		next previous: self.
	].

	^ next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
previous

	^ previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
previous: unNumeroDePeano

	previous := unNumeroDePeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'A 8/29/2019 14:20:31'!
restaInversa: unNumeroDePeano

	^ self previous restaInversa: unNumeroDePeano previous.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!