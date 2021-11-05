type route = About | Publications | Projects | Education | WorkExperience | Reading | Invalid | Home
let array = [Home, About, Publications, Projects, Education, WorkExperience, Reading]

let fromString = (string: string): route =>
  switch string {
  | "About / Contact" => About
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "Work Experience" => WorkExperience
  | "Currently Reading" => Reading
  | "Home"
  | "" =>
    Home
  | _ => Invalid
  }

let toString = (route: route): string =>
  switch route {
  | About => "About / Contact"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "Work Experience"
  | Reading => "Currently Reading"
  | Invalid => "Invalid"
  | Home => "Home"
  }
