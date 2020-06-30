module Framework.Template.Internal.Component exposing
    ( Component
    , make
    , setDefaultAttributes
    , toActor
    , toDefaultAttributes
    , toNodeName
    )


type Component appActors
    = Component
        { nodeName : String
        , actor : appActors
        , defaultAttributes : List ( String, String )
        }


make :
    { nodeName : String
    , actor : appActors
    }
    -> Component appActors
make { nodeName, actor } =
    Component
        { nodeName = nodeName
        , actor = actor
        , defaultAttributes = []
        }


setDefaultAttributes :
    List ( String, String )
    -> Component appActors
    -> Component appActors
setDefaultAttributes defaultAttributes (Component r) =
    Component { r | defaultAttributes = defaultAttributes }


toActor : Component appActors -> appActors
toActor (Component { actor }) =
    actor


toNodeName : Component appActors -> String
toNodeName (Component { nodeName }) =
    nodeName


toDefaultAttributes : Component appActors -> List ( String, String )
toDefaultAttributes (Component { defaultAttributes }) =
    defaultAttributes
