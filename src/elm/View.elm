module View where

import String
import Html exposing (Html, text, div, input, ul, li)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, type', placeholder, autofocus)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)

import Types exposing (Action(..))
import Util exposing (debounceProxy, findWeekDay)

onTextChange : (String -> Action) -> Html.Attribute
onTextChange contentToValue =
    on "input" targetValue (\str -> Signal.message debounceProxy.address (contentToValue str))

lineStyle : Html.Attribute
lineStyle =
  style
    [ ("padding", "10px 10px 0")
    ]

forecastItemView : Types.ForecastItem -> Html
forecastItemView d =
  let
    { hour, description } = d
  in
    li []
      [ text
        (
          String.concat
          [ (toString hour ++ ":00")
          , " - "
          , description
          ]
        )
      ]

forecastPerDayView : Types.ForecastsPerDay -> Html
forecastPerDayView groupItem =
  let
    (day, forecasts) = groupItem
  in
    li []
      [ text (findWeekDay day)
      , ul [] (List.map forecastItemView forecasts)
      ]

view : Address Action -> Types.Model -> Html
view address model =
  div []
    [ div
        [ lineStyle ]
        [ input
          [ type' "text"
          , autofocus True
          , placeholder "Enter city name"
          , onTextChange RequestForecast
          ]
          []
        ]
    , div
        [ lineStyle ]
        [ text
          ( String.concat
            [ model.city.name
            , " ("
            , model.city.country
            , ")"
            ]
          )
        ]
    , ul
        [ lineStyle ]
        (List.map forecastPerDayView model.groupedByDay)
    ]
