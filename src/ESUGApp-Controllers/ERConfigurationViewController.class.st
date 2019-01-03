Class {
	#name : #ERConfigurationViewController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #accessing }
ERConfigurationViewController >> attends [
	^ conference attends 
]

{ #category : #accessing }
ERConfigurationViewController >> fees [
	^ conference fees
]

{ #category : #accessing }
ERConfigurationViewController >> groupManagers [
	^ conference groups 
]

{ #category : #accessing }
ERConfigurationViewController >> reductionTickets [
	^ conference reductionTickets
]

{ #category : #accessing }
ERConfigurationViewController >> submittedAwards [
	^ conference submittedAwards
]

{ #category : #accessing }
ERConfigurationViewController >> submittedTalks [
	^ conference submittedTalks
]

{ #category : #accessing }
ERConfigurationViewController >> users [
	^ conference users
]
