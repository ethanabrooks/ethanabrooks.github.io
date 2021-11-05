open Belt

@module external rawProjects: Js.Json.t = "./Projects.json"

@decco
type project = {
  title: string,
  keywords: array<string>,
  startDate: string,
  endDate: option<string>,
  description: string,
  link: option<string>,
}

@decco type projects = array<project>

@react.component
let make = (~inputRef) =>
  rawProjects
  ->projects_decode
  ->Result.map(projects =>
    <ul ref=inputRef className=Tailwind.divideClassName>
      {projects
      ->Array.mapWithIndex((i, {title, startDate, endDate, description, link}) => {
        let content =
          <div className={`flex flex-col ${Tailwind.padding}`}>
            <div className="flex flex-row py-2">
              <h2 className=Tailwind.h2ClassName> {title->React.string} </h2>
              <p> {startDate->React.string} </p>
              <p> {"-"->React.string} </p>
              <p> {endDate->Option.getWithDefault("current")->React.string} </p>
            </div>
            <p className=Tailwind.liPrimaryClassName> {description->React.string} </p>
          </div>
        <li key={i->Int.toString}>
          {link->Option.mapWithDefault(content, link =>
            <a
              key={i->Int.toString} href=link target="_blank" className=Tailwind.clickableClassName>
              {content}
            </a>
          )}
        </li>
      })
      ->React.array}
    </ul>
  )
  ->Util.getOrErrorPage
