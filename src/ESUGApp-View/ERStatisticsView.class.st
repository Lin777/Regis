"
Description
--------------------

I am a view to show statistics of participants to lunch, participants to social dinner and statistics of t-shirts in tables
"
Class {
	#name : #ERStatisticsView,
	#superclass : #ERTittledView,
	#instVars : [
		'tables'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERStatisticsView class >> withContent: aContent [
	| form |
	form := self new.
	form content: aContent.
	form controller: ERConfigurationController  new.
	^ form
]

{ #category : #initialization }
ERStatisticsView >> children [ 	
	^ OrderedCollection withAll: tables
]

{ #category : #initialization }
ERStatisticsView >> initialize [ 	
	super initialize.
	controller := ERConfigurationController new.
	tables:= OrderedCollection new.
]

{ #category : #rendering }
ERStatisticsView >> renderPageOn: html [
	self renderParticipantsToLunchesStatisticsOn: html.
	self renderShirtsStatisticsOn: html.
	self renderParticipantsToSocialDinnerStatisticsOn: html
]

{ #category : #rendering }
ERStatisticsView >> renderParticipantsToLunchesStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		tableId: 'participant-to-lunches-table';
		header: controller conference headersParticipantsToLunches;
		rows: controller conference statisticsOfLuch.
	self renderTable: tab withTitle: 'Participants to lunches per day' on: html
]

{ #category : #rendering }
ERStatisticsView >> renderParticipantsToSocialDinnerStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		tableId: 'participant-to-social-dinner-table';
		header: controller conference headersParticipantsToSocialDinner;
		rows: controller conference statisticsOfSocialDinner.
	self renderTable: tab withTitle: 'Participants To Social Dinner' on: html
]

{ #category : #rendering }
ERStatisticsView >> renderShirtsStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		tableId: 'shirts-table';
		header: controller conference headersShirtsStatistics;
		rows: controller conference statisticsOfTShirts.
	self renderTable: tab withTitle: 'Shirts' on: html
]

{ #category : #rendering }
ERStatisticsView >> renderTable: aTable withTitle: aString on: html [
	html heading
		level4;
		with: aString.
	html horizontalRule.
	tables add: aTable.
	html render: aTable
]

{ #category : #accessing }
ERStatisticsView >> title [
	^ 'Statistics'
]
