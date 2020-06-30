module AppFlags exposing (AppFlags(..))

import Actors exposing (Actors)
import Framework.Template exposing (Node)


type AppFlags
    = CounterFlags Int
    | LayoutFlags (List (Node Actors))
    | Empty
