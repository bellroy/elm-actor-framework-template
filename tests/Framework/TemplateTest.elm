module Framework.TemplateTest exposing (suite)

import Expect
import Framework.Template as Template exposing (ActorElement(..), Node(..))
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Template"
        [ test_getActorElementDescendants
        , test_toString
        ]


test_toString : Test
test_toString =
    describe "toString"
        [ test "flat template" <|
            \_ ->
                [ Text "some"
                , Element "div" [] []
                , Actor <| ActorElement "someActor" "some-actor" "A" [] []
                , Text "test"
                ]
                    |> Template.toString
                    |> Expect.equal "some test"
        , test "Nested structure template" <|
            \_ ->
                [ Element "div" [] [ Text "a" ]
                , Element "div" [] [ Text "b", Element "div" [] [ Text "c", Text "d", Element "div" [] [ Text "e" ] ] ]
                ]
                    |> Template.toString
                    |> Expect.equal "a b c d e"
        ]


test_getActorElementDescendants : Test
test_getActorElementDescendants =
    describe "getActorElementDescendants"
        [ test "Single actor, flat template" <|
            \_ ->
                [ Text "some test"
                , Element "div" [] []
                , Actor <| ActorElement "someActor" "some-actor" "A" [] []
                ]
                    |> Template.getActorElementDescendants
                    |> Expect.equal
                        [ ActorElement "someActor" "some-actor" "A" [] []
                        ]
        , test "Multiple actors, flat template" <|
            \_ ->
                [ Element "div"
                    []
                    [ Actor <| ActorElement "someActor" "some-actor" "A" [] []
                    , Actor <| ActorElement "someActor" "some-actor" "B" [] []
                    ]
                ]
                    |> Template.getActorElementDescendants
                    |> Expect.equal
                        [ ActorElement "someActor" "some-actor" "A" [] []
                        , ActorElement "someActor" "some-actor" "B" [] []
                        ]
        , test "Nested structure template" <|
            \_ ->
                [ Actor <|
                    ActorElement
                        "someActor"
                        "some-actor"
                        "A"
                        []
                        [ Actor <| ActorElement "ignoreMe" "ignore-me" "B" [] []
                        ]
                , Element "div"
                    []
                    [ Element "div"
                        []
                        [ Actor <| ActorElement "someActor" "some-actor" "C" [] []
                        ]
                    , Element "div"
                        []
                        [ Actor <| ActorElement "someOtherActor" "some-actor" "D" [] []
                        ]
                    ]
                ]
                    |> Template.getActorElementDescendants
                    |> Expect.equal
                        [ ActorElement "someActor" "some-actor" "A" [] [ Actor <| ActorElement "ignoreMe" "ignore-me" "B" [] [] ]
                        , ActorElement "someActor" "some-actor" "C" [] []
                        , ActorElement "someOtherActor" "some-actor" "D" [] []
                        ]
        ]
