"
TODO when we will have a nice MDLCalendar
"
Class {
	#name : #MDLMADateInputComponent,
	#superclass : #MADateInputComponent,
	#instVars : [
		'date'
	],
	#category : #'ESUGApp-MDLMagritte'
}

{ #category : #rendering }
MDLMADateInputComponent >> choose [
	| calendar |
	calendar := MDLCalendar new.
	calendar
		currentDate: ((self value notNil
			and: [ self magritteDescription isSatisfiedBy: self value ])
				ifFalse: [ Date current ]
				ifTrue: [ self value ]);
		callback: [ :value | calendar answer: value ].
	self chooser: calendar
]
