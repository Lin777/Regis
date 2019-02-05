Class {
	#name : #ERException,
	#superclass : #Exception,
	#category : #'ESUGApp-Exception'
}

{ #category : #'as yet unclassified' }
ERException class >> emailAlreadyRegistered [
		^ self new
				messageText: 'This email is already registered';
				yourself
]

{ #category : #'as yet unclassified' }
ERException class >> invalidEsugDates [
		^ self new messageText:
							'The date "From" must be less than date "To"';
			yourself
]

{ #category : #'as yet unclassified' }
ERException class >> invalidTicketId [
		^ self new 
		messageText: 'There is no ticket with the ticket id provided.';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> limitStrategyNotAllowedd [
		^ self new
		messageText: 'The ticket does not have a limit strategy allowed.';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> passwordDoesNotMatchWithConfirmPass [
		^ self new 
			messageText: 'The password does not match with confirm password';
			yourself
]

{ #category : #'as yet unclassified' }
ERException class >> passwordFormatException [
		^ self new
				messageText:
					'The password must have at least 8 characters, and only accepts letters, numbers, slash and dots.';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> paymentCurrencyNotAvailable [
		^ self new 
		messageText: 'The payment currency is not available now.';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> paymentInvalid [
		^ self new
		messageText: 'The type of payment entered is not valid. ';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> ticketDoesNotExist [
		^ self new
						messageText: 'The ticket does not exist for this conference';
		yourself
]

{ #category : #'as yet unclassified' }
ERException class >> ticketWasExceeded [
		^ self new 
		messageText: 'The limit of the ticket was exceeded, you can not use it';
			yourself
]

{ #category : #'as yet unclassified' }
ERException class >> ticketWithIdAlreadyExist [
		^ self new messageText:
							'There is already a previously registered ticket with this ticket ID';
			yourself
]

{ #category : #accessing }
ERException >> defaultAction [
	^ self 
]
