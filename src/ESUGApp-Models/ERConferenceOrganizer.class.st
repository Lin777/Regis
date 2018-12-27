Class {
	#name : #ERConferenceOrganizer,
	#superclass : #SDActiveRecord,
	#instVars : [
		'name',
		'fisicalSituation',
		'webPageUrl',
		'addressString'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConferenceOrganizer >> addressString [
	^ addressString
]

{ #category : #accessing }
ERConferenceOrganizer >> addressString: anObject [
	addressString := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> fisicalSituation [
	^ fisicalSituation
]

{ #category : #accessing }
ERConferenceOrganizer >> fisicalSituation: anObject [
	fisicalSituation := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> name1 [
	^ name
]

{ #category : #accessing }
ERConferenceOrganizer >> name: anObject [
	name := anObject
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl [
	^ webPageUrl
]

{ #category : #accessing }
ERConferenceOrganizer >> webPageUrl: anObject [
	webPageUrl := anObject
]
