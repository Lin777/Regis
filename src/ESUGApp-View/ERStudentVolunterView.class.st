Class {
	#name : #ERStudentVolunterView,
	#superclass : #ERTittledView,
	#instVars : [
		'controller',
		'strategy',
		'table',
		'attends',
		'aStringToMatch'
	],
	#category : #'ESUGApp-View'
}

{ #category : #'as yet unclassified' }
ERStudentVolunterView class >> withContent: content [
	^ self new 
		content: content; yourself 
]

{ #category : #rendering }
ERStudentVolunterView >> attends [
	"aStringToMatch ifNil: ["
	^ ERController new conference attends"]"
]

{ #category : #rendering }
ERStudentVolunterView >> blockTableToExecute [
	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att contactInformation country ] value: user);
		add: ([ :att | att affiliationInformation organizationName ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' ', att paymentInformation paymentCurrency, '(s)'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox disabled
				value: att paymentInformation hasPaid
				] ] valueWithArguments: {user. html});
		yourself ]
]

{ #category : #rendering }
ERStudentVolunterView >> dictToRenderDownloadButton [
	^ Dictionary new	yourself
]

{ #category : #accessing }
ERStudentVolunterView >> headers [
	^ #('#Invoice'	'Name'	 'Email'	'Country'	'Affiliation	' 'Fee' 'Has paid?' '')
]

{ #category : #rendering }
ERStudentVolunterView >> initialize [ 	
	strategy := 'Email'
]

{ #category : #rendering }
ERStudentVolunterView >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERStudentVolunterView >> renderFieldToSearchOn: html [
	html mdlTextFieldContainer
		style: 'display: block';
		class: 'half';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'is_register';
				with: 'Email attendee'.
			html mdlTextFieldInput
				id: 'is_register';
				callback: [ :val | aStringToMatch := val ] ]
	
]

{ #category : #rendering }
ERStudentVolunterView >> renderPageOn: html [
	html form with:[
		self renderSelectorWayToSearchOn: html.
		self renderFieldToSearchOn: html].
	self renderTableOfAttendsOn: html
]

{ #category : #rendering }
ERStudentVolunterView >> renderSelectorWayToSearchOn: html [
	
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		class: 'half';
		with: [ html mdlTextFieldLabel for: 'selectStrategy';
			 with: 'Strategy of Search'.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				id: 'selectStrategy';
				list: #('Email' 'First Name');
				selected: 'Email';
				callback: [ :value | strategy := value ] ]
]

{ #category : #rendering }
ERStudentVolunterView >> renderTableOfAttendsOn: html [
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton;
		dictToRenderDownloadButton: self dictToRenderDownloadButton.
	html render: table
]

{ #category : #rendering }
ERStudentVolunterView >> title [
	^ 'Attendees'
]
