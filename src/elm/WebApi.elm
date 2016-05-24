module WebApi exposing (..)

import String
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)
import Platform.Cmd as Cmd exposing (Cmd)
import Types exposing (Msg(..))


cityDecoder : Json.Decoder (Types.City)
cityDecoder =
    Json.object3 Types.City
        ("country" := Json.string)
        ("id" := Json.int)
        ("name" := Json.string)


weatherDecoder : Json.Decoder (Types.WeatherItemRawData)
weatherDecoder =
    Json.object4 Types.WeatherItemRawData
        ("description" := Json.string)
        ("icon" := Json.string)
        ("id" := Json.int)
        ("main" := Json.string)


forecastDecoder : Json.Decoder (Types.ForecastItemRawData)
forecastDecoder =
    Json.object3 Types.ForecastItemRawData
        ("dt" := Json.int)
        ("dt_txt" := Json.string)
        ("weather" := Json.list weatherDecoder)


responseDecoder : Json.Decoder (Types.ForecastRawData)
responseDecoder =
    Json.object2 Types.ForecastRawData
        ("city" := cityDecoder)
        ("list" := Json.list forecastDecoder)


forecastUrl : String -> String
forecastUrl query =
    String.concat
        [ "http://api.openweathermap.org/data/2.5/forecast"
        , "?q="
        , query
        , "&appid="
        , "3b080a643fbe01608d05a365e2b49996"
        ]


requestForecast : String -> Cmd Msg
requestForecast query =
    let
        url =
            forecastUrl query
    in
        Http.get responseDecoder url
            |> Task.perform FetchError UpdateForecast
