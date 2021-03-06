
switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<Counter initialValue={0} />, root)
| None => Js.log("Error: could not find react element")
}
