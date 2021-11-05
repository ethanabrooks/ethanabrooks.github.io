open Belt

@module external rawReading: Js.Json.t = "./Reading.json"

@decco
type book = {
  title: string,
  author: string,
  link: string,
  translator: option<string>,
}

@decco
type reading = array<book>

@react.component
let make = (~inputRef) =>
  rawReading
  ->reading_decode
  ->Result.map(books =>
    <ul ref=inputRef className=Tailwind.divideClassName>
      {books
      ->Array.mapWithIndex((i, {title, author, translator, link}) =>
        <li key={i->Int.toString}>
          <a href=link target="_blank" className=Tailwind.clickableClassName>
            <div className={`flex flex-col  ${Tailwind.padding}`}>
              <div className="flex flex-row space-x-4">
                <h2 className=Tailwind.h2ClassName> {title->React.string} </h2>
                <p> {author->React.string} </p>
              </div>
              {translator->Option.mapWithDefault(<> </>, translator =>
                <p className=Tailwind.liPrimaryClassName>
                  {`Translated by ${translator}`->React.string}
                </p>
              )}
            </div>
          </a>
        </li>
      )
      ->React.array}
    </ul>
  )
  ->Util.getOrErrorPage
