module WebApi where

import String
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Effects exposing (Effects)

import ActionTypes exposing (Action(..))

token : String
token =
  "3b080a643fbe01608d05a365e2b49996"

requestForecast : String -> Effects Action
requestForecast query =
  Http.get ("cod" := Json.string) (String.concat ["http://api.openweathermap.org/data/2.5/forecast?q=", query, "&appid=", token])
    |> Task.toMaybe
    |> Task.map UpdateForecast
    |> Effects.task
