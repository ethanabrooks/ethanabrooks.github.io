open Belt
@module external rawInterests: Js.Json.t = "./Interests.json"
@module external rawProjects: Js.Json.t = "./Projects.json"
@module external rawEducation: Js.Json.t = "./Education.json"
@module external rawReading: Js.Json.t = "./Reading.json"

@decco
type interests = string

@decco
type project = {
  title: string,
  keywords: array<string>,
  startDate: string,
  endDate: option<string>,
  description: string,
  link: option<string>,
}

@decco type projects = array<project>

@decco
type degree = {
  institution: string,
  degree: string,
  info: option<string>,
  startDate: string,
  endDate: string,
  location: string,
  gpa: option<float>,
}

@decco
type education = array<degree>

@decco
type book = {
  title: string,
  author: string,
  link: string,
  translator: option<string>,
}

@decco
type reading = array<book>

type deccoResult<'a> = Result.t<'a, Decco.decodeError>
let getOrErrorPage = (res: deccoResult<React.element>) =>
  switch res {
  | Error(error) => <ErrorPage error />
  | Ok(page) => page
  }
