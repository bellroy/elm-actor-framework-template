module Main exposing (factory, main)

import Actors exposing (Actors(..))
import Actors.Counter as Counter
import Actors.Layout as Layout
import AppFlags exposing (AppFlags(..))
import Framework.Actor exposing (Pid, Process)
import Framework.Browser as Browser exposing (Program)
import Framework.Message as Message exposing (FrameworkMessage)
import Framework.Template exposing (ActorElement(..), Node(..))
import Html exposing (Html)
import Model exposing (Model(..))
import Msg exposing (AppMsg(..), Msg)


main : Program () AppFlags () Actors Model AppMsg
main =
    Browser.element
        { init = init
        , factory = factory
        , apply = apply
        , view = view
        }


template : List (Node Actors)
template =
    [ Element "div"
        []
        [ Element "h1" [] [ Text "Layout" ]
        , Element "div"
            []
            [ Actor <| ActorElement Counter "actor-counter" "a" [] [ Text "0" ]
            , Actor <| ActorElement Counter "actor-counter" "b" [] [ Text "10" ]
            , Actor <|
                ActorElement Layout
                    "actor-layout"
                    "c"
                    []
                    [ Element "h2" [] [ Text "Layout 2" ]
                    , Actor <| ActorElement Counter "actor-counter" "d" [] [ Text "100" ]
                    ]
            ]
        ]
    ]


init : flags -> FrameworkMessage AppFlags () Actors Model AppMsg
init _ =
    Message.spawn (LayoutFlags template) Layout Message.addToView


factory : Actors -> ( Pid, AppFlags ) -> ( Model, Msg )
factory actorName =
    case actorName of
        Counter ->
            Counter.actor.init

        Layout ->
            Layout.actor.init


apply : Model -> Process Model (Html Msg) Msg
apply appModel =
    case appModel of
        CounterModel counterModel ->
            Counter.actor.apply counterModel

        LayoutModel layoutModel ->
            Layout.actor.apply layoutModel


view : List (Html Msg) -> Html Msg
view =
    Html.div []
