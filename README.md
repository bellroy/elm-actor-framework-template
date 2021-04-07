# Elm Actor Framework - Template

![Build Status](https://github.com/bellroy/elm-actor-framework-template/workflows/Continuous%20Integration/badge.svg) [![Elm package](https://img.shields.io/elm-package/v/bellroy/elm-actor-framework-template.svg)](https://package.elm-lang.org/packages/bellroy/elm-actor-framework-template/latest/)

This package is as an extension of the [Elm Actor Framework](https://github.com/bellroy/elm-actor-framework) [Package](https://package.elm-lang.org/packages/bellroy/elm-actor-framework/latest).

It supplies an uniform method of creating Templates for the Actor Model
environment supplied by the Elm Actor Framework

```elm

    Text "some text"

    Element "strong" [] [ Text "Hello World" ]

    Actor <| ActorElement Counter "comp-counter" "counter-1" [] []

```

## Templates

Actors make up ideal components that can be used on a template.

This module provides a shared type system for different template inputs and
outputs. Currently this package is used by;

- [Elm Actor Framework - Templates](https://github.com/bellroy/elm-actor-framework-template)
  - [Demo](https://bellroy.github.io/elm-actor-framework)
- [Elm Actor Framework - Templates - Html](https://github.com/bellroy/elm-actor-framework-template-html)
  - [Demo](https://bellroy.github.io/elm-actor-framework-template-html)
  - **Parse** Html Template (Using [`hecrj/html-parser`](https://github.com/hecrj/html-parser))
  - **Render** Html (Using [`elm/html`](https://github.com/elm/html))
- [Elm Actor Framework - Templates - Markdown](https://github.com/bellroy/elm-actor-framework-template-markdown)
  - [Demo](https://bellroy.github.io/elm-actor-framework-template-markdown)
  - **Parse** Markdown (Using [dillonkearns/elm-markdown](https://github.com/dillonkearns/elm-markdown))

Without the listed additional template packages this module can still be used to
supply a (custom) template foundation.

## Demo

The Demo/Example uses the following template to render Html and the listed Actors.

```elm
template : List (Node Actors)
template =
    [ Element "div"
        []
        [ Element "h1" [] [ Text "Layout" ]
        , Element "div"
            []
            [ Actor <| ActorElement Counter "actor-counter" "a" [] [ Text "0" ]
            , Actor <| ActorElement Counter "actor-counter" "b" [] [ Text "10" ]
            , Actor <|
                ActorElement Layout
                    "actor-layout"
                    "c"
                    []
                    [ Element "h2" [] [ Text "Layout 2" ]
                    , Actor <| ActorElement Counter "actor-counter" "d" [] [ Text "100" ]
                    ]
            ]
        ]
    ]
```

The included `example` can be previewed online [here](https://bellroy.github.io/elm-actor-framework-template)
