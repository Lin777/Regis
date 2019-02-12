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
ERTestConferenceConfigurationModel >> testValidateConfConfigDateFromWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: '30/30/2019'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConfConfigDateSubmissionDeadlineWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: '30/30/2000'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConfConfigDateToWithoutDateFormat [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateTo: '30/30/2000'; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConferenceConfigWithEmptyDateFrom [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConferenceConfigWithEmptyDateSubmissionDeadline [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConferenceConfigWithEmptyDateTo [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) dateTo: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConferenceConfigWithEmptyEarlyRegistrationDeadline [
	| errors conference |
	conference := (self class testConferenceConfigurationModel) earlyRegistrationDeadline: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testValidateConferenceConfigWithEmptyName [
	| errors conference |
	conference := (self class testConferenceConfigurationModel)
						 name: nil; yourself .
	errors := conference asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: messageInputRequired equals: (errors at:1) messageText
]
