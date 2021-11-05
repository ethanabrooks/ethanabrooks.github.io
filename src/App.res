open Belt

@scope("document") @val
external addEventListener: (string, ReactEvent.Mouse.t => unit) => unit = "addEventListener"
@val
external removeEventListener: (string, ReactEvent.Mouse.t => unit) => unit = "removeEventListener"
@send external contains: (Dom.element, Dom.element) => bool = "contains"
@get external target: ReactEvent.Mouse.t => Dom.element = "target"

@react.component
let make = (): React.element => {
  let url = RescriptReactRouter.useUrl()
  let route = url.hash->Js.Global.decodeURI->Route.fromString
  let bodyRef = React.useRef(Js.Nullable.null)
  let headerRef = React.useRef(Js.Nullable.null)

  React.useEffect(() => {
    let clickHandler = event => {
      switch (headerRef.current->Js.Nullable.toOption, bodyRef.current->Js.Nullable.toOption) {
      | (Some(header), Some(body)) =>
        let mouseTarget = event->target
        if !(header->contains(mouseTarget) || body->contains(mouseTarget)) {
          `#${Home->Route.toString}`->RescriptReactRouter.push
        }
      | _ => ()
      }
    }
    let evt = "mousedown"
    evt->addEventListener(clickHandler)
    Some(_ => evt->removeEventListener(clickHandler))
  })->ignore
  <div
    className="w-screen h-screen bg-center bg-cover"
    id="background"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div id="background2" className="flex flex-col p-10 sm:w-3/5 xl:w-1/2 3xl:w-2/5 h-screen">
      <nav id="nav" className="flex flex-col sm:flex-row flex-wrap justify-between sm:space-x-4">
        {Route.array
        ->Array.keep(r => r != Home)
        ->Array.mapWithIndex((i, r) => {
          <a
            key={i->Int.toString}
            href={`#${r->Route.toString->Js.Global.encodeURI}`}
            className={r == route ? Tailwind.activeClassName : Tailwind.inactiveClassName}>
            {r->Route.toString->React.string}
          </a>
        })
        ->React.array}
      </nav>
      <div className={route == Home ? "" : "flex flex-row justify-between flex-grow  items-center"}>
        <div>
          {
            let inputRef = headerRef->ReactDOM.Ref.domRef
            switch route {
            | Home =>
              <h1
                className="text-xl sm:text-3xl tracking-tight sm:py-10 2xl:py-8 3xl:text-4xl 3xl:flex 3xl:flex-row 3xl:flex-1 3xl:justify-between">
                <p className="block"> {"Ethan A. Brooks"->React.string} </p>
                <p className="block text-gray-700"> {"Researcher"->React.string} </p>
                <p className="block text-gray-700"> {"Reinforcement Learning"->React.string} </p>
                <p className="block text-gray-700"> {"Natural Language"->React.string} </p>
              </h1>
            | Invalid => <Header inputRef> {"Page not found."->React.string} </Header>
            | About => <Header inputRef> {`${route->Route.toString} Ethan`->React.string} </Header>
            | _ => <Header inputRef> {route->Route.toString->React.string} </Header>
            }
          }
          <div className="rounded-b-md ring-black ring-opacity-5 bg-white  border-gray-200">
            {
              let inputRef = ReactDOM.Ref.domRef(bodyRef)
              switch route {
              | Home => <> </>
              | About => <About inputRef />
              | Publications => <Publications inputRef />
              | Projects => <Projects inputRef />
              | WorkExperience => <Work inputRef />
              | Education => <Education inputRef />
              | Reading => <Reading inputRef />
              | _ => <> </>
              }
            }
          </div>
        </div>
      </div>
    </div>
  </div>
}
