open Belt
open Json

type config = {template: string, lang: string}

type entry
type entries = Js.Array.array_like<entry>

type citation
@new @module external citeBib: string => entries = "citation-js"
@new @module external cite: entry => citation = "citation-js"
@send external format: (citation, string, config) => string = "format"
@module external papers: string = "./papers.bib"

let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm border-b2"
let activeClassName = "border-black border-b text-sm cursor-default"
let inactiveClassName = "border-transparent hover:border-gray-700 hover:text-gray-800 border-b text-sm"
let divideClassName = "divide-y divide-gray-200"
let padding = "p-5"
let h1ClassName = `ring-black ring-opacity-5 bg-white text-3xl font-bold text-gray-900 ${padding}`
let h2ClassName = "text-lg leading-6 font-medium text-gray-900 flex-grow"
let liPrimaryClassName = ""
let liSecondaryClassName = "text-gray-500"
let clickableClassName = "block hover:bg-gray-50"

@react.component
let make = (): React.element => {
  let url = RescriptReactRouter.useUrl()
  let route = url.hash->Js.Global.decodeURI->Route.fromString
  <div
    className="w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-10 w-2/5 h-screen">
      <nav className="flex flex-row flex-wrap justify-between">
        {Route.array
        ->Array.mapWithIndex((i, r) => {
          <a
            key={i->Int.toString}
            href={`#${r->Route.toString->Js.Global.encodeURI}`}
            className={r == route ? activeClassName : inactiveClassName}>
            {r->Route.toString->React.string}
          </a>
        })
        ->React.array}
      </nav>
      <div className={`flex flex-row flex-grow ${route == Home ? "" : "items-center"}`}>
        <div>
          {switch route {
          | Home =>
            <h1 className="text-5xl tracking-tight text-gray-900 py-10">
              <p className="block xl"> {"Ethan A. Brooks"->React.string} </p>
              <p className="block text-gray-600 xl"> {"Researcher"->React.string} </p>
              <p className="block text-gray-600 xl"> {"Reinforcement Learning"->React.string} </p>
              <p className="block text-gray-600 xl"> {"Natural Language"->React.string} </p>
            </h1>
          | Invalid =>
            <h1 className={`rounded-md ${h1ClassName}`}> {"Page not found."->React.string} </h1>
          | _ =>
            <h1 className={`rounded-t-md border-b ${h1ClassName}`}>
              {route->Route.toString->React.string}
            </h1>
          }}
          <div className="rounded-b-md ring-black ring-opacity-5 bg-white  border-gray-200">
            {switch route {
            | Home => <> </>
            | AboutMe =>
              aboutMe
              ->Js.String2.split("\n\n")
              ->Array.mapWithIndex((i, paragraph) =>
                <p key={i->Int.toString} className={padding}> {paragraph->React.string} </p>
              )
              ->React.array
            | Publications =>
              let config: config = {template: "citation-mla", lang: "en-us"}
              <ul className=divideClassName>
                {papers
                ->citeBib
                ->Js.Array.from
                ->Array.map(cite)
                ->Array.map(citation => citation->format("bibliography", config))
                ->Array.mapWithIndex((i, citation) => {
                  <li key={i->Int.toString}>
                    <p className=padding> {citation->React.string} </p>
                  </li>
                })
                ->React.array}
              </ul>

            | Projects =>
              rawProjects
              ->projects_decode
              ->Result.map(projects =>
                <ul className=divideClassName>
                  {projects
                  ->Array.mapWithIndex((i, {title, startDate, endDate, description, link}) => {
                    let content =
                      <div className={`flex flex-col ${padding}`}>
                        <div className="flex flex-row py-2">
                          <h2 className=h2ClassName> {title->React.string} </h2>
                          <p> {startDate->React.string} </p>
                          <p> {"-"->React.string} </p>
                          <p> {endDate->Option.getWithDefault("current")->React.string} </p>
                        </div>
                        <p className=liPrimaryClassName> {description->React.string} </p>
                      </div>
                    <li key={i->Int.toString}>
                      {link->Option.mapWithDefault(content, link =>
                        <a key={i->Int.toString} href=link className=clickableClassName>
                          {content}
                        </a>
                      )}
                    </li>
                  })
                  ->React.array}
                </ul>
              )
              ->getOrErrorPage
            | WorkExperience =>
              rawWork
              ->work_decode
              ->Result.map(jobs =>
                <ul className=divideClassName>
                  {jobs
                  ->Array.mapWithIndex((
                    i,
                    {institution, role, description, location, startDate, endDate},
                  ) =>
                    <li key={i->Int.toString}>
                      <div className={`flex flex-col ${padding}`}>
                        <div className="flex flex-row">
                          <h2 className=h2ClassName>
                            {`${institution} ${location->Option.mapWithDefault("", location =>
                                `(${location})`
                              )}`->React.string}
                          </h2>
                          <p> {startDate->React.string} </p>
                          {endDate->Option.mapWithDefault(<> </>, endDate => <>
                            <p> {"-"->React.string} </p> <p> {endDate->React.string} </p>
                          </>)}
                        </div>
                        <p className=liPrimaryClassName> {role->React.string} </p>
                        <p className=liSecondaryClassName> {description->React.string} </p>
                      </div>
                    </li>
                  )
                  ->React.array}
                </ul>
              )
              ->getOrErrorPage

            | Education =>
              rawEducation
              ->education_decode
              ->Result.map(degrees =>
                <ul className=divideClassName>
                  {degrees
                  ->Array.mapWithIndex((
                    i,
                    {institution, degree, info, startDate, endDate, location},
                  ) =>
                    <li key={i->Int.toString}>
                      <div className={`flex flex-col ${padding}`}>
                        <div className="flex flex-row">
                          <h2 className=h2ClassName>
                            {`${institution} (${location})`->React.string}
                          </h2>
                          <p> {startDate->React.string} </p>
                          <p> {"-"->React.string} </p>
                          <p> {endDate->React.string} </p>
                        </div>
                        <p className=liPrimaryClassName> {degree->React.string} </p>
                        {info->Option.mapWithDefault(<> </>, info =>
                          <p className=liSecondaryClassName> {info->React.string} </p>
                        )}
                      </div>
                    </li>
                  )
                  ->React.array}
                </ul>
              )
              ->getOrErrorPage
            | Reading =>
              rawReading
              ->reading_decode
              ->Result.map(books =>
                <ul className=divideClassName>
                  {books
                  ->Array.mapWithIndex((i, {title, author, translator, link}) =>
                    <li key={i->Int.toString}>
                      <a href=link className=clickableClassName>
                        <div className={`flex flex-col  ${padding}`}>
                          <div className="flex flex-row space-x-4">
                            <h2 className=h2ClassName> {title->React.string} </h2>
                            <p> {author->React.string} </p>
                          </div>
                          {translator->Option.mapWithDefault(<> </>, translator =>
                            <p className=liPrimaryClassName>
                              {`Translated by ${translator}`->React.string}
                            </p>
                          )}
                        </div>
                      </a>
                    </li>
                  )
                  ->React.array}
                </ul>
              )
              ->getOrErrorPage
            | _ => <> </>
            }}
          </div>
        </div>
      </div>
    </div>
  </div>
}
