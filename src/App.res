open Belt
@module external interests: string = "./Interests.json"
// @module external papers: string = "./papers.html"

let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm border-b2" // mx-0 py-4 px-5 "
let activeClassName = "border-black border-b text-sm cursor-default"
let inactiveClassName = "border-transparent hover:border-gray-700 hover:text-gray-800 border-b text-sm"

type route = Interests | Publications | Projects | Education | WorkExperience | Reading | Invalid
let routes = [Interests, Publications, Projects, Education, WorkExperience, Reading]
let stringToRoute = (string: string): route =>
  switch string {
  | "Interests" => Interests
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "WorkExperience" => WorkExperience
  | "Reading" => Reading
  | _ => Invalid
  }

let routeToString = (route: route): string =>
  switch route {
  | Interests => "Interests"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "WorkExperience"
  | Reading => "Reading"
  | Invalid => "Invalid"
  }

@react.component
let make = (): React.element => {
  let url = RescriptReactRouter.useUrl()
  let route = url.hash->stringToRoute
  <div
    className="w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-10 max-w-prose h-screen">
      <nav className="flex flex-row flex-wrap justify-between">
        {routes
        ->Array.map(r =>
          <a
            href={`#${r->routeToString}`}
            className={r == route ? activeClassName : inactiveClassName}>
            {r->routeToString->React.string}
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
            | Interests => <p> {interests->React.string} </p>
            | Publications => <iframe src="<p> hello </p>"> {interests->React.string} </iframe>
            | Projects =>
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
