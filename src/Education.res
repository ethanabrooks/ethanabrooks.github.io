module Array = Belt.Array

@module external rawEducation: Js.Json.t = "/static/Education.json"

@decco
type degree = {
  institution: string,
  degree: string,
  info: option<string>,
  startDate: string,
  endDate: string,
  location: string,
  gpa: option<float>,
}

@decco
type education = array<degree>

@react.component
let make = (~inputRef) =>
  rawEducation
  ->education_decode
  ->Result.map(degrees =>
    <ul ref=inputRef className=Tailwind.divideClassName>
      {degrees
      ->Array.mapWithIndex((i, {institution, degree, info, startDate, endDate, location}) =>
        <li key={i->Int.toString}>
          <div className={`flex flex-col ${Tailwind.padding}`}>
            <div className="flex flex-row">
              <h2 className=Tailwind.h2ClassName>
                {`${institution} (${location})`->React.string}
              </h2>
              <p> {startDate->React.string} </p>
              <p> {"-"->React.string} </p>
              <p> {endDate->React.string} </p>
            </div>
            <p className=Tailwind.liPrimaryClassName> {degree->React.string} </p>
            {info->Option.mapOr(
              <> </>,
              info => <p className=Tailwind.liSecondaryClassName> {info->React.string} </p>,
            )}
          </div>
        </li>
      )
      ->React.array}
    </ul>
  )
  ->Util.getOrErrorPage
