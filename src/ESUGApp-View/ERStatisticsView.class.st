Class {
	#name : #ERStatisticsView,
	#superclass : #ERTittledView,
	#instVars : [
		'controller',
		'tables'
	],
	#category : #'ESUGApp-View'
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
	super initialize .
	tables:= OrderedCollection new.
]

{ #category : #initialization }
ERStatisticsView >> renderPageOn: html [
	self renderParticipantsToLunchesStatisticsOn: html.
	self renderShirtsStatisticsOn: html.
	self renderParticipantsToSocialDinnerStatisticsOn: html
]

{ #category : #initialization }
ERStatisticsView >> renderParticipantsToLunchesStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		headers: controller headersParticipantsToLunches;
		levelTotal: 6;
		listObject: controller statisticsOfLuch.
	self renderTable: tab withTitle: 'Participants to lunches per day' on: html
]

{ #category : #initialization }
ERStatisticsView >> renderParticipantsToSocialDinnerStatisticsOn: html [
	|tab|
	tab := ERDictionaryTable new
		headers: controller headersParticipantsToSocialDinner;
		levelTotal: 6;
		listObject: controller statisticsOfSocialDinner.
	self renderTable: tab withTitle: 'Participants To Social Dinner' on: html
]

{ #category : #initialization }
ERStatisticsView >> renderShirtsStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		headers: controller headersShirtsStatistics;
		levelTotal: 6;
		listObject: controller statisticsOfTShirts .
	self renderTable: tab withTitle: 'Shirts' on: html
]

{ #category : #initialization }
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
