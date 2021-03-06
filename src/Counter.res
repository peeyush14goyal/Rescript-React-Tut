let s = React.string

module LogEntry: {
  type t

  let make: string => t
  let id: t => int
  let text: t => string
} = {
  type t = {
    id: int,
    text: string
  }

  type date
  @new external makeDate: date = "Date"
  @send external getTimestamp: date => int = "getTime"

  let make = text => {id: makeDate->getTimestamp, text: text}

  let id = t => t.id

  let text = t => t.text
}

module LogItem = {
  @react.component
  let make = (~text) => <p> {s(text)} </p>
}

module LogViewer = {
  @react.component
  let make = (~logs) => {
    let logItems = logs->Belt.Array.map(x => <LogItem key={x->LogEntry.id->Belt.Int.toString} text={x->LogEntry.text} />)

    <div className="h-36 overflow-y-scroll border-2 bg-gray-200 text-sm py-2 px-4">
      {logItems->React.array}
    </div>
  }
}

type action =
  | Increment
  | Decrement
  | Reset(int)

let reducer = (state, action) =>
  switch action {
    | Increment => state + 1
    | Decrement => state - 1
    | Reset(initialValue) => initialValue
  }

@val external document: {..} = "document"

@react.component
let make = (~initialValue) => {
  let (count, dispatch) = React.useReducer(reducer, initialValue)
  let (history, setHistory) = React.useState((): array<LogEntry.t> => [])

  // Runs only once at time of mounting
  React.useEffect0(() => {
    Js.log("Counter component mounted")

    // Some(() => Js.log("Counter component unmounted"))
    None
  })

  React.useEffect(() => {
    let title = `Count is ${count->Belt.Int.toString}`
    document["title"] = title

    // Some(() => document["title"] = "Timers")
    None
  })

  React.useEffect1(() => {
    dispatch(Reset(initialValue))
    setHistory(xs => Js.Array2.concat([`Reset initialvalue to ${initialValue->Belt.Int.toString}`->LogEntry.make], xs))
    None
  }, [initialValue])


  let bgColor = if count == 0 {
    "bg-blue-200"
  } else if count > 0 {
    "bg-green-200"
  } else {
    "bg-red-200"
  }

  <div className="max-w-3xl mx-auto">
    <p className={`py-4 mb-8 text-center text-4xl ${bgColor}`}>
      {s("The count is " ++ count->Belt.Int.toString)}
    </p>
    <div className="flex justify-center mb-16">
      <Button text="Increment"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => {
          dispatch(Increment)
          setHistory(xs => Js.Array2.concat([`Increment ${count->Belt.Int.toString}`->LogEntry.make], xs))
          }
        }
        />
        <Button text="Decrement"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => {
          dispatch(Decrement)
          setHistory(xs => Js.Array2.concat([`Decrement ${count->Belt.Int.toString}`->LogEntry.make], xs))
          }
        }
        />
        <Button text="Reset"
        className="border py-2 px-4 bg-gray-200 hover:bg-blue-200 mr-2"
        handleClick={_mouseEvt => {
          dispatch(Reset(initialValue))
          setHistory(xs => Js.Array2.concat([`Reset ${count->Belt.Int.toString}`->LogEntry.make], xs))
          }
        }
        />
    </div>
    <LogViewer logs=history />
  </div>
}
