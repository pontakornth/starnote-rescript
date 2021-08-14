@module external styles: {..} = "./TheEditor.module.css"
@module("./TheEditorComponent") external components: {..} = "components"

module ReactMarkdown = {
	@react.component @module("react-markdown") 
	external make: (~children: React.element, ~components: {..}) => React.element = "default"
}

@react.component
let make = (~onChangeContent, ~onChangeTitle, ~onToggleMode, ~isEditing, ~currentNote: NoteStore.note) => {

	<div className={styles["theEditor"]}>
	   <div className={styles["tabs"]}>
	      <button 
		     onClick={onToggleMode}
			 className={styles["tab"]}>
			 {React.string("Edit Mode")}
		  </button>
	   </div>
	   <div className={j`${styles["editorContent"]} ${isEditing ? styles["isEditing"] : ""}`}>
	   {isEditing ? 
	   	   <>
	   <input
	     type_="text"
		 onChange={onChangeTitle}
		 value={currentNote.title}
		 className={styles["titleInput"]}
		 placeholder="Title here."
	   />
	   <textarea
	     value={currentNote.content}
		 onChange={onChangeContent}
		 className={styles["contentInput"]}
		 placeholder="Content here"
	   >
	   </textarea>
	   </>
	   : 
	   <>
	   <h1>{React.string(currentNote.title)}</h1>
	   <ReactMarkdown components>
	   {React.string(currentNote.content)}
	   </ReactMarkdown>
	   </>}
	   </div>
	 </div>
}