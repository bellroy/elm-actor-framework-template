module Actors.Layout exposing (actor)

import Actors exposing (Actors(..))
import AppFlags exposing (AppFlags(..))
import Components.Layout as Layout exposing (MsgIn(..), MsgOut(..))
import Framework.Actor as Actor exposing (Actor)
import Framework.Message as Message
import Framework.Template as Template
import Html exposing (Html)
import Model exposing (Model(..))
import Msg exposing (AppMsg(..), Msg)


actor : Actor AppFlags (Layout.Model Actors) Model (Html Msg) Msg
actor =
    Layout.component
        |> Actor.altInit
            (\init ( pid, appFlags ) ->
                case appFlags of
                    LayoutFlags template ->
                        init ( pid, template )

                    _ ->
                        init ( pid, [] )
            )
        |> Actor.fromComponent
            { toAppModel = LayoutModel
            , toAppMsg = LayoutMsg
            , fromAppMsg =
                \msg ->
                    case msg of
                        LayoutMsg msgIn ->
                            Just msgIn

                        _ ->
                            Nothing
            , onMsgOut =
                \{ self, msgOut } ->
                    case msgOut of
                        SpawnNodeActors nodeActors ->
                            nodeActors
                                |> List.map
                                    (\(Template.ActorElement a _ id _ children) ->
                                        let
                                            flags =
                                                case ( a, children ) of
                                                    ( Counter, [ Template.Text text ] ) ->
                                                        String.toInt text
                                                            |> Maybe.withDefault 0
                                                            |> CounterFlags

                                                    ( Layout, _ ) ->
                                                        LayoutFlags children

                                                    _ ->
                                                        Empty
                                        in
                                        Message.spawn flags
                                            a
                                            (OnSpawnedActor id
                                                >> LayoutMsg
                                                >> Message.sendToPid self
                                            )
                                    )
                                |> Message.batch
            }
