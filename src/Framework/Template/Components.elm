module Framework.Template.Components exposing (Components, empty, fromList, insert, remove, getByNodeName, union)

{-|

@docs Components, empty, fromList, insert, remove, getByNodeName, union

-}

import Framework.Template.Component exposing (Component)
import Framework.Template.Internal.Components as Internal


{-| Represents a collection of Template.Component's
-}
type alias Components appActors =
    Internal.Components appActors


{-| Returns an empty Components collection
-}
empty : Components appActors
empty =
    Internal.empty


{-| Create a Components collection from a list of Component's
-}
fromList : List (Component appActors) -> Components appActors
fromList =
    Internal.fromList


{-| Add a Component to your Components collection
-}
insert :
    Component appActors
    -> Components appActors
    -> Components appActors
insert =
    Internal.insert


{-| Remove a Component from your Components collection
-}
remove :
    Component appActors
    -> Components appActors
    -> Components appActors
remove =
    Internal.remove


{-| Get a Component based on its configured nodeName
-}
getByNodeName : String -> Components appActors -> Maybe (Component appActors)
getByNodeName =
    Internal.get


{-| Combine two Components collections
-}
union :
    Components appActors
    -> Components appActors
    -> Components appActors
union =
    Internal.union
