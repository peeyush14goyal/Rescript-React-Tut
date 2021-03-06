
let s = React.string

module Button = {
  @react.component
  let make = (~text, ~className, ~handleClick) => {
    <button className onClick=handleClick> {s(text)} </button>
  }
}

module Counter = {
  @react.component
  let make = (~initialValue) => {
    let (count, setCount) = React.useState(() => initialValue)

    let bgColor = if count == 0 {
      "bg-blue-200"
    } else if count > 0 {
      "bg-green-200"
    } else {
      "bg-red-200"
    }

    <div className="max-w-3xl mx-auto mt-24">
      <p className={`py-4 mb-8 text-center text-4xl ${bgColor}`}>
        {s("The count is " ++ count->Belt.Int.toString)}
      </p>
      <div className="flex justify-center">
        <Button text="Increment"
          className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
          handleClick={_mouseEvt => setCount(x => x + 1)}
          />
          <Button text="Decrement"
          className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
          handleClick={_mouseEvt => setCount(x => x - 1)}
          />
          <Button text="Reset"
          className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
          handleClick={_mouseEvt => setCount(_x => 0)}
          />
      </div>
    </div>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<Counter initialValue={0} />, root)
| None => Js.log("Error: could not find react element")
}
