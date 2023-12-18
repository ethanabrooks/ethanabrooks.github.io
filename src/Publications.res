module Array = Belt.Array

type config = {template: string, lang: string}

type entry
type entries = Js.Array.array_like<entry>

type citation
@new @module external citeBib: string => entries = "citation-js"
@new @module external cite: entry => citation = "citation-js"
@send external format: (citation, string, config) => string = "format"
@module external papers: string = "bundle-text:/static/papers.bib"

@react.component
let make = (~inputRef) => {
  let config: config = {template: "citation-mla", lang: "en-us"}
  <ul ref=inputRef className=Tailwind.divideClassName>
    {papers
    ->citeBib
    ->Js.Array.from
    ->Array.map(cite)
    ->Array.map(citation => citation->format("bibliography", config))
    ->Array.mapWithIndex((i, citation) => {
      <li key={i->Int.toString}>
        <p className=Tailwind.padding> {citation->React.string} </p>
      </li>
    })
    ->React.array}
  </ul>
}
