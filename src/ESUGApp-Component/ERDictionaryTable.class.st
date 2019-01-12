Class {
	#name : #ERDictionaryTable,
	#superclass : #ERTable,
	#category : #'ESUGApp-Component'
}

{ #category : #rendering }
ERDictionaryTable >> renderBody: html [
	html
		tableBody: [ listObject
				do: [ :object | html tableRow: [ headers do: [ :each | html mdlTableHeading: (object at: each) ] ] ] ]
]
