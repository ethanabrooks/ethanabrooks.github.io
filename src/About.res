@module external about: string = "./About.html"
@module external parseHtml: string => React.element = "html-react-parser"

@react.component
let make = (~inputRef) =>
  <div ref=inputRef className=Tailwind.divideClassName>
    <div className="p-5 space-y-3"> {about->parseHtml} </div>
    <div className="p-5 space-y-3"> {about->parseHtml} </div>
  </div>
