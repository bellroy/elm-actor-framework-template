module Components.Counter exposing (Model, MsgIn, component)

import Framework.Actor exposing (Component)
import Html exposing (Html)
import Html.Events as HtmlE


type alias Model =
    Int


type MsgIn
    = Increment
    | Decrement


component : Component Int Model MsgIn () (Html msg) msg
component =
    { init = init
    , update = update
    , subscriptions = always Sub.none
    , view = view
    }


init : ( a, Int ) -> ( Model, List (), Cmd MsgIn )
init ( _, count ) =
    ( count, [], Cmd.none )


update : MsgIn -> Model -> ( Model, List (), Cmd MsgIn )
update msgIn model =
    case msgIn of
        Increment ->
            ( model + 1, [], Cmd.none )

        Decrement ->
            ( model - 1, [], Cmd.none )


view : (MsgIn -> msg) -> Model -> a -> Html msg
view toSelf model _ =
    Html.div []
        [ Html.button
            [ HtmlE.onClick Decrement ]
            [ Html.text "-" ]
        , Html.span
            []
            [ String.fromInt model |> Html.text ]
        , Html.button
            [ HtmlE.onClick Increment ]
            [ Html.text "+" ]
        ]
        |> Html.map toSelf
