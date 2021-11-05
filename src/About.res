@module external about: string = "./About.html"
@module external parseHtml: string => React.element = "html-react-parser"

@react.component
let make = (~inputRef) =>
  <div ref=inputRef className=Tailwind.divideClassName> {about->parseHtml} </div>
