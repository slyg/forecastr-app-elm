module Main exposing (..)

import Html.App as Html
import State exposing (init, update, subscriptions)
import View exposing (view)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
