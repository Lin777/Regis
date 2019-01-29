Class {
	#name : #ERUserAccountForRegister,
	#superclass : #ERUserAccount1,
	#category : #'ESUGApp-Model-Magritte'
}

{ #category : #'as yet unclassified' }
ERUserAccountForRegister >> descriptionConfirmPassword [
	<magritteDescription>
	| tmp |
	tmp := MAPasswordDescription new.
	tmp 
		accessor: #confirmPassword; 
		priority: 50;
		beRequired;
		label: 'Confirm Password (Required)';
		withoutLabel: true;
		addCondition: [ :value | self halt.
			self password = value ]
		labelled: 'Don''t match with password';
		componentClass: MDLMATextPasswordComponent.
	^ tmp yourself
]

{ #category : #'as yet unclassified' }
ERUserAccountForRegister >> descriptionPassword [
	<magritteDescription>
	| tmp |
	tmp := MAPasswordDescription new.
	tmp 
		accessor: #password; 
		priority: 40;
		beRequired;
		withoutLabel: true;
		label: 'Password (Required)';
		addCondition: [ :value | value matchesRegex: '[A-Za-z0-9._]{8,}' ]
		labelled: 'The password must have at least 8 characters, and only accepts letters, numbers, slash and dots.';
		componentClass: MDLMATextPasswordComponent.
	^ tmp yourself
]
