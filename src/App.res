@module external styles: {..} = "./App.module.css"

@react.component
let make = () => {
	let boxed = NoteStore.useNotes(state => NoteStore.UnitFunc(state.loadFromLocalStorage))
	React.useEffect0(() => {
		switch boxed {
		| UnitFunc(f) => f()
		| _ => failwith("Something wrong")
		}
	None
	})
	<div> 
	 <TheEditor />
	 <TheSidebar />
	</div>
}