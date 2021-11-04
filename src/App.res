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

@react.component
let make = (): React.element => {
  let url = RescriptReactRouter.useUrl()
  let route = url.hash->Js.Global.decodeURI->Route.fromString
  Js.log(url.hash->Js.Global.decodeURI)
  <div
    className="w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-10 max-w-prose h-screen">
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
      <div className="flex flex-row flex-grow items-center">
        <div>
          {switch route {
          | Home => <> </>
          | Invalid =>
            <h1
              className={`rounded-md ring-black ring-opacity-5 bg-white border-gray-200 
             text-3xl font-bold leading-tight text-gray-900
             ${padding}
             `}>
              {"Page not found."->React.string}
            </h1>
          | _ =>
            <h1
              className={`rounded-t-md ring-black ring-opacity-5 bg-white border-gray-200 
             text-3xl font-bold leading-tight text-gray-900
             ${padding}
             `}>
              {route->Route.toString->React.string}
            </h1>
          }}
          <div
            className="
rounded-b-md ring-1 ring-black ring-opacity-5 bg-white  border-gray-200
">
            {switch route {
            | Home => <> </>
            | AboutMe =>
              rawAbout
              ->aboutMe_decode
              ->Result.map(interests => <p className=padding> {interests->React.string} </p>)
              ->getOrErrorPage
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
                    let li =
                      <li key={i->Int.toString}>
                        <div className={`flex flex-col ${padding}`}>
                          <div className="flex flex-row py-2">
                            <h2 className="text-lg leading-6 font-medium text-gray-900 flex-grow">
                              {title->React.string}
                            </h2>
                            <p> {startDate->React.string} </p>
                            <p> {"-"->React.string} </p>
                            <p> {endDate->Option.getWithDefault("current")->React.string} </p>
                          </div>
                          <p> {description->React.string} </p>
                        </div>
                      </li>
                    link->Option.mapWithDefault(li, link => <a href={link}> {li} </a>)
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
                          <h2
                            className="
                          text-lg leading-6 font-medium text-gray-900
                          flex-grow">
                            {`${institution} ${location->Option.mapWithDefault("", location =>
                                `(${location})`
                              )}`->React.string}
                          </h2>
                          <p> {startDate->React.string} </p>
                          {endDate->Option.mapWithDefault(<> </>, endDate => <>
                            <p> {"-"->React.string} </p> <p> {endDate->React.string} </p>
                          </>)}
                        </div>
                        <p> {role->React.string} </p>
                        <p className="text-gray-500"> {description->React.string} </p>
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
                          <h2
                            className="
                          text-lg leading-6 font-medium text-gray-900
                          flex-grow">
                            {`${institution} (${location})`->React.string}
                          </h2>
                          <p> {startDate->React.string} </p>
                          <p> {"-"->React.string} </p>
                          <p> {endDate->React.string} </p>
                        </div>
                        <p> {degree->React.string} </p>
                        {info->Option.mapWithDefault(<> </>, info =>
                          <p className="text-gray-500"> {info->React.string} </p>
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
                      <a href=link>
                        <div className={`flex flex-col ${padding}`}>
                          <div className="flex flex-row space-x-4">
                            <h2
                              className="
                          text-lg leading-6 font-medium text-gray-900
                          flex-grow">
                              {title->React.string}
                            </h2>
                            <p> {author->React.string} </p>
                          </div>
                          {translator->Option.mapWithDefault(<> </>, translator =>
                            <p className="text-gray-500">
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
