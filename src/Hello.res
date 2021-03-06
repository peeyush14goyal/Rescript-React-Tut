let s = React.string

@react.component
let make = () => {
  let className = "text-center mt-10 text-6xl text-blue-500"
  <p className> {s("Hello!")} </p>
}
