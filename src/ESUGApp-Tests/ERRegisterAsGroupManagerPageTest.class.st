"
Description
--------------------

A ERRegisterAsGroupManagerPageTest is a test class for testing the behavior of page when the user is registering as GroupManager
"
Class {
	#name : #ERRegisterAsGroupManagerPageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Tests-Parasol'
}

{ #category : #action }
ERRegisterAsGroupManagerPageTest >> pushRegisterAsGroupManagerButton [

	self clickElementWithID: 'register-button-as-group-manager'
]

{ #category : #running }
ERRegisterAsGroupManagerPageTest >> setUp [

	super setUp.
	self pushRegisterAsGroupManagerButton 
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressBillingBackButton [

	"self pressNextButtonUser.
	self pressNextButtonContact.
	self clickElementWithID: 'affiliationInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Group Contact')"
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressBillingNextButtonWithAllFieldsFilledCorrectly [

	self pressNextButtonUser.
	self pressNextButtonContact.
	self fillAllAffiliationFields.
	self clickElementWithID: 'registerButton'.
	self assert: ((driver findElementByID: 'card-heading') getText) equals: 'Registration Summary'
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressContactBackButton [

	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Group Manager')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressContactNextButton [

	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Billing Information')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [

	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Group Contact')
]
