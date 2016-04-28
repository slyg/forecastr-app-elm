module State where

import Effects exposing (Effects)
import Date exposing (Date, dayOfWeek)
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
    , groupedByDay = []
    }
  , Effects.none
  )

parseRawForecastItem : Types.ForecastItemRawData -> Maybe Types.ForecastItem
parseRawForecastItem d =
  let
    date =
      .dt_txt d
        |> Date.fromString
        |> Result.toMaybe
  in
    case date of
      Just date ->
        Just (
          { day = dayOfWeek date
          , hour = Date.hour date
          }
        )
      Nothing ->
        Nothing

groupByDay : Maybe Types.ForecastItem -> List Types.ForecastsPerDay -> List Types.ForecastsPerDay
groupByDay x acc =
  case x of
    Nothing ->
      acc
    Just x ->
      let
        { day } = x
        default = (day, [x]) :: acc
      in
        case acc of
          [] ->
            default
          h::_ ->
            let
              (hDay, hRef) = h
              accTail = List.drop 1 acc
            in
              if hDay == day then
                  (day, x :: hRef) :: accTail
              else
                default

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
        timeTable = List.map parseRawForecastItem data.list
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
