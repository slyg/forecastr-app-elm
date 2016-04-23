module View where

import StartApp
import String
import Date exposing (Date)
import Html exposing (Html, text, div, input, ul, li)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, type', placeholder, autofocus)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)

import Types exposing (Action(..))
import Util exposing (debounceProxy)

onTextChange : (String -> Action) -> Html.Attribute
onTextChange contentToValue =
    on "input" targetValue (\str -> Signal.message debounceProxy.address (contentToValue str))

lineStyle =
  style
    [ ("padding", "10px 10px 0")
    ]

findWeekDay : Date -> String
findWeekDay date =
  let
    day = Date.dayOfWeek date
  in
    case day of
      Date.Mon -> "Monday"
      Date.Tue -> "Tuesday"
      Date.Wed -> "Wednesday"
      Date.Thu -> "Thursday"
      Date.Fri -> "Friday"
      Date.Sat -> "Saturday"
      Date.Sun -> "Sunday"

forecastItemView : Maybe Date -> Html
forecastItemView dt_txt =
  case dt_txt of
    Just dt_txt ->
      li [] [ text (findWeekDay dt_txt) ]
    Nothing ->
      li [] [ text "Oups" ]

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
        (List.map forecastItemView model.timeTable)
    ]
