let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm" // mx-0 py-4 px-5 "
@react.component
let make = (): React.element =>
  <div
    className="w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-5 max-w-prose h-screen">
      <nav className="flex flex-row flex-wrap justify-between">
        <a className=navItemClassName> {"Interests"->React.string} </a>
        <a className=navItemClassName> {"Publications"->React.string} </a>
        <a className=navItemClassName> {"Projects"->React.string} </a>
        <a className=navItemClassName> {"Education"->React.string} </a>
        <a className=navItemClassName> {"Work Experience"->React.string} </a>
        <a className=navItemClassName> {"Currently Reading"->React.string} </a>
      </nav>
      <div className="flex flex-row flex-grow items-center">
        <div
          className="rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none bg-white p-5 border-b border-gray-200 sm:px-6 text-gray-600">
          {"
      My interests focus on the intersection of reinforcement learning and natural language. I am interested in leveraging large data sets and the supervised models trained on them (e.g. GPT-X) to improve reinforcement learning. I am also interested in the role of reinforcement learning in discovering both natural language and structured programming languages (program synthesis). Finally, I am interested in understanding the limits of language in capturing actionable knowledge.
      "->React.string}
        </div>
      </div>
    </div>
  </div>
