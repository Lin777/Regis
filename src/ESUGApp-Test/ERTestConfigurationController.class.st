Class {
	#name : #ERTestConfigurationController,
	#superclass : #ERTestControllers,
	#instVars : [
		'controller'
	],
	#category : #'ESUGApp-Test'
}

{ #category : #tests }
ERTestConfigurationController >> setUp [
	super setUp.
	controller := ERConfigurationController new
]
