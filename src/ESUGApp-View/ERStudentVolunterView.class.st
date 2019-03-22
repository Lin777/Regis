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
ERStudentVolunterView >> allAttends [ 
	^ controller conference attends
]

{ #category : #rendering }
ERStudentVolunterView >> attends [
	aStringToMatch 
		ifNil: [
			^ self allAttends ]
		ifNotNil: [
			^ self filteredAssistants ]
]

{ #category : #rendering }
ERStudentVolunterView >> blockTableToExecute [
	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount lastName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
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

{ #category : #rendering }
ERStudentVolunterView >> filterByEmail [
	^ controller filterAttendsByEmailWith: aStringToMatch 
]

{ #category : #rendering }
ERStudentVolunterView >> filterByFirstName [
	^ controller filterAttendsByFirstNameWith: aStringToMatch 
]

{ #category : #rendering }
ERStudentVolunterView >> filterByLastName [
	^ controller filterAttendsByLastNameWith: aStringToMatch
]

{ #category : #rendering }
ERStudentVolunterView >> filteredAssistants [
	aStringToMatch isEmpty ifTrue: [ ^ self allAttends ].
	self strategyIsByEmail ifTrue: [ ^ self filterByEmail ].
	self strategyIsByName ifTrue: [ ^ self filterByFirstName ].
	self strategyIsByLastName ifTrue: [ ^ self filterByLastName ]
]

{ #category : #accessing }
ERStudentVolunterView >> headers [
	^ #('#Invoice'	'First Name'	 'Last Name' 'Email'	'Affiliation	' 'Fee' 'Has paid?' '')
]

{ #category : #rendering }
ERStudentVolunterView >> initialize [ 	
	strategy := 'Email'.
	controller := ERController new.
]

{ #category : #rendering }
ERStudentVolunterView >> listDataToRenderButton [
	^ OrderedCollection new
]

{ #category : #rendering }
ERStudentVolunterView >> renderFieldToSearchOn: html [
	html div class: 'half'; with: [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: 'stringForStrategy';
				with: strategy.
			html mdlTextFieldInput
				onChange: 'submit()';
				id: 'stringForStrategy';
				value: aStringToMatch ;
				callback: [ :val | aStringToMatch := val ] ] ]
	
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
	html div class: 'half'; with: [
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel for: 'selectStrategy';
			 with: 'Strategy of Search'.
			html select
				onChange: 'submit()';
				class: 'mdl-textfield__input';
				id: 'selectStrategy';
				list: #('Email' 'First Name' 'Last Name');
				selected: strategy;
				callback: [ :value | strategy := value ] ] ]
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
ERStudentVolunterView >> strategyIsByEmail [
	^ strategy = 'Email'
]

{ #category : #rendering }
ERStudentVolunterView >> strategyIsByLastName [
	^ strategy = 'Last Name'
]

{ #category : #rendering }
ERStudentVolunterView >> strategyIsByName [
	^ strategy = 'First Name'
]

{ #category : #rendering }
ERStudentVolunterView >> title [
	^ 'Attendees'
]
