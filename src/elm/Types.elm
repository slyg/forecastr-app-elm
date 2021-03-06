module Types exposing (..)

import Http
import Date exposing (Date, Day)


-- shared types (Raw and Model)


type alias City =
    { country : String
    , id : Int
    , name : String
    }



-- Raw data types (coming from API)


type alias ForecastRawData =
    { city : City
    , list : List ForecastItemRawData
    }


type alias ForecastItemRawData =
    { dt : Int
    , dt_txt : String
    , weather : List WeatherItemRawData
    }


type alias WeatherItemRawData =
    { description : String
    , icon : String
    , id : Int
    , main : String
    }



-- Model's data types


type alias Model =
    { city : Maybe City
    , groupedByDay : List (ForecastsPerDay)
    , timeTable : List (Maybe ForecastItem)
    }


type alias ForecastItem =
    { day : Day
    , description : String
    , hour : Int
    }


type alias ForecastsPerDay =
    ( Day, List ForecastItem )



-- Msg types


type Msg
    = NoOp
    | DebouncedRequestForecast String
    | RequestForecast String
    | UpdateForecast ForecastRawData
    | FetchError Http.Error
