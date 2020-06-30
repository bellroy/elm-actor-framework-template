module Model exposing (Model(..))

import Actors exposing (Actors)
import Components.Counter as Counter
import Components.Layout as Layout


type Model
    = CounterModel Counter.Model
    | LayoutModel (Layout.Model Actors)
