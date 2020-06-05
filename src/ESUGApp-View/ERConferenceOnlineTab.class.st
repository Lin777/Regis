"
Description
--------------------

Tab of open or close the registration of conference.

- I can Open and Close the registration of conference.
"
Class {
	#name : #ERConferenceOnlineTab,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #initialization }
ERConferenceOnlineTab >> initialize [
	super initialize.
	messageComponent := messageComponent id: 'tabAlertOfconfiguration'.

]

{ #category : #rendering }
ERConferenceOnlineTab >> renderContainerOn: html [
	self renderSwitchOpenCloseOn: html.
]

{ #category : #rendering }
ERConferenceOnlineTab >> renderSwitchOpenCloseOn: html [
	html form
		method: 'post';
		with: [
		self renderTitleForSwitchOn: html.
		html mdlSwitchContainer
			rippleEffect;
			style: 'width: 150px;';
			for: 'switchOpenClose';
			with: [ html mdlSwitch
				value: controller conference conferenceIsOpenRegistration;
				id: 'switchOpenClose';
				onTrue: [ controller openRegistration ] 
				onFalse: [ controller closeRegistration ];
				onChange: (html jQuery ajax serializeForm).
			html mdlSwitchLabel: 'Close / Open' ]
		].
	html horizontalRule.
]

{ #category : #rendering }
ERConferenceOnlineTab >> renderTitleForSwitchOn: html [
	html horizontalRule .
	html heading level6 with: 'Change the state of the switch opens or closes the conference registration'
]

{ #category : #accessing }
ERConferenceOnlineTab >> tabId [
	^ 'tabOnline'
]

{ #category : #accessing }
ERConferenceOnlineTab >> tabName [
	^ 'Online'
]

{ #category : #accessing }
ERConferenceOnlineTab >> title [ 	
	^ 'Open / Close Registration'
]
