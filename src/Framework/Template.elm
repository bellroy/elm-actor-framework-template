module Framework.Template exposing
    ( Node(..), ActorElement(..)
    , ElementNodeName, ActorElementId, Attributes, Attribute, Children
    , getActorElementDescendants
    , toString
    )

{-| A Template is a list of `Node`s

You can directly use this module to create a Template or you can use one of the
packages that build on top of this package to parse a template based on another,
friendlier, format.

@docs Node, ActorElement

@docs ElementNodeName, ActorElementId, Attributes, Attribute, Children

@docs getActorElementDescendants

@docs toString

-}


{-| A Node represents Text, any Element or an Actor.

    Text "some test"

    Element "strong" [] [ Text "Hello World" ]

    Actor <| ActorElement Counter "comp-counter" "counter-1" [] []

-}
type Node appActors
    = Text String
    | Element ElementNodeName Attributes (Children appActors)
    | Actor (ActorElement appActors)


{-| An ActorElement
-}
type ActorElement appActors
    = ActorElement appActors ElementNodeName ActorElementId Attributes (Children appActors)


{-| The NodeName of an Element or ActorElement
-}
type alias ElementNodeName =
    String


{-| The Actor Element Id, this should be unique on your template.
-}
type alias ActorElementId =
    String


{-| A List of Attribute
-}
type alias Attributes =
    List Attribute


{-| A (key, value) representation of a Node attribute

    ( "class", "Foo" )

    ( "href", "https://www.example.com" )

-}
type alias Attribute =
    ( String, String )


{-| A List of Nodes
-}
type alias Children appActors =
    List (Node appActors)


{-| Turn a Template into a single String

This can be handy for search results or meta descriptions

    [ Element "strong" [] [ Text "a" ]
    , Text "b"]
    --> "a b"

-}
toString : List (Node appActors) -> String
toString =
    List.foldl
        (\node result ->
            case node of
                Text str ->
                    [ result, str ]
                        |> List.map String.trim
                        |> String.join " "

                Element _ _ children ->
                    [ result, toString children ]
                        |> String.join " "

                Actor (ActorElement _ _ _ _ children) ->
                    [ result, toString children ]
                        |> String.join " "
        )
        ""
        >> String.trim


{-| Returns the descending ActorElement for a given List of Nodes
-}
getActorElementDescendants :
    List (Node appActors)
    -> List (ActorElement appActors)
getActorElementDescendants =
    List.foldl
        (\node list ->
            case node of
                Text _ ->
                    []

                Element _ _ children ->
                    getActorElementDescendants children
                        |> List.append list

                Actor actorElement ->
                    List.append list [ actorElement ]
        )
        []
