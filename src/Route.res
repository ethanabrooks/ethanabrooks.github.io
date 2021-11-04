type route = Interests | Publications | Projects | Education | WorkExperience | Reading | Invalid
let array = [Interests, Publications, Projects, Education, WorkExperience, Reading]

let fromString = (string: string): route =>
  switch string {
  | "Interests" => Interests
  | "Publications" => Publications
  | "Projects" => Projects
  | "Education" => Education
  | "Work_Experience" => WorkExperience
  | "Currently_Reading" => Reading
  | _ => Invalid
  }

let toString = (route: route): string =>
  switch route {
  | Interests => "Interests"
  | Publications => "Publications"
  | Projects => "Projects"
  | Education => "Education"
  | WorkExperience => "Work_Experience"
  | Reading => "Currently_Reading"
  | Invalid => "Invalid"
  }
