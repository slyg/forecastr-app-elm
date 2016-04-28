module State where

import Effects exposing (Effects)
import WebApi exposing (requestForecast)
import Types exposing (Action(..))
import Selectors exposing (selectFromRawForecastItem, groupByDay)


initCity : Types.City
initCity =
  { country = "UKN"
  , id = 0
  , name = "Unknown"
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
        safeGroupByDay = List.filterMap identity >> List.foldr groupByDay []
      in
        ( { model |
              city = data.city,
              timeTable = timeTable,
              groupedByDay = safeGroupByDay timeTable
          }
          , Effects.none
        )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
