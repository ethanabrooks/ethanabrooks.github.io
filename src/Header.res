@react.component
let make = (~inputRef, ~children) =>
  <h1 ref=inputRef className={`rounded-t-md ${Tailwind.h1ClassName}`}> {children} </h1>
