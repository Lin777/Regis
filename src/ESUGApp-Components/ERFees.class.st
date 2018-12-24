Class {
	#name : #ERFees,
	#superclass : #ERConfiguration,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERFees >> renderContainer: html [
	html horizontalRule.
]

{ #category : #accessing }
ERFees >> tabId [
	^ 'fees'
]

{ #category : #accessing }
ERFees >> tabName [
	^ 'Fees'
]

{ #category : #accessing }
ERFees >> title [
	^ 'Fees'
]
