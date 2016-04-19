module View where

import StartApp
import String
import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
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
      [ button [ onClick address RequestForecast ] [ text "Get city" ]
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
