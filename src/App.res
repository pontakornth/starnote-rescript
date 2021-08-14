@module external styles: {..} = "./App.module.css"

@react.component
let make = () => {
	let (noteState, dispatch) = NoteStore.useNotes()
	let toggleMode = _e => {
		dispatch(NoteStore.ToggleMode)
	}
	let editNoteContent = e => {
		let currentNote = noteState.notes[noteState.currentNoteIndex]
		dispatch(NoteStore.EditNote({...currentNote, content: ReactEvent.Form.target(e)["value"]}))
	}
	let editNoteTitle = e => {
		let currentNote = noteState.notes[noteState.currentNoteIndex]
		dispatch(NoteStore.EditNote({...currentNote, title: ReactEvent.Form.target(e)["value"]}))
	}
	<div className={styles["App"]}> 
	 <TheEditor
	    onToggleMode={toggleMode}
		onChangeContent={editNoteContent}
		isEditing={noteState.isEditing}
		onChangeTitle={editNoteTitle}
		currentNote={noteState.notes[noteState.currentNoteIndex]}

	 />
	 <TheSidebar />
	</div>
}