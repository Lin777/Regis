Class {
	#name : #ERFooterView,
	#superclass : #WAComponent,
	#category : #'ESUGApp-Components'
}

{ #category : #rendering }
ERFooterView >> renderContentOn: html [
	html mdlMiniFooter id: 'footer';
	with: [ 
		html mdlMiniFooterLeftSection class: 'mdl-mini-footer__link-list';
		with: [ 
			html text: 'Designed by '.
			html anchor url: 'http://semantics.bo';
			with: 'Semantics'	
		]
	].
]
