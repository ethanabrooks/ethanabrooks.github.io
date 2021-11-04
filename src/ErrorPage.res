@react.component
let make = (~error: Decco.decodeError): React.element => {
  <>
    <h2 className="text-lg leading-6 font-medium text-gray-900 flex-grow">
      {"Error:"->React.string}
    </h2>
    <p> {`Path: ${error.path}`->React.string} </p>
    <p> {`Message: ${error.message}`->React.string} </p>
    <p> {`Value: ${error.value->Js.Json.stringifyWithSpace(2)}`->React.string} </p>
  </>
}
