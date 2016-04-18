module Main where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (..)

import App exposing (init, view, update)

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs = []
    }

main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
