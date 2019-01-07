Class {
	#name : #ERClassToVerity,
	#superclass : #ERComponent,
	#instVars : [
		'classContainer',
		'content',
		'title',
		'iconPage',
		'classColorIcon'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #testing }
ERClassToVerity class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERClassToVerity class >> initialize [
    (WAAdmin register: self asApplicationAt: 'classVerify')
        addLibrary: JQDeploymentLibrary;
        addLibrary: MDLLibrary;
        addLibrary: ERMaterialBlueRedMinCss;
        addLibrary: CssForLoginMDL;
        addLibrary: ERJQValidateForm;
        addLibrary: ERLibrary;
        preferenceAt: #sessionClass put: ERSession
]

{ #category : #accessing }
ERClassToVerity >> classColorIcon [
	^ classColorIcon
]

{ #category : #accessing }
ERClassToVerity >> classColorIcon: anObject [
	classColorIcon := anObject
]

{ #category : #accessing }
ERClassToVerity >> classContainer [
	^ classContainer
]

{ #category : #accessing }
ERClassToVerity >> classContainer: anObject [
	classContainer := anObject
]

{ #category : #accessing }
ERClassToVerity >> content [
	^ content
]

{ #category : #accessing }
ERClassToVerity >> content: anObject [
	content := anObject
]

{ #category : #accessing }
ERClassToVerity >> iconPage [
	^ iconPage
]

{ #category : #accessing }
ERClassToVerity >> iconPage: anObject [
	iconPage := anObject
]

{ #category : #initialization }
ERClassToVerity >> initialize [
	super initialize.
	classContainer := ''.
	classColorIcon := 'mdl-color--red'.
]

{ #category : #rendering }
ERClassToVerity >> renderContentOn: html [
	"html div
		class: self id;
		with: [ html mdlLayout
				with: [ html mdlCard
						class: classContainer , ' mdl-shadow--16dp';
						id: 'login-conatiner';
						with: [ html mdlCardTextContainer
								with: [ self renderIconCard: html.
									html div
										id: 'card-heading';
										with: self title.
									self content value ] ] ] ]"

	html mdlButton
		openDialogWithId: 'buttonOpen';
		bePush;
		raised;
		rippleEffect;
		with: 'Show dialog'.
	html
		render:
			(ERDialog new
				title: 'Error';
				message: 'This is a error';
				idClose: 'buttonClose';
				idOpen: 'buttonOpen';
				okCallback: [Transcript show: 'Push OK'])
]

{ #category : #rendering }
ERClassToVerity >> renderIconCard: html [
	html div id: 'login-fab';
	class: self classColorIcon, ' mdl-color-text--white';
	with: [ 
		html icon id: 'lock-icon';
		class: 'material-icons';
		with: self iconPage
	].
]

{ #category : #accessing }
ERClassToVerity >> title [
	^ title
]

{ #category : #accessing }
ERClassToVerity >> title: anObject [
	title := anObject
]
