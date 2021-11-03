let navItemClassName = "hover:text-gray-700 hover:border-gray-300 text-sm p-5" // mx-0 py-4 px-5 "
@react.component
let make = (): React.element => <>
  <div
    className=" flex w-screen h-screen bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <nav className="flex">
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
