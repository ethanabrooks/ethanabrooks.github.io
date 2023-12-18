module Array = Belt.Array
@module external rawWork: Js.Json.t = "/static/Work.json"

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
            <p className=Tailwind.liPrimaryClassName> {role->React.string} </p>
            <p className=Tailwind.liSecondaryClassName> {description->Util.parseHtml} </p>
          </div>
        </li>
      )
      ->React.array}
    </ul>
  )
  ->Util.getOrErrorPage
