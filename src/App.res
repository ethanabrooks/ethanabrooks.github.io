open Belt
open Json

type config = {template: string, lang: string}

type t
@new @module external citeSingle: string => t = "citation-js"
@new @module external citeMultiple: array<string> => t = "citation-js"
@send external format: (t, string, config) => string = "format"
// @module external papers: string = "./papers.bib"

let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm border-b2" // mx-0 py-4 px-5 "
let activeClassName = "border-black border-b text-sm cursor-default"
let inactiveClassName = "border-transparent hover:border-gray-700 hover:text-gray-800 border-b text-sm"

let removeUnderscore = Js.String.replace("_", " ")

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
        ->Array.mapWithIndex((i, r) => {
          <a
            key={i->Int.toString}
            href={`#${r->Route.toString}`}
            className={r == route ? activeClassName : inactiveClassName}>
            {r->Route.toString->removeUnderscore->React.string}
          </a>
        })
        ->React.array}
      </nav>
      <div className="flex flex-row flex-grow items-center">
        <div>
          <h1
            className="rounded-t-md ring-black ring-opacity-5 bg-white p-5  border-gray-200 
             text-3xl font-bold leading-tight text-gray-900
             ">
            {url.hash->removeUnderscore->React.string}
          </h1>
          <div
            className="
rounded-b-md ring-1 ring-black ring-opacity-5 bg-white p-5  border-gray-200
">
            {switch route {
            | Interests =>
              rawInterests
              ->interests_decode
              ->Result.map(interests => <p> {interests->React.string} </p>)
              ->getOrErrorPage
            | Publications =>
              let config: config = {template: "citation-mla", lang: "en-us"}
              // Js.log(papers)
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
              rawProjects
              ->projects_decode
              ->Result.map(projects =>
                <ul className="divide-y divide-gray-200">
                  {projects
                  ->Array.mapWithIndex((i, {title, startDate, endDate, description}) =>
                    <li key={i->Int.toString}>
                      <div className="flex flex-col">
                        <div className="flex flex-row py-2">
                          <h2
                            className="
                          text-lg leading-6 font-medium text-gray-900
                          flex-grow">
                            {title->React.string}
                          </h2>
                          <p> {startDate->React.string} </p>
                          <p> {"-"->React.string} </p>
                          <p> {endDate->Option.getWithDefault("current")->React.string} </p>
                        </div>
                        <p> {description->React.string} </p>
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
                <ul className="divide-y divide-gray-200">
                  {degrees
                  ->Array.mapWithIndex((
                    i,
                    {institution, degree, info, startDate, endDate, location},
                  ) =>
                    <li key={i->Int.toString}>
                      <div className="flex flex-col">
                        <div className="flex flex-row py-2">
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
                <ul className="divide-y divide-gray-200">
                  {books
                  ->Array.mapWithIndex((i, {title, author, translator, link}) =>
                    <li key={i->Int.toString}>
                      <div className="flex flex-col">
                        <div className="flex flex-row py-2 space-x-4">
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
                    </li>
                  )
                  ->React.array}
                </ul>
              )
              ->getOrErrorPage
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
