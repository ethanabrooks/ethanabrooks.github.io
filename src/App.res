let navItemClassName = "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm"
@react.component
let make = (): React.element => <>
  <div
    className="bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <nav className="flex space-x-8">
      <a className=navItemClassName> {"Interests"->React.string} </a>
      <a className=navItemClassName> {"Publications"->React.string} </a>
      <a className=navItemClassName> {"Projects"->React.string} </a>
      <a className=navItemClassName> {"Education"->React.string} </a>
      <a className=navItemClassName> {"Work Experience"->React.string} </a>
      <a className=navItemClassName> {"Currently Reading"->React.string} </a>
    </nav>
    // <div
    //   className="bg-cover"
    //   style={ReactDOM.Style.make(
    //     ~backgroundImage=`url('https://raw.githubusercontent.com/ethanabrooks/ethanabrooks.github.io/master/static/initials.png')`,
    //     (),
    //   )}>
    //   {"HELLO"->React.string}
    // </div>
  </div>
</>
