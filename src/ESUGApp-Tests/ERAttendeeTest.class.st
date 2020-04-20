"
Description
--------------------

A ERTestAttendee is a test class for testing the behavior of ERAttendee model
"
Class {
	#name : #ERAttendeeTest,
	#superclass : #ERModelTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERAttendeeTest >> testHasCoupon [
	| attendee |
	attendee := self class testAttendee.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: ''.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: self validCoupon ticketId.
	self assert: attendee hasCoupon 
]
