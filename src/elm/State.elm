module State where

import Effects exposing (Effects)
import Date exposing (Date)
import Result exposing (Result)
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
    , timeTable = []
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
        dateParser d =
          .dt_txt d
            |> Date.fromString
            |> Result.toMaybe
      in
        ( { model |
              city = data.city,
              timeTable = List.map dateParser data.list
          }
          , Effects.none
        )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
