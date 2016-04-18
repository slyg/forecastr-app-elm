module WebApi where

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Effects exposing (Effects)

import ActionTypes exposing (Action(..))

requestIP : Effects Action
requestIP =
  Http.get ("ip" := Json.string) "http://jsonip.com"
    |> Task.toMaybe
    |> Task.map UpdateIP
    |> Effects.task
