module WebApi where

import String
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Effects exposing (Effects)

import Types exposing (Action(..))

coordDecoder : Json.Decoder (Types.Coord)
coordDecoder =
  Json.object2
    Types.Coord
    ("lon" := Json.float)
    ("lat" := Json.float)

cityDecoder : Json.Decoder (Types.City)
cityDecoder =
  Json.object4
    Types.City
    ("coord" := coordDecoder)
    ("country" := Json.string)
    ("id" := Json.int)
    ("name" := Json.string)

forecastDecoder : Json.Decoder (Types.City)
forecastDecoder =
  ("city" := cityDecoder)

forecastUrl : String -> String
forecastUrl query =
  String.concat
    [ "http://api.openweathermap.org/data/2.5/forecast"
    , "?q="
    , query
    , "&appid="
    , "3b080a643fbe01608d05a365e2b49996"
    ]

handleResult : Result a Types.City -> Action
handleResult result =
  case result of
    Ok data ->
      UpdateForecast data
    Err error ->
      FetchError (toString error)

requestForecast : String -> Effects Action
requestForecast query =
  Http.get forecastDecoder (forecastUrl query)
    |> Task.toResult
    |> Task.map handleResult
    |> Effects.task
