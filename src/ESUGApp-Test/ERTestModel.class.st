Class {
	#name : #ERTestModel,
	#superclass : #ERTestControllers,
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestModel >> testValidateUserAccount [
	self class testUserAccount asComponent validate; errors.
]
