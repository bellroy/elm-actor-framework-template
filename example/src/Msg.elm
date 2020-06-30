module Msg exposing (AppMsg(..), Msg)

import Actors exposing (Actors)
import AppFlags exposing (AppFlags)
import Components.Counter as Counter
import Components.Layout as Layout
import Framework.Message exposing (FrameworkMessage)
import Model exposing (Model)


type AppMsg
    = CounterMsg Counter.MsgIn
    | LayoutMsg Layout.MsgIn


type alias Msg =
    FrameworkMessage AppFlags () Actors Model AppMsg
