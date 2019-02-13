Class {
	#name : #ERTestConfigurationController,
	#superclass : #ERTest,
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
	| aFile |
	aFile := controller exportAttends: 'attendees'.
	self assert: aFile exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportAwards [
	
	| aFile |
	aFile := controller exportAwards: 'awards'.
	self assert: aFile exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportGroupManagers [
	
	| aFile |
	aFile := controller exportGroupManagers: 'groupManagers'.
	self assert: aFile exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportTalks [
	
	| aFile |
	aFile := controller exportTalks: 'talks'.
	self assert: aFile exists
]

{ #category : #tests }
ERTestConfigurationController >> testExportUsers [
	| aFile |
	aFile := controller exportUsers: 'users'.
	self assert: aFile exists
]
