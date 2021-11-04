type route =
  AboutMe | Publications | Projects | Education | WorkExperience | Reading | Invalid | Home
let array = [AboutMe, Publications, Projects, Education, WorkExperience, Reading]

let fromString = (string: string): route =>
  switch string {
  | "About Ethan" => AboutMe
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "Work Experience" => WorkExperience
  | "Current Reading" => Reading
  | "" => Home
  | _ => Invalid
  }

let toString = (route: route): string =>
  switch route {
  | AboutMe => "About Ethan"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "Work Experience"
  | Reading => "Current Reading"
  | Invalid => "Invalid"
  | Home => ""
  }
