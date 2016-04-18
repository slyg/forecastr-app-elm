module WebApi where

import String
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Effects exposing (Effects)

import ActionTypes exposing (Action(..))

forecastUrl : String -> String
forecastUrl query =
  String.concat
    [ "http://api.openweathermap.org/data/2.5/forecast"
    , "?q="
    , query
    , "&appid="
    , "3b080a643fbe01608d05a365e2b49996"
    ]

forecast : Json.Decoder (String)
forecast =
  ("cod" := Json.string)

requestForecast : String -> Effects Action
requestForecast query =
  Http.get forecast (forecastUrl query)
    |> Task.toMaybe
    |> Task.map UpdateForecast
    |> Effects.task
