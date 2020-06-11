"
Description
--------------------

I am a personalized table, I render a dictionary in tab format
"
Class {
	#name : #ERDictionaryTable,
	#superclass : #PSSortedTableDictionaryComponent,
	#category : #'ESUGApp-Component'
}

{ #category : #'rendering-table' }
ERDictionaryTable >> render: html with: anObject [
	"Render object on html"

	""
]

{ #category : #rendering }
ERDictionaryTable >> renderRowsOn: html [
	html
		tableBody: [ rows
				do: [ :object | html tableRow: [ 
						header do: 
							[ :each | html mdlTableCell nonNumerical; with:(object at: each) ] ] ] ]
]

{ #category : #rendering }
ERDictionaryTable >> renderTableBodyOn: html [
	html
		tableBody: [ rows
				do: [ :object | html tableRow: [ 
						header do: 
							[ :each | html mdlTableCell nonNumerical; with:(object at: each) ] ] ] ]
]

{ #category : #rendering }
ERDictionaryTable >> renderTotalRows: html [
]

{ #category : #'rendering-searching' }
ERDictionaryTable >> validateFilterOf: anObject [
	
	""
]
