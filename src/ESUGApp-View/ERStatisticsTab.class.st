Class {
	#name : #ERStatisticsTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'tables'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERStatisticsTab >> children [ 	
	^ OrderedCollection withAll: tables
]

{ #category : #rendering }
ERStatisticsTab >> initialize [ 	
	super initialize .
	tables:= OrderedCollection new.
]

{ #category : #rendering }
ERStatisticsTab >> renderAttendeesRolesStatisticsOn: html [
]

{ #category : #rendering }
ERStatisticsTab >> renderContainerOn: html [
	html horizontalRule.
	self renderParticipantsToLunchesStatisticsOn: html.
	self renderShirtsStatisticsOn: html.
	self renderParticipantsToSocialDinnerStatisticsOn: html
]

{ #category : #rendering }
ERStatisticsTab >> renderParticipantsToLunchesStatisticsOn: html [
	| tab |
	tab := ERDictionaryTable new
		headers: controller headersParticipantsToLunches;
		levelTotal: 6;
		listObject: controller participantsToLunches.
	tables add: tab.
	html render: tab
]

{ #category : #rendering }
ERStatisticsTab >> renderParticipantsToSocialDinnerStatisticsOn: html [
	|tab|
	html heading
		level3;
		with: 'Participants To Social Dinner'.
	html horizontalRule.
	tab := ERDictionaryTable new
		headers: controller headersParticipantsToSocialDinner;
		levelTotal: 6;
		listObject: controller participantsToSocialDinner.
	tables add: tab.
	html render: tab
]

{ #category : #rendering }
ERStatisticsTab >> renderShirtsStatisticsOn: html [
	| tab |
	html heading
		level3;
		with: 'Shirts'.
	html horizontalRule.
	tab := ERDictionaryTable new
		headers: controller headersShirtsStatistics;
		levelTotal: 6;
		listObject: controller shirtsStatistics.
	tables add: tab.
	html render: tab
]

{ #category : #accessing }
ERStatisticsTab >> tabId [
	^ 'statistics'
]

{ #category : #accessing }
ERStatisticsTab >> tabName [
	^ 'statistics'
]

{ #category : #accessing }
ERStatisticsTab >> title [
	^ 'Participants to lunches per day'
]
