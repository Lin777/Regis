Class {
	#name : #ERRegisterAsGroupManagerPageTest,
	#superclass : #ERRegisterTest,
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #'as yet unclassified' }
ERRegisterAsGroupManagerPageTest >> pushRegisterAsGroupManagerButton [
	|register|
	register := driver findElementByID: 'register-button-as-group-manager'.
	register click.
]

{ #category : #accessing }
ERRegisterAsGroupManagerPageTest >> setUp [
	super setUp.
	self pushRegisterAsGroupManagerButton 
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressAffiliationBackButton [
	|next|
	self pressNextButtonUser   .
	next := driver findElementByID: 'affiliationInfoForm-previousButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-User')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressAffiliationNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self pressNextButtonUser .
	self fillAllAffiliationFields .
	next := driver findElementByID: 'affiliationInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Done')
]

{ #category : #tests }
ERRegisterAsGroupManagerPageTest >> testPressUserNextButtonWithAllFieldsFilledCorrectly [
	|next|
	self fillAllUserFields.
	next := driver findElementByID: 'basicInfoForm-nextButton'.
	next click.
	self should: [ driver findElementByClassName: 'errors' ] raise: BPNoSuchElementException.
	self assert: (driver findElementByClassName: 'is-active') equals: (driver findElementByID: 'tab-Affiliation')
]
