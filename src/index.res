
switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<Hello />, root)
| None => Js.log("Error: could not find react element")
}
