Class {
	#name : #ERPercentageDiscount,
	#superclass : #ERDiscountStrategy,
	#instVars : [
		'percentage'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERPercentageDiscount >> percentage [
	^ percentage
]

{ #category : #accessing }
ERPercentageDiscount >> percentage: anObject [
	percentage := anObject
]
