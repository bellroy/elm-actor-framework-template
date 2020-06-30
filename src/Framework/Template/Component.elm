module Framework.Template.Component exposing (Component, make, setDefaultAttributes, toActor, toDefaultAttributes, toNodeName)

{-|

@docs Component, make, setDefaultAttributes, toActor, toDefaultAttributes, toNodeName

-}

import Framework.Template.Internal.Component as Internal


{-| A TemplateComponent describes the link between your Actors and Template Elements.
-}
type alias Component appActors =
    Internal.Component appActors


{-| Create a new Template Component configuration
-}
make :
    { nodeName : String
    , actor : appActors
    }
    -> Component appActors
make =
    Internal.make


{-| Set the default attributes on your Template Component
-}
setDefaultAttributes :
    List ( String, String )
    -> Component appActors
    -> Component appActors
setDefaultAttributes =
    Internal.setDefaultAttributes


{-| Get the Actor defined on a given Component
-}
toActor : Component appActors -> appActors
toActor =
    Internal.toActor


{-| Get the nodeName defined on a given Component
-}
toNodeName : Component appActors -> String
toNodeName =
    Internal.toNodeName


{-| Get the default attributes defined on a given Component
-}
toDefaultAttributes : Component appActors -> List ( String, String )
toDefaultAttributes =
    Internal.toDefaultAttributes
