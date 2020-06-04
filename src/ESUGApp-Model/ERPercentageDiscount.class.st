"
Description
--------------------

I am a model of percentage discount
"
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

{ #category : #'magrittes-descriptions' }
ERPercentageDiscount >> descriptionPercentage [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #percentage; 
		priority: 30;
		required: true;
		withoutLabel: true;
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		id: 'percentage';
		label: 'Percentage (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
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
