module Array = Belt.Array
@module external rawWork: Js.Json.t = "/static/Work.json"

@module("marked") external marked: string => string = "marked"

@decco
type job = {
  institution: string,
  keywords: array<string>,
  role: string,
  description: string,
  location: option<string>,
  startDate: string,
  endDate: option<string>,
}

@decco
type work = array<job>

let parseMd = (mdString: string) => {
  Js.log(mdString)
  ReactDOM.createDOMElementVariadic(
    "div",
    ~props={dangerouslySetInnerHTML: {"__html": mdString->marked}},
    [],
  )
}

@react.component
let make = (~inputRef) =>
  rawWork
  ->work_decode
  ->Result.map(jobs =>
    <ul ref=inputRef className=Tailwind.divideClassName>
      {jobs
      ->Array.mapWithIndex((i, {institution, role, description, location, startDate, endDate}) =>
        <li key={i->Int.toString}>
          <div className={`flex flex-col ${Tailwind.padding}`}>
            <div className="flex flex-row">
              <h2 className=Tailwind.h2ClassName>
                {`${institution} ${location->Option.mapOr(
                    "",
                    location => `(${location})`,
                  )}`->React.string}
              </h2>
              <p> {startDate->React.string} </p>
              {endDate->Option.mapOr(
                <> </>,
                endDate => <>
                  <p> {"-"->React.string} </p>
                  <p> {endDate->React.string} </p>
                </>,
              )}
            </div>
            <p className=Tailwind.liPrimaryClassName> {role->parseMd} </p>
            <p className=Tailwind.liSecondaryClassName> {description->parseMd} </p>
          </div>
        </li>
      )
      ->React.array}
    </ul>
  )
  ->Util.getOrErrorPage
