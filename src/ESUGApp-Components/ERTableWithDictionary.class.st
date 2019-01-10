Class {
	#name : #ERTableWithDictionary,
	#superclass : #ERTableGenericData,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERTableWithDictionary >> renderBody: html [
	html
		tableBody: [ listObject
				do: [ :object | html tableRow: [ headers do: [ :each | html mdlTableHeading: (object at: each) ] ] ] ]
]
