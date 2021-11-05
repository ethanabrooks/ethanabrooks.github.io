type route = About | Publications | Projects | Education | WorkExperience | Reading | Invalid | Home
let array = [Home, About, Publications, Projects, Education, WorkExperience, Reading]

let fromString = (string: string): route =>
  switch string {
  | "About" => About
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "Work Experience" => WorkExperience
  | "Books I'm Reading" => Reading
  | "Home"
  | "" =>
    Home
  | _ => Invalid
  }

let toString = (route: route): string =>
  switch route {
  | About => "About"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "Work Experience"
  | Reading => "Books I'm Reading"
  | Invalid => "Invalid"
  | Home => "Home"
  }
