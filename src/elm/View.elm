module View exposing (..)

import String
import Html exposing (Html, text, div, input, ul, li)
import Html.Events exposing (onInput)
import Html.Attributes exposing (style, type', placeholder, autofocus)
import Html.Events exposing (on)
import Types exposing (Msg(..))
import Util exposing (findWeekDay)


lineStyle : Html.Attribute a
lineStyle =
    style
        [ ( "padding", "10px 10px 0" )
        ]


forecastItemView : Types.ForecastItem -> Html a
forecastItemView d =
    let
        { hour, description } =
            d

        formattedHour =
            if hour < 12 then
                String.concat [ "0", toString hour, ":00" ]
            else
                toString hour ++ ":00"
    in
        li [] [ text (String.concat [ formattedHour, " - ", description ]) ]


forecastPerDayView : Types.ForecastsPerDay -> Html a
forecastPerDayView groupItem =
    let
        ( day, forecasts ) =
            groupItem
    in
        li []
            [ text (findWeekDay day)
            , ul [] (List.map forecastItemView forecasts)
            ]


view : Types.Model -> Html Msg
view model =
    div []
        [ div [ lineStyle ]
            [ input
                [ type' "text"
                , autofocus True
                , placeholder "Enter city name"
                , onInput DebouncedRequestForecast
                ]
                []
            ]
        , div [ lineStyle ]
            [ text
                (String.concat
                    [ model.city.name
                    , " ("
                    , model.city.country
                    , ")"
                    ]
                )
            ]
        , ul [ lineStyle ]
            (List.map forecastPerDayView model.groupedByDay)
        ]
