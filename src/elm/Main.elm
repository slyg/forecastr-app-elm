module Main where

import StartApp
import Effects exposing (Effects, Never)
import Task exposing (..)
import Time exposing(every, millisecond)
import Signal.Time exposing (settledAfter)

import Store exposing (init, update, debounceProxy)
import View exposing (view)

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs =
      [ settledAfter (500 * Time.millisecond) debounceProxy.signal
      ]
    }

main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
