@react.component
let make = (~error: Decco.decodeError): React.element => {
  <>
    <p> {error.path->React.string} </p>
    <p> {error.message->React.string} </p>
    <p> {error.value->Js.Json.stringifyWithSpace(2)->React.string} </p>
  </>
}
