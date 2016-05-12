module State exposing (..)

import Platform.Cmd as Cmd exposing (Cmd)
import WebApi exposing (requestForecast)
import Types exposing (Msg(..))
import Selectors exposing (selectFromRawForecastItem, groupByDay)


initCity : Types.City
initCity =
  { country = "UKN"
  , id = 0
  , name = "Unknown"
  }

init : (Types.Model, Cmd Msg)
init =
  ( { city = initCity
    , timeTable = []
    , groupedByDay = []
    }
  , Cmd.none
  )

update : Msg -> Types.Model -> ( Types.Model, Cmd Msg )
update action model =
  case action of

    RequestForecast q ->
      if q == "" then
        (model, Cmd.none)
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
          , Cmd.none
        )

    FetchError error ->
      Debug.log (toString error)
      (model, Cmd.none)

    NoOp ->
      (model, Cmd.none)
