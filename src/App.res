@module external styles: {..} = "./App.module.css"

@react.component
let make = () => {
	<div> 
	 <TheEditor />
	 <TheSidebar />
	</div>
}