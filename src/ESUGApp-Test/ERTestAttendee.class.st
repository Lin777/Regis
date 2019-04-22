"
Description
--------------------

A ERTestAttendee is a test class for testing the behavior of ERAttendee model
"
Class {
	#name : #ERTestAttendee,
	#superclass : #ERTestModel,
	#category : #'ESUGApp-Test-UnitTest'
}

{ #category : #tests }
ERTestAttendee >> testHasCoupon [
	|attendee|
	attendee := self class testAttendee.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: ''.
	self deny: attendee hasCoupon.
	attendee paymentInformation coupon: self validCoupon ticketId.
	self assert: attendee hasCoupon 
]
