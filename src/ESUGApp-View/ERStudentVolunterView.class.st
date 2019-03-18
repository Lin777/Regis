Class {
	#name : #ERStudentVolunterView,
	#superclass : #ERTittledView,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-View'
}

{ #category : #rendering }
ERStudentVolunterView >> renderPageOn: html [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'is_register';
				with: 'Email attendee'.
			html mdlTextFieldInput
				id: 'is_register' ] .
			html button: 'Buscar'.
]

{ #category : #rendering }
ERStudentVolunterView >> title [
	^ 'Attendees'
]
