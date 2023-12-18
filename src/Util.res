@module external parseHtml: string => React.element = "html-react-parser"
@module("marked") external marked: string => string = "marked"

type deccoResult<'a> = Result.t<'a, Decco.decodeError>
let getOrErrorPage = (res: deccoResult<React.element>) =>
  switch res {
  | Error(error) => <ErrorPage error />
  | Ok(page) => page
  }

let parseMd = (mdString: string) => {
  ReactDOM.createDOMElementVariadic(
    "div",
    ~props={dangerouslySetInnerHTML: {"__html": mdString->marked}},
    [],
  )
}
