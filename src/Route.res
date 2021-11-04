type route =
  AboutMe | Publications | Projects | Education | WorkExperience | Reading | Invalid | Home
let array = [Home, AboutMe, Publications, Projects, Education, WorkExperience, Reading]

let fromString = (string: string): route =>
  switch string {
  | "About" => AboutMe
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "Work Experience" => WorkExperience
  | "Reading" => Reading
  | "Home"
  | "" =>
    Home
  | _ => Invalid
  }

let toString = (route: route): string =>
  switch route {
  | AboutMe => "About"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "Work Experience"
  | Reading => "Reading"
  | Invalid => "Invalid"
  | Home => "Home"
  }
