Class {
	#name : #ERFinishRegisterAttend2,
	#superclass : #ERPageView,
	#instVars : [
		'listInfoBank'
	],
	#category : #'ESUGApp-Views'
}

{ #category : #testing }
ERFinishRegisterAttend2 class >> canBeRoot [
	^ true
]

{ #category : #initialization }
ERFinishRegisterAttend2 class >> initialize [
    "self initialize"

    (WAAdmin register: self asApplicationAt: 'FinishRegisterAttend2')
        addLibrary: JQDeploymentLibrary;
        addLibrary: MDLLibrary;
        addLibrary: ERMaterialBlueRedMinCss;
        addLibrary: CssForLoginMDL;
        addLibrary: CssForRegisterFormsMDL;
        addLibrary: ERJQValidateForm;
        addLibrary: ERLibrary;
        preferenceAt: #sessionClass put: ERSession
]

{ #category : #accessing }
ERFinishRegisterAttend2 >> headers [
	^ #('Bank Code' 'Counter Code' 'Account Number' 'RIB Key' 'Bank Address')
]

{ #category : #'as yet unclassified' }
ERFinishRegisterAttend2 >> infoCells [
	^ #('15629' '02701' 'W751167780' '44')
]

{ #category : #'as yet unclassified' }
ERFinishRegisterAttend2 >> initListInfoBank [
	listInfoBank := #('Bank name: Crédit Mutuel Nord Europe' 'International Bank Account Numer (IBAN): GR76 1562 9027 0100 04330600 144' 'BIC(Bank Identifier Code): CMCIFR2A' 'Account owner: ESUG - EUROPEAN SMALLTALK USERS GROUP').
]

{ #category : #initialization }
ERFinishRegisterAttend2 >> initialize [
	super initialize.
	title := 'Finish'.
	icon := 'done'.
	id := 'finishRegisterAttend2'.
	classContainer := 'mdl-card-register'.
	self initListInfoBank.
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderActions: html [
	html mdlCardActions class: 'mdl-card--border';
	with: [ 
		html anchor url: '../Attendee/Home.html';
		class: 'mdl-button mdl-button--colored mdl-js-button mdl-js-ripple-effect';
		with: 'Ok'.	
	]
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderBody: html [
	html tableBody: [
		html tableRow: [ 
			self infoCells do: [ :each | html mdlTableCell: each	].
			html mdlTableCell: [ 
				html text: 'CCM Douai'.
				html break.
				html text: '92 rue de Paris'.
				html break.
				html text: '59500 Douai'
			]
		]		
	]
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderHeaders: html [
	html
		tableHead: [ html
				tableRow: [ self headers do: [ :each | html mdlTableHeading: each ] ] ]
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderInfoBank: html [
	html break.
	listInfoBank do: [ :info | 
		html text: info.
		html break.	
	].
	html break
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderInfoBankTransfer: html [
	html break.
	html text: 'BANK TRANSFER to "ESUG - EUROPEAN SMALLTALK USERS GROUP" (in Euro). the tranfer should be "whitout cost to the beneficiary" (i.e
        your organization shoul pay all bank transfer fees) Now make they bank transfer from your account, either right awaty or within the next few days.
        (In the text field transfer, please put your email. to speed payment reconcilliation.) To record this data, either save/print this page now or click "OK" the "My Registration" then "Generate Invoice",
        and save/print that. (you can login again and generate another copy of the invoice at any time.).'.
	html break.
	html break
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderPageOn: html [
	self renderInfoBankTransfer: html.
	self renderTableInfoBank: html.
	self renderInfoBank: html.
	self renderActions: html.
]

{ #category : #rendering }
ERFinishRegisterAttend2 >> renderTableInfoBank: html [
	html mdlTable
				class: 'mdl-shadow--2dp';
				style: 'width:100%;';
				with: [ self renderHeaders: html.
						  self renderBody: html] 
]
