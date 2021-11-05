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
  let navRef = React.useRef(Js.Nullable.null)
  let bodyRef = React.useRef(Js.Nullable.null)
  let headerRef = React.useRef(Js.Nullable.null)

  React.useEffect(() => {
    let clickHandler = event => {
      [navRef.current, headerRef.current, bodyRef.current]
      ->Array.map(Js.Nullable.toOption)
      ->Array.reduce(None, (soFar, new) =>
        switch (soFar, new) {
        | (_, None) => None
        | (None, Some(x)) => [x]->Some
        | (Some(x), Some(y)) => x->Array.concat([y])->Some
        }
      )
      ->Option.map(refs =>
        if !(refs->Array.map(ref => ref->contains(event->target))->Array.some(b => b)) {
          `#${Home->Route.toString}`->RescriptReactRouter.push
        }
      )
      ->ignore
    }
    let evt = "mousedown"
    evt->addEventListener(clickHandler)
    Some(_ => evt->removeEventListener(clickHandler))
  })->ignore
  <div
    className="w-screen h-screen bg-center bg-cover"
    style={ReactDOM.Style.make(
      ~backgroundImage=`url('https://github.com/ethanabrooks/ethanabrooks.github.io/blob/master/static/portrait.png?raw=true')`,
      (),
    )}>
    <div className="flex flex-col p-10 sm:w-3/5 xl:w-1/2 3xl:w-1/3 h-screen">
      <nav
        ref={navRef->ReactDOM.Ref.domRef}
        className="
        flex flex-col 
        sm:grid sm:grid-rows-2 sm:grid-flow-col 
        lg:flex lg:flex-row lg:flex-wrap lg:justify-between lg:space-x-4
        ">
        {Route.array
        ->Array.keep(r => r != Home)
        ->Array.mapWithIndex((i, r) => {
          <a
            key={i->Int.toString}
            ref={navRef->ReactDOM.Ref.domRef}
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
                className="text-xl sm:text-2xl tracking-tight sm:py-10 2xl:py-8 3xl:flex 3xl:flex-row 3xl:flex-1 3xl:justify-between">
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
