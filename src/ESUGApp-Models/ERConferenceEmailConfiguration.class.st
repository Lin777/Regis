Class {
	#name : #ERConferenceEmailConfiguration,
	#superclass : #SDActiveRecord,
	#instVars : [
		'senderEmailAddress',
		'smptServerAddress',
		'smptClient',
		'welcomeText'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConferenceEmailConfiguration >> senderEmailAddress [
	^ senderEmailAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> senderEmailAddress: anObject [
	senderEmailAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptClient [
	^ smptClient
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptClient: anObject [
	smptClient := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptServerAddress [
	^ smptServerAddress
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> smptServerAddress: anObject [
	smptServerAddress := anObject
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText [
	^ welcomeText
]

{ #category : #accessing }
ERConferenceEmailConfiguration >> welcomeText: anObject [
	welcomeText := anObject
]
