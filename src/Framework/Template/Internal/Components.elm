module Framework.Template.Internal.Components exposing
    ( Components
    , empty
    , fromList
    , get
    , insert
    , remove
    , union
    )

import Dict exposing (Dict)
import Framework.Template.Internal.Component as Component exposing (Component)


type Components appActors
    = Components (Dict String (Component appActors))


empty : Components appActors
empty =
    fromDict Dict.empty


fromList : List (Component appActors) -> Components appActors
fromList =
    List.map
        (\component ->
            ( Component.toNodeName component
            , component
            )
        )
        >> Dict.fromList
        >> fromDict


toDict :
    Components appActors
    -> Dict String (Component appActors)
toDict (Components dict) =
    dict


fromDict :
    Dict String (Component appActors)
    -> Components appActors
fromDict =
    Components


mapDict :
    (Dict String (Component appActors)
     -> Dict String (Component appActors)
    )
    -> Components appActors
    -> Components appActors
mapDict f =
    toDict
        >> f
        >> fromDict


insert :
    Component appActors
    -> Components appActors
    -> Components appActors
insert component =
    mapDict (Dict.insert (Component.toNodeName component) component)


remove :
    Component appActors
    -> Components appActors
    -> Components appActors
remove =
    Component.toNodeName
        >> Dict.remove
        >> mapDict


get : String -> Components appActors -> Maybe (Component appActors)
get query =
    toDict
        >> Dict.get query


union :
    Components appActors
    -> Components appActors
    -> Components appActors
union a b =
    Dict.union (toDict a) (toDict b)
        |> fromDict
