"
Description
--------------------s

A ERTestConfigurationController is a test class for testing the behavior of Configuration Controller
"
Class {
	#name : #ERTestConfigurationController,
	#superclass : #ERTest,
	#instVars : [
		'fileNames'
	],
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestConfigurationController >> idOfAdmin [
	^ (controller conference findUserByEmail: 'admin@esug.org') id asString
]

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
	aFile := controller conference exportAttends: 'attendees'.
	self assert: aFile equals: '"InvoiceNumber","FirstName","LastName","Email","Country","Org. Name"', String crlf
]

{ #category : #tests }
ERTestConfigurationController >> testExportAwards [
	
	| aFile |
	aFile := controller conference exportAwards: 'awards'.
	self assert: aFile equals: '"Name","Submitted by"', String crlf
]

{ #category : #tests }
ERTestConfigurationController >> testExportGroupManagers [
	
	| aFile |
	aFile := controller conference exportGroupManagers: 'groupManagers'.
	self assert: aFile equals: '"Invoice Number","First Name","Last Name","Email","Org. Name","Org. Address1","Org. City","Org. Country","Org. Postal","Org. Membership"', String crlf
]

{ #category : #tests }
ERTestConfigurationController >> testExportTalks [
	
	| aFile |
	aFile := controller conference exportTalks: 'talks'.
	self assert: aFile equals: '"Name","Submitted By","Uploaded File"', String crlf 
]

{ #category : #tests }
ERTestConfigurationController >> testExportUsers [
	| aFile |
	aFile := controller conference exportUsers: 'users'.
	self assert: aFile equals: '"id","firstName","lastName","email","password","role"',
	String crlf,
'"',self idOfAdmin,'","Admin","Admin","admin@esug.org","|""/²}ò/Y!4è$c|
"," admin"', String crlf
]
