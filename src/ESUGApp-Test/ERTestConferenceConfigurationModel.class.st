Class {
	#name : #ERTestConferenceConfigurationModel,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestConferenceConfigurationModel >> assertInvalidDate: anOnject [
	|errors|
	errors := anOnject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (self messageTextOf: errors)
]

{ #category : #'as yet unclassified' }
ERTestConferenceConfigurationModel >> messageInvalidDate [
	^ 'This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateFromFieldWithoutDateFormat [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: '30/30/2019'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateSubmissionDeadlineFieldWithoutDateFormat [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: '30/30/2000'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testDateToFieldWithoutDateFormat [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateTo: '30/30/2000'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateFromField [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: nil; yourself .
	self assertEmptyField: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateSubmissionDeadlineField [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: nil; yourself .
	self assertEmptyField: conference 
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyDateToField [
	| conference |
	conference := (self class testConferenceConfigurationModel) dateTo: nil; yourself .
	self assertEmptyField: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyEarlyRegistrationDeadlineField [
	| conference |
	conference := (self class testConferenceConfigurationModel) earlyRegistrationDeadline: nil; yourself .
	self assertEmptyField: conference
]

{ #category : #tests }
ERTestConferenceConfigurationModel >> testEmptyNameField [
	| conference |
	conference := (self class testConferenceConfigurationModel)
						 name: nil; yourself .
	self assertEmptyField: conference
]
