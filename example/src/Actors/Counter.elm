module Actors.Counter exposing (actor)

import AppFlags exposing (AppFlags(..))
import Components.Counter as Counter
import Framework.Actor as Actor exposing (Actor)
import Framework.Message as Message
import Html exposing (Html)
import Model exposing (Model(..))
import Msg exposing (AppMsg(..), Msg)


actor : Actor AppFlags Counter.Model Model (Html Msg) Msg
actor =
    Counter.component
        |> Actor.altInit
            (\init ( pid, appFlags ) ->
                case appFlags of
                    CounterFlags int ->
                        init ( pid, int )

                    _ ->
                        init ( pid, 0 )
            )
        |> Actor.fromComponent
            { toAppModel = CounterModel
            , toAppMsg = CounterMsg
            , fromAppMsg =
                \msg ->
                    case msg of
                        CounterMsg msgIn ->
                            Just msgIn

                        _ ->
                            Nothing
            , onMsgOut = \_ -> Message.noOperation
            }
