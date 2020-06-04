"
Description
--------------------

I am a model of Limited Strategy
"
Class {
	#name : #ERLimitedReductionTicketUse,
	#superclass : #ERLimitStrategy,
	#instVars : [
		'limit'
	],
	#category : #'ESUGApp-Model'
}

{ #category : #'instance creation' }
ERLimitedReductionTicketUse class >> of: aLimitNumber [
	^ self new limit: aLimitNumber ; yourself 
]

{ #category : #accessing }
ERLimitedReductionTicketUse >> description [
	^ 'Used limited to ' , limit asString 
]

{ #category : #'magrittes-descriptions' }
ERLimitedReductionTicketUse >> descriptionLimit [
	<magritteDescription>
	| tmp |
	tmp := MANumberDescription new.
	tmp 
		accessor: #limit; 
		priority: 50;
		required: true;
		addCondition: [ :value | value >= 0 ]
  		labelled: 'Need to be a positive number';
		withoutLabel: true;
		id: 'limit';
		label: 'Limit (Required)';
		componentClass: MDLMATextInputComponent.
	^ tmp yourself
]

{ #category : #accessing }
ERLimitedReductionTicketUse >> limit [
	^ limit
]

{ #category : #accessing }
ERLimitedReductionTicketUse >> limit: anObject [
	limit := anObject
]
