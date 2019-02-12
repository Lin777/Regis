Class {
	#name : #ERTestConfigurationController,
	#superclass : #ERTestControllers,
	#instVars : [
		'fileNames'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestConfigurationController >> setUp [
	super setUp.
	controller := ERConfigurationController new.
	fileNames := #('attendees.cvs' 'awards.cvs' 
	'groupManagers.cvs' 'talks.cvs' 'users.cvs')
]

{ #category : #running }
ERTestConfigurationController >> tearDown [
	super tearDown.
	fileNames do:[:each|
	(File named: each)delete]
]

{ #category : #tests }
ERTestConfigurationController >> testExportAttends [
	self registerAttendee .
	controller exportAttends: 'attendees'.
	self assert: (File named: (fileNames at:1))exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportAwards [
	
	controller exportAttends: 'awards'.
	self assert: (File named: (fileNames at:2))exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportGroupManagers [
	
	controller exportAttends: 'groupManagers'.
	self assert: (File named: (fileNames at:3))exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportTalks [
	
	controller exportAttends: 'talks'.
	self assert: (File named: (fileNames at:4))exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportUsers [
	
	controller exportAttends: 'users'.
	self assert: (File named: (fileNames at:5))exists
]
