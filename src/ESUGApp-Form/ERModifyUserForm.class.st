Class {
	#name : #ERModifyUserForm,
	#superclass : #ERForm,
	#category : #'ESUGApp-Form'
}

{ #category : #rendering }
ERModifyUserForm >> renderContentOn: html [
	self
		createTextField: 'First Name'
		for: #firstName:
		with: #firstName
		on: html.
	self
		createTextField: 'Last Name'
		for: #lastName:
		with: #lastName
		on: html.
	self
		createTextField: 'Email'
		for: #email:
		with: #email
		on: html.
	
]
