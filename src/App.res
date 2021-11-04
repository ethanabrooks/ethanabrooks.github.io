open Belt

type config = {template: string, lang: string}

type t
@new @module external citeSingle: string => t = "citation-js"
@new @module external citeMultiple: array<string> => t = "citation-js"
@send external format: (t, string, config) => string = "format"

@module external rawInterests: Js.Json.t = "./Interests.json"
@module external rawProjects: Js.Json.t = "./Projects.json"

@decco
type interests = string

type project = {
  title: string,
  keywords: array<string>,
  startDate: string,
  endDate: option<string>,
  description: string,
}

let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm border-b2" // mx-0 py-4 px-5 "
let activeClassName = "border-black border-b text-sm cursor-default"
let inactiveClassName = "border-transparent hover:border-gray-700 hover:text-gray-800 border-b text-sm"

@react.component
let make = (): React.element => {
  let url = RescriptReactRouter.useUrl()
  let route = url.hash->Route.fromString
  <div
    className="w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-10 max-w-prose h-screen">
      <nav className="flex flex-row flex-wrap justify-between">
        {Route.array
        ->Array.mapWithIndex((i, r) =>
          <a
            key={i->Int.toString}
            href={`#${r->Route.toString}`}
            className={r == route ? activeClassName : inactiveClassName}>
            {r->Route.toString->React.string}
          </a>
        )
        ->React.array}
      </nav>
      <div className="flex flex-row flex-grow items-center">
        <div>
          <h3
            className="rounded-t-md ring-black ring-opacity-5 bg-white p-5  border-gray-200 
             text-lg font-medium text-gray-900">
            {url.hash->React.string}
          </h3>
          <div
            className="
rounded-b-md ring-1 ring-black ring-opacity-5 bg-white p-5  border-gray-200
">
            {switch route {
            | Interests =>
              <p>
                {switch rawInterests->interests_decode {
                | Error(error) => <ErrorPage error />
                | Ok(interests) => <p> {interests->React.string} </p>
                }}
              </p>
            | Publications =>
              let config: config = {template: "citation-mla", lang: "en-us"}
              let citation = citeMultiple([
                "@article{1stlt2014hazing,
  title={Hazing Versus Challenging},
  author={Brooks, Ethan},
  journal={Marine Corps Gazette},
  volume={98},
  number={8},
  pages={24--25},
  year={2014},
  publisher={Marine Corps Association \& Foundation}
}",
              ])
              let formatted = citation->format("bibliography", config)

              <p> {formatted->React.string} </p>
            | Projects =>
              // Js.log(projects->Js.Json.stringify)
              <ul className="divide-y divide-gray-200">
                <li> <p> {"Test"->React.string} </p> </li>
                <li> <p> {"Test"->React.string} </p> </li>
              </ul>
            | _ =>
              <p className="">
                {"
      Under construction
      "->React.string}
              </p>
            }}
          </div>
        </div>
      </div>
    </div>
  </div>
}
