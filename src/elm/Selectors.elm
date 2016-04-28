module Selectors where

import Date exposing (Date, dayOfWeek)
import Result exposing (Result)

import Types exposing (Action(..))

selectFromRawForecastItem : Types.ForecastItemRawData -> Maybe Types.ForecastItem
selectFromRawForecastItem d =
  let
    date =
      .dt_txt d
        |> Date.fromString
        |> Result.toMaybe
    maybeWeather =
      .weather d
        |> List.head
    description =
      case maybeWeather of
        Just weather ->
          weather.description
        Nothing ->
          "N/A"

  in
    case date of
      Just date ->
        Just (
          { day = dayOfWeek date
          , hour = Date.hour date
          , description = description
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
