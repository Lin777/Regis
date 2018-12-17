Class {
	#name : #ERNavView,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'listOptions'
	],
	#category : #'ESUGApp-Components'
}

{ #category : #initialization }
ERNavView >> initialize [
	super initialize.
	title := 'Home'.
	listOptions := OrderedCollection new
]

{ #category : #accessing }
ERNavView >> listOptions: anObject [
	listOptions := anObject
]

{ #category : #rendering }
ERNavView >> renderContentOn: html [
	self renderHeader: html.
	html div
		class:
			'demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50"';
		with: [ self renderHeaderESUG: html.
			html mdlNavigation
				class: 'demo-navigation mdl-color--blue-grey-800';
				with: [ listOptions do: [ :each | html render: each ] ] ]
]

{ #category : #rendering }
ERNavView >> renderHeader: html [
	html html: '<header class="demo-header mdl-layout__header mdl-color--blue-grey-800 mdl-color-text--white">
        <div class="mdl-layout__header-row">
          <span class="mdl-layout-title">',title,'</span>
          <div class="mdl-layout-spacer"></div>
        </div>
</header>'.
]

{ #category : #rendering }
ERNavView >> renderHeaderESUG: html [
	html html: '<header class="demo-drawer-header">
          <div class="demo-avatar-dropdown">
            <h4>ESUG</h4>
          </div>
        </header>'.
]

{ #category : #accessing }
ERNavView >> title: aString [
	title := aString
]
