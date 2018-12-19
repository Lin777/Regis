Class {
	#name : #ERContainerTabsView,
	#superclass : #ERContainerView,
	#instVars : [
		'tabView'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERContainerTabsView >> renderCancelButton: html [
	html mdlButton
		colored;
		rippleEffect;
		id: 'cancelRegisterUser';
		callback: [ self answer: nil ];
		with: 'Cancel'
]

{ #category : #rendering }
ERContainerTabsView >> renderContentPage: html [
	html
		html:
			'<div class="mdl-tabs mdl-js-tabs mdl-js-ripple-effect">
              <div style="overflow-x:auto;">
                  <div class="mdl-grid mdl-grid--no-spacing">'.
	html render: tabView.
	html html: '</div> </div> </div>'.
	self renderCancelButton: html
]

{ #category : #accessing }
ERContainerTabsView >> tabView [
	^ tabView
]

{ #category : #accessing }
ERContainerTabsView >> tabView: anObject [
	tabView := anObject
]
