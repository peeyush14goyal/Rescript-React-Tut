
let s = React.string

module App = {
  @react.component
  let make = () => {
    let (initialValue, setInitialValue) = React.useState(() => 0)

    let handleChange = event => {
      let target = event->ReactEvent.Form.target
      target["value"]->Belt.Int.fromString->Belt.Option.map(x => setInitialValue(_ => x)) -> ignore
    }

    <div className="max-w-3xl mx-auto mt-24">
      <label className="mb-16 block">
        <span className="mr-4"> {s("Change the initial value")} </span>
        <input
          className="w-24"
          type_="number"
          value={initialValue->Belt.Int.toString}
          onChange=handleChange
        />
      </label>
      <Counter initialValue/>
    </div>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => Js.log("Error: could not find react element")
}
