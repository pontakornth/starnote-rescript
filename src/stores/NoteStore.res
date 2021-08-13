@module("nanoid") external nanoid: () => string = "nanoid"

type note = {
	title: string,
	content: string,
	id: string,
}

type noteState = {
	currentNoteIndex: int,
	notes:  array<note>,
	isEditing: bool,
	addNote: (string) => unit,
	deleteNote: (string) => unit,
	editNote: (note) => unit,
	setNoteIndex: (int) => unit,
	toggleMode: () => unit,
	saveToLocalStorage: () => unit,
	loadFromLocalStorage: () => unit
}

type stateVariant = 
	| Notes(array<note>)
	| Bool(bool)
	| IdFunc(string => unit)
	| NoteFunc(note => unit)
	| UnitFunc(() => unit)


type set = (noteState => noteState) => unit
type get = () => noteState
@module("zustand") external create: ((set, get) => noteState) => (noteState => stateVariant) => stateVariant = "default"
@val external setLocalStorage: (string, string) => unit = "window.localStorage.setItem"
@val external getLocalStorage: (string) => string = "window.localStorage.getItem"
@scope("JSON") @val
external parseIntoNoteState: string => noteState = "parse"

let useNotes = create((set, get) => {
	currentNoteIndex: 0,
	notes: [{
		id: nanoid(),
		title: "Hello, Note",
			content: "You can basically enter anything here.",
	}],
	isEditing: true,
	addNote: (title) => set(state => {...state, notes: 
		Belt.Array.concat(state.notes, [{
			id: nanoid(),
			title: title,
			content: ""
		}])
		
	}),
	deleteNote: (id) => set(state => {
		...state,
		notes: Belt.Array.keep(state.notes,note => note.id != id)
	}),
	editNote: (note) => set(state => {
		...state,
		notes: Belt.Array.map(state.notes, n => note.id == n.id ? n : note)
	}),
	setNoteIndex: (index) => set(state => {...state, currentNoteIndex: index}),
	toggleMode: () => set(state => {...state, isEditing: !state.isEditing}),
	saveToLocalStorage: () => {
		let state = get()
		let savedState = {...state, currentNoteIndex: state.currentNoteIndex, notes: state.notes}
		switch Js.Json.stringifyAny(savedState) {
		| Some(json) => setLocalStorage("state", json)
		| _ => setLocalStorage("state", "{}")
		}
	},
	loadFromLocalStorage: () => set(_state => {
		let loadedState = parseIntoNoteState(getLocalStorage("state"))
		loadedState
	})

})