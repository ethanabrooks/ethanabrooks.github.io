open Belt
type deccoResult<'a> = Result.t<'a, Decco.decodeError>
let getOrErrorPage = (res: deccoResult<React.element>) =>
  switch res {
  | Error(error) => <ErrorPage error />
  | Ok(page) => page
  }
