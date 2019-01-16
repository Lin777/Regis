Class {
	#name : #ERTabForAForm,
	#superclass : #ERContentTab,
	#instVars : [
		'form'
	],
	#category : #'ESUGApp-Component'
}

{ #category : #accessing }
ERTabForAForm class >> form: aForm withContainer: aContainer [
	| tab |
	tab := self new.
	tab form: aForm.
	tab container: aContainer.
	^ tab
]

{ #category : #accessing }
ERTabForAForm >> form: anObject [
	form := anObject
]

{ #category : #rendering }
ERTabForAForm >> renderContentOn: html [
	html render: form
]

{ #category : #rendering }
ERTabForAForm >> renderFormOn: html [
	html render: form
]

{ #category : #rendering }
ERTabForAForm >> tabId [
	^ form formId
]

{ #category : #rendering }
ERTabForAForm >> tabName [
	^ form formName
]
