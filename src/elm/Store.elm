module Store where

import Effects exposing (Effects)
import Time exposing (Time)
import WebApi exposing (requestForecast)
import Types exposing (Action(..))

initCoord : Types.Coord
initCoord =
  { lat = 0.0
  , lon = 0.0
  }

initCity : Types.City
initCity =
  { country = "UKN"
  , id = 0
  , name = "Unknown"
  , coord = initCoord
  }

init : (Types.Model, Effects Action)
init =
  ( { city = initCity
    }
  , Effects.none
  )

update : Action -> Types.Model -> ( Types.Model, Effects Action )
update action model =
  case action of

    RequestForecast q ->
      if q == "" then
        (model, Effects.none)
      else
        (model, requestForecast q)

    UpdateForecast data ->
      ( { model | city = data.city }
        , Effects.none
      )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
