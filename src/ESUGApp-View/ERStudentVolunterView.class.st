"
Description
--------------------

I am a view to search attendees by email, firstname or lastname (only its show to student volunter)
"
Class {
	#name : #ERStudentVolunterView,
	#superclass : #ERTittledView,
	#instVars : [
		'strategy',
		'table',
		'attends',
		'aStringToMatch'
	],
	#category : #'ESUGApp-View-View'
}

{ #category : #'as yet unclassified' }
ERStudentVolunterView class >> withContent: content [
	^ self new 
		content: content; yourself 
]

{ #category : #accessing }
ERStudentVolunterView >> allAttends [ 
	^ controller conference attends
]

{ #category : #accessing }
ERStudentVolunterView >> attends [
	aStringToMatch 
		ifNil: [
			^ self allAttends ]
		ifNotNil: [
			^ self filteredAssistants ]
]

{ #category : #tableBlock }
ERStudentVolunterView >> blockTableToExecute [
	^ [ :user :html | 
	OrderedCollection new
		add: ([ :att | att paymentInformation invoiceNumber ] value: user);
		add: ([ :att | att userAccount firstName ] value: user);
		add: ([ :att | att userAccount lastName ] value: user);
		add: ([ :att | att userAccount email ] value: user);
		add: ([ :att | att affiliationInformation organizationName ] value: user);
		add: ([ :att | att paymentInformation paymentAmount asString
			, ' €'  ] value: user);
		add: ([ :att :aHtml | [ aHtml mdlCheckbox disabled
				value: att paymentInformation hasPaid
				] ] valueWithArguments: {user. html});
		yourself ]
]

{ #category : #filtering }
ERStudentVolunterView >> filterByEmail [
	^ controller conference filterAttendsByEmailWith: aStringToMatch 
]

{ #category : #filtering }
ERStudentVolunterView >> filterByFirstName [
	^ controller conference filterAttendsByFirstNameWith: aStringToMatch 
]

{ #category : #filtering }
ERStudentVolunterView >> filterByLastName [
	^ controller conference filterAttendsByLastNameWith: aStringToMatch
]

{ #category : #filtering }
ERStudentVolunterView >> filteredAssistants [
	aStringToMatch isEmpty ifTrue: [ ^ self allAttends ].
	self strategyIsByEmail ifTrue: [ ^ self filterByEmail ].
	self strategyIsByName ifTrue: [ ^ self filterByFirstName ].
	self strategyIsByLastName ifTrue: [ ^ self filterByLastName ]
]

{ #category : #accessing }
ERStudentVolunterView >> headers [
	^ { '#Invoice' .	'First Name' .	 'Last Name' . 'Email' .	'Affiliation	' . 'Fee' . PSTableSortableHeaderOptions new cell: 'Has paid?' . PSTableSortableHeaderOptions new cell: '' }
]

{ #category : #initialization }
ERStudentVolunterView >> initialize [ 	
	super initialize.
	strategy := 'Email'.
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
		tableId: 'table-volunteer';
		showPaginationBar: false;
		showSearchingField: false;
		showSelectionLimit: false;
		header: self headers;
		levelTotal: 6;
		rows: self attends;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: OrderedCollection new;
		dictToRenderDownloadButton: Dictionary new;
		sortingMethod: self sortingMethodVolunteer.
	html render: table
]

{ #category : #accessing }
ERStudentVolunterView >> sortingMethodVolunteer [
	^ { [ :att | att paymentInformation invoiceNumber ]
		. [ :att | att userAccount firstName ]
		. [ :att | att userAccount lastName ]
		. [ :att | att userAccount email ]
		. [ :att | att affiliationInformation organizationName ]
		. [ :att | att paymentInformation paymentAmount asString, ' €' ] }
]

{ #category : #accessing }
ERStudentVolunterView >> strategyIsByEmail [
	^ strategy = 'Email'
]

{ #category : #accessing }
ERStudentVolunterView >> strategyIsByLastName [
	^ strategy = 'Last Name'
]

{ #category : #accessing }
ERStudentVolunterView >> strategyIsByName [
	^ strategy = 'First Name'
]

{ #category : #accessing }
ERStudentVolunterView >> title [
	^ 'Attendees'
]
