"
Description
--------------------

I am an abstract form for objects that have a descriptors of magritte
"
Class {
	#name : #ERForm,
	#superclass : #ERConfigurationTab,
	#category : #'ESUGApp-Form'
}

{ #category : #accessing }
ERForm >> acceptAction [

	^ [ [ self saveForms.
				self validateForms.
				self save.
				self updateStateTab: 'Attendees' ]
				on: ERException 
				do: [ :exception | 
					messageComponent errorMessage: exception messageText.
					self updateStateTab: self tabName ] ]
]

{ #category : #actions }
ERForm >> action [

	^ [ self acceptAction
			on: ERException
				do: [ :exception | messageComponent 
											errorMessage: exception messageText.
											self returnToThePreviousState.
											self updateStateTab: self tabName ] ]
]

{ #category : #actions }
ERForm >> cancel [
	"Return to principal page when cancel edition"
	
	self cancelForm.
	self updateStateTab: 'Attendees'
]

{ #category : #actions }
ERForm >> cancelForm [

	self subclassResponsibility 
]

{ #category : #initialization }
ERForm >> initialize [

	super initialize.
	self initializeController.
	messageComponent := ERAlert warningAlert 
		id: ('form', self tabId capitalized, 'Alert').
	self initializeDialog
]

{ #category : #initialization }
ERForm >> initializeDialog [

	dialog := ERDialog cancelDialog
		idOpen: ('cancel', self tabId capitalized);
		okCallback: [ self cancel ];
		idClose: ('close', self tabId capitalized)
]

{ #category : #initialization }
ERForm >> initializeForms [

	self subclassResponsibility
]

{ #category : #rendering }
ERForm >> renderAcceptButtonOn: html [

	html mdlButton
		colored;
		id: ('accept', self tabId capitalized) ;
		callback: self acceptAction;
		with: 'Accept'
]

{ #category : #rendering }
ERForm >> renderButtonsOn: html [

	self renderCancelButtonOn: html.
	self renderAcceptButtonOn: html.
]

{ #category : #rendering }
ERForm >> renderCancelButtonOn: html [
	html mdlAnchorButton 
		id: 'cancelUpdate';
		openDialogWithId: ('cancel', self tabId capitalized); 
		colored;
		with: 'Cancel'.
]

{ #category : #rendering }
ERForm >> renderContentOn: html [
	html form
		method: 'post';
		id: ('form', self tabId capitalized);
		with: [ self renderFormOn: html ].
	html render: dialog
]

{ #category : #rendering }
ERForm >> renderFormOn: html [

	self subclassResponsibility 
]

{ #category : #actions }
ERForm >> save [

	self subclassResponsibility 
]

{ #category : #actions }
ERForm >> saveForms [

	self subclassResponsibility 
]

{ #category : #accessing }
ERForm >> sectionFormElements [ 

	self subclassResponsibility
]

{ #category : #actions }
ERForm >> validateForms [
	self subclassResponsibility 
]
