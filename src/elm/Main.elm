module Main where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (..)
import Time exposing(every, millisecond)

import Store exposing (init, update)
import View exposing (view)
import ActionTypes exposing (Action(..))

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs =
      [
        Signal.map UpdateTime <| every millisecond
      ]
    }

main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
