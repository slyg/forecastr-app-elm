module View where

import StartApp
import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)
import Signal exposing (Address)

import ActionTypes exposing (Action(..))
import Store exposing (Model)

view : Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address RequestForecast ] [ text "Get code" ]
    , div [] [ text model.cod ]
  ]
