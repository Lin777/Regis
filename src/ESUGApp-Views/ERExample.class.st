Class {
	#name : #ERExample,
	#superclass : #ERComponent,
	#category : #'ESUGApp-Views'
}

{ #category : #initialization }
ERExample class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERExample class >> initialize [
	"self initialize"
    (WAAdmin register: self asApplicationAt: 'classVerify')
        addLibrary: JQDeploymentLibrary;
        addLibrary: MDLLibrary;
        addLibrary: ERMaterialBlueRedMinCss;
        addLibrary: CssForLoginMDL;
        addLibrary: ERJQValidateForm;
        addLibrary: ERLibrary;
        preferenceAt: #sessionClass put: ERSession
]

{ #category : #rendering }
ERExample >> renderContentOn: html [
	html mdlButton
		id: 'button';
		bePush;
		raised;
		rippleEffect;
		with: 'Show dialog'.
		
	html mdlDialog
		openButtonId: 'button';
		closeButtonId: 'close';
		with: [ 
			html mdlDialogTitle: 'Good job !'.
			html mdlDialogContent: [ html paragraph: 'You have not managed to click the button' ].
			html
				mdlDialogActions: [ html mdlButton: 'Agree'.
					html mdlButton
						id: 'close';
						bePush;
						with: 'Disagree' ] ]
]
