module Components.Layout exposing (Model, MsgIn(..), MsgOut(..), component)

import Dict exposing (Dict)
import Framework.Actor exposing (Component, Pid)
import Framework.Template as Template exposing (ActorElement(..), Node(..))
import Html exposing (Html)


type alias Model appActors =
    { instances : Dict String Pid
    , template : List (Node appActors)
    }


type MsgIn
    = OnSpawnedActor String Pid


type MsgOut appActors
    = SpawnNodeActors (List (ActorElement appActors))


component : Component (List (Node appActors)) (Model appActors) MsgIn (MsgOut appActors) (Html msg) msg
component =
    { init = init
    , update = update
    , subscriptions = always Sub.none
    , view = view
    }


init : ( a, List (Node appActors) ) -> ( Model appActors, List (MsgOut appActors), Cmd MsgIn )
init ( _, template ) =
    ( { instances = Dict.empty
      , template = template
      }
    , [ Template.getActorElementDescendants template
            |> SpawnNodeActors
      ]
    , Cmd.none
    )


update : MsgIn -> Model appActors -> ( Model appActors, List (MsgOut appActors), Cmd MsgIn )
update msgIn model =
    case msgIn of
        OnSpawnedActor id pid ->
            ( { model
                | instances = Dict.insert id pid model.instances
              }
            , []
            , Cmd.none
            )


view : a -> Model appActors -> (Pid -> Maybe (Html msg)) -> Html msg
view _ model renderPid =
    model.template
        |> List.map (elementToHtml model.instances renderPid)
        |> Html.div []


elementToHtml :
    Dict String Pid
    -> (Pid -> Maybe (Html msg))
    -> Node appActors
    -> Html msg
elementToHtml instances renderPid node =
    case node of
        Text str ->
            Html.text str

        Element nodeName attributes children ->
            List.map (elementToHtml instances renderPid) children
                |> Html.node nodeName []

        Actor (ActorElement _ _ id _ _) ->
            Dict.get id instances
                |> Maybe.andThen renderPid
                |> Maybe.withDefault (Html.text "")
