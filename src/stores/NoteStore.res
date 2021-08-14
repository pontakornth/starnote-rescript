@module("nanoid") external nanoid: () => string = "nanoid"
open Belt.Array

type note = {
	title: string,
	content: string,
	id: string,
}

type noteState = {
	currentNoteIndex: int,
	notes:  array<note>,
	isEditing: bool,
}

type noteActions =
    | AddNote(string)
	| DeleteNote(string)
	| EditNote(note)
	| SetNoteIndex(int)
	| ToggleMode

let useNotes = () => React.useReducer((state, action) => {
	// TODO: find a way to handle localstorage
	switch action {
		| AddNote(title) => { ...state, notes: concat(state.notes, [{
			id: nanoid(),
			title: title,
			content: ""
		}])}
		| DeleteNote(id) => {... state, notes: keep(state.notes, n => n.id != id)} 
		| EditNote(note) => {...state, notes: map(state.notes, n => n.id == note.id ? note : n)}
		| SetNoteIndex(index) => {...state, currentNoteIndex: index}
		| ToggleMode => {...state, isEditing: !state.isEditing}
	}}, {
	currentNoteIndex: 0,
	notes: [{
		id: nanoid(),
		title: "Hello, Note",
		content: "## Good luck"
	}],
	isEditing: true
})
