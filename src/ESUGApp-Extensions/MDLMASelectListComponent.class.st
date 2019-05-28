"
Description
--------------------

MDL component class for a MASingleOptionDescription
"
Class {
	#name : #MDLMASelectListComponent,
	#superclass : #MASelectListComponent,
	#category : #'ESUGApp-Extensions'
}

{ #category : #'rendering-grouped' }
MDLMASelectListComponent >> renderEditorForGroupedOn: html [
	| inputId |
	inputId := self labelId.
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: inputId;
				with: self magritteDescription label.
				html select
		class: 'mdl-textfield__input';
		id: inputId;
		addAttributeAt: 'disabled' if: self disabled;
		dispatchCallback;
		with: [ self renderGroupsOn: html ] ]
	
]

{ #category : #'rendering-grouped' }
MDLMASelectListComponent >> renderEditorForUngroupedOn: html [
	| inputId |
	inputId := self labelId.
	html mdlTextFieldContainer
		style: 'display: block';
		floatingLabel;
		with: [ html mdlTextFieldLabel
				for: inputId;
				with: self magritteDescription label.
	html  select
		class: 'mdl-textfield__input';
		id: self labelId;
		addAttributeAt: 'disabled' if: self disabled;
		list: self options;
		selected: self value;
		callback: [ :arg2 | self value: arg2 ];
		labels: [ :arg3 | self labelForOption: arg3 ] ]
]
