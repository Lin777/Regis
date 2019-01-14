Class {
	#name : #ERPercentageDiscount,
	#superclass : #ERDiscountStrategy,
	#instVars : [
		'percentage'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #'instance creation' }
ERPercentageDiscount class >> of: aPercentage [
	^ self new
		percentage: aPercentage;
		yourself
]

{ #category : #accessing }
ERPercentageDiscount >> description [
	^ 'Discount of ' , percentage asString , ' %'
]

{ #category : #initialization }
ERPercentageDiscount >> initialize [
	super initialize.
]

{ #category : #accessing }
ERPercentageDiscount >> percentage [
	^ percentage
]

{ #category : #accessing }
ERPercentageDiscount >> percentage: anObject [
	percentage := anObject
]
