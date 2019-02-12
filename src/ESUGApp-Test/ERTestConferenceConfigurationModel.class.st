Class {
	#name : #ERTestConferenceConfigurationModel,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test'
}

{ #category : #'as yet unclassified' }
ERTestConferenceConfigurationModel >> messageInvalidDate [
	^ 'This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateFromFieldWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: '30/30/2019'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateSubmissionDeadlineFieldWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: '30/30/2000'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateToFieldWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateTo: '30/30/2000'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateFromField [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateSubmissionDeadlineField [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateToField [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateTo: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyEarlyRegistrationDeadlineField [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) earlyRegistrationDeadline: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyNameField [
	| errors conference |
	conference := (self class testConferenceConfigurationModel)
						 name: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]
