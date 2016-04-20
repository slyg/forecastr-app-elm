module View where

import StartApp
import String
import Html exposing (Html, text, div, button, input)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, type', placeholder, autofocus)
import Html.Events exposing (on, targetValue)
import Signal exposing (Address)

import ActionTypes exposing (Action(..))
import Store exposing (Model)

lineStyle =
  style
    [ ("padding", "10px 10px 0")
    ]

view : Address Action -> Model -> Html
view address model =
  div []
    [ div [ lineStyle ]
      [ input
        [ type' "text"
        , autofocus True
        , placeholder "Enter city name"
        , on "input" targetValue (Signal.message address << TypingQuery)
        ]
        []
      , button [ onClick address RequestForecast ] [ text "Get city data" ]
      ]
    , div [ lineStyle ]
      [ text
        ( String.concat
          [ model.city.name
            , " ("
            , model.city.country, ")"
          ]
        )
      ]
  ]
