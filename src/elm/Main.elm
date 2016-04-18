module Main where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (..)

import Store exposing (init, update)
import View exposing (view)

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
