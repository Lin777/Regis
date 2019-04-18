"
I am a model of discount strategy
"
Class {
	#name : #ERDiscountStrategy,
	#superclass : #Object,
	#category : #'ESUGApp-Model'
}

{ #category : #testing }
ERDiscountStrategy class >> isFixStrategy: value [
	^ value = 'Fix Discount' 
]

{ #category : #testing }
ERDiscountStrategy class >> isPercentageStrategy: value [
	^ value = 'Percentage Discount'
]

{ #category : #'as yet unclassified' }
ERDiscountStrategy class >> typesDiscount [
	^  #('Fix Discount' 'Percentage Discount')
]
