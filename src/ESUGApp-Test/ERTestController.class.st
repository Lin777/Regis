Class {
	#name : #ERTestController,
	#superclass : #ERTest,
	#category : #'ESUGApp-Test'
}

{ #category : #initialization }
ERTestController >> setUp [
	super setUp.
	controller := ERController new
]

{ #category : #tests }
ERTestController >> testAmountToPay [
]

{ #category : #initialization }
ERTestController >> testConferenceIsOpenRegistration [
	controller conference configuration openRegistration: true.
	self assert: controller conferenceIsOpenRegistration . 
	
	controller conference configuration openRegistration: false.
	self deny: controller conferenceIsOpenRegistration .
]
