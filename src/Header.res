@react.component
let make = (~inputRef, ~children) =>
  <h1
    ref=inputRef
    className={`rounded-t-md ring-black ring-opacity-5 border-b bg-white text-3xl font-bold text-gray-900 ${Tailwind.padding}`}>
    {children}
  </h1>
