module Store where

import Effects exposing (Effects)
import Time exposing (Time)
import WebApi exposing (requestForecast)
import ActionTypes exposing (Action(..))
import DataTypes

type alias Model =
  { city : DataTypes.City
  }

debounceProxy : Signal.Mailbox Action
debounceProxy =
  Signal.mailbox NoOp

initCoord : DataTypes.Coord
initCoord =
  { lat = 0.0
  , lon = 0.0
  }

initCity : DataTypes.City
initCity =
  { country = "UKN"
  , id = 0
  , name = "Unknown"
  , coord = initCoord
  }

init : (Model, Effects Action)
init =
  ( { city = initCity
    }
  , Effects.none
  )

update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of

    RequestForecast q ->
      if q == "" then
        (model, Effects.none)
      else
        (model, requestForecast q)

    UpdateForecast data ->
      ( { model | city = data }
        , Effects.none
      )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
