module State where

import Effects exposing (Effects)
import WebApi exposing (requestForecast)
import Types exposing (Action(..))
import Selectors exposing (selectFromRawForecastItem, groupByDay)

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
    , timeTable = []
    , groupedByDay = []
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
      let
        timeTable = List.map selectFromRawForecastItem data.list
      in
        ( { model |
              city = data.city,
              timeTable = timeTable,
              groupedByDay = List.foldr groupByDay [] timeTable
          }
          , Effects.none
        )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
