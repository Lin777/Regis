"
Description
--------------------

A ERTestConferenceConfigurationModel is a test class for testing the behavior of ERConferenceConfigurationModel
"
Class {
	#name : #ERConferenceConfigurationModelTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #assertions }
ERConferenceConfigurationModelTest >> assertInvalidDate: anOnject [
	|errors|
	errors := anOnject asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: self messageInvalidDate equals: (self messageTextOf: errors)
]

{ #category : #message }
ERConferenceConfigurationModelTest >> messageInvalidDate [
	^ 'This field only supports dates with the following format "MM/DD/YYYY"'
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testDateFromFieldWithoutDateFormat [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: '30/30/2019'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testDateSubmissionDeadlineFieldWithoutDateFormat [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: '30/30/2000'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testDateToFieldWithoutDateFormat [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateTo: '30/30/2000'; yourself .
	self assertInvalidDate: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testEmptyDateFromField [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateFrom: nil; yourself .
	self assertEmptyField: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testEmptyDateSubmissionDeadlineField [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateSubmissionDeadline: nil; yourself .
	self assertEmptyField: conference 
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testEmptyDateToField [

	| conference |
	conference := (self class testConferenceConfigurationModel) dateTo: nil; yourself .
	self assertEmptyField: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testEmptyEarlyRegistrationDeadlineField [

	| conference |
	conference := (self class testConferenceConfigurationModel) earlyRegistrationDeadline: nil; yourself.
	self assertEmptyField: conference
]

{ #category : #tests }
ERConferenceConfigurationModelTest >> testEmptyNameField [

	| conference |
	conference := (self class testConferenceConfigurationModel)
						 name: nil; yourself.
	self assertEmptyField: conference
]
