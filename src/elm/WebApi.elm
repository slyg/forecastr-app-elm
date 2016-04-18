module WebApi where

import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Effects exposing (Effects)

import ActionTypes exposing (Action(..))

requestIP : String -> Effects Action
requestIP url =
  Http.get ("ip" := Json.string) url
    |> Task.toMaybe
    |> Task.map UpdateIP
    |> Effects.task
