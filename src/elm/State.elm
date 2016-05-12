port module State exposing (..)

import String

import Platform.Cmd as Cmd exposing (Cmd)
import WebApi exposing (requestForecast)
import Types exposing (Msg(..))
import Selectors exposing (selectFromRawForecastItem, groupByDay)

-- MODEL

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

-- UPDATE

port sendDebouncedMessage : String -> Cmd msg

update : Msg -> Types.Model -> ( Types.Model, Cmd Msg )
update action model =
  case action of

    DebouncedRequestForecast q ->
      if q == "" then
        (model, Cmd.none)
      else
        (model, sendDebouncedMessage q)

    RequestForecast q ->
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

-- SUBSCRIPTIONS

port receiveDebouncedMessage : (String -> msg) -> Sub msg

subscriptions : Types.Model -> Sub Msg
subscriptions model =
  receiveDebouncedMessage RequestForecast
