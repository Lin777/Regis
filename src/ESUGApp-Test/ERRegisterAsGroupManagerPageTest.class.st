"
A ERRegisterAsGroupManagerPageTest is a test class for testing the behavior of page when the user is registering as GroupManager
"
Class {
	#name : #ERRegisterAsGroupManagerPageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #action }
ERRegisterAsGroupManagerPageTest >> pushRegisterAsGroupManagerButton [
	self clickElementWithID: 'register-button-as-group-manager'
]

{ #category : #accessing }
ERRegisterAsGroupManagerPageTest >> setUp [
	super setUp.
	self pushRegisterAsGroupManagerButton 
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressAffiliationBackButton [
	self pressNextButtonUser   .
	self clickElementWithID: 'affiliationInfoForm-previousButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressAffiliationNextButtonWithAllFieldsFilledCorrectly [
	self pressNextButtonUser .
	self fillAllAffiliationFields .
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Done')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'.
	self should: [ driver findElementByClassName: 'mdl-textfield__error' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]
