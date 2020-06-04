"
Description
--------------------

An ERException is the abstract class for any Exception caused by behavior of the page

"
Class {
	#name : #ERException,
	#superclass : #Exception,
	#category : #'ESUGApp-Core'
}

{ #category : #'instance creation' }
ERException class >> adminUserDoesNotDelete [
		^ self new 
			messageText: 'Users with administrator role can not be deleted';
			yourself
]

{ #category : #'instance creation' }
ERException class >> backupError [
		^ self new 
			messageText: 'Something went wrong while the backup was done';
			yourself
]

{ #category : #'instance creation' }
ERException class >> deletionOfTicketNotValid [
		^ self new
				messageText: 'This ticket can not be deleted because it is being used by one or more attendees';
				yourself
]

{ #category : #'instance creation' }
ERException class >> emailAlreadyRegistered [
		^ self new
				messageText: 'This email is already registered';
				yourself
]

{ #category : #'instance creation' }
ERException class >> emailDoesNotExistToResetPassword [
		^ self new 
			messageText: 'Can''t find that email, sorry.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> errorWhenCalculatingPaymentAmount [
		^ self new
			messageText: 'An error occurred when calculating the payment amount.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> incorrectPatternOfPassword [
		^ self new 
			messageText: 'Must contain: numbers, letters, ''.'' or ''_'', and at least 8 or more characters';
			yourself
]

{ #category : #'instance creation' }
ERException class >> invalidEsugDates [
		^ self new 
			messageText: 'The date "From" must be less than date "To"';
			yourself
]

{ #category : #'instance creation' }
ERException class >> invalidTicketId [
		^ self new 
			messageText: 'There is no ticket with the ticket id provided.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> limitStrategyNotAllowedd [
		^ self new
			messageText: 'The ticket does not have a limit strategy allowed.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> loginFailed [
		^ self new 
			messageText: 'Login failed';
			yourself
]

{ #category : #'instance creation' }
ERException class >> noDaysOfConference [
		^ self new
			messageText: 'Select the days you will attend the conference';
			yourself
]

{ #category : #'instance creation' }
ERException class >> notFoundAttendeeFromUser [
		^ self new
			messageText: 'Not exist Attendee from this user ';
			yourself
]

{ #category : #'instance creation' }
ERException class >> passwordDoesNotMatch [
		^ self new 
			messageText: 'The password entered does not match the current password';
			yourself
]

{ #category : #'instance creation' }
ERException class >> passwordDoesNotMatchWithConfirmPass [
		^ self new 
			messageText: 'The password does not match with confirm password';
			yourself
]

{ #category : #'instance creation' }
ERException class >> passwordFormatException [
		^ self new
			messageText:
					'The password must have at least 8 characters, and only accepts letters, numbers, slash and dots.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> paymentCurrencyNotAvailable [
		^ self new 
			messageText: 'The payment currency is not available now.';
			yourself
]

{ #category : #'instance creation' }
ERException class >> paymentInvalid [
		^ self new
			messageText: 'The type of payment entered is not valid. ';
			yourself
]

{ #category : #'instance creation' }
ERException class >> paymentTypeNoValid [
		^ self new 
			messageText: 'The payment type is not valid';
			yourself
]

{ #category : #'instance creation' }
ERException class >> ticketDoesNotExist [
		^ self new
			messageText: 'The ticket does not exist for this conference';
			yourself
]

{ #category : #'instance creation' }
ERException class >> ticketIdAlreadyRegistered [
		^ self new
				messageText: 'This Ticket ID is already registered';
				yourself
]

{ #category : #'instance creation' }
ERException class >> ticketWasExceeded [
		^ self new 
			messageText: 'The limit of the ticket was exceeded, you can not use it';
			yourself
]

{ #category : #'instance creation' }
ERException class >> ticketWithIdAlreadyExist [
		^ self new 
			messageText: 'There is already a previously registered ticket with this ticket ID';
			yourself
]

{ #category : #accessing }
ERException >> defaultAction [
	^ self 
]
