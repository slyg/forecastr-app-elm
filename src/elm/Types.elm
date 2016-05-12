module Types exposing (..)

import Http
import Date exposing (Date, Day)

-- shared types (Raw and Model)

type alias City =
  { country: String
  , id: Int
  , name: String
  }

-- Raw data types (coming from API)

type alias ForecastRawData =
  { city : City
  , list : List ForecastItemRawData
  }

type alias ForecastItemRawData =
  { dt: Int
  , dt_txt: String
  , weather: List WeatherItemRawData
  }

type alias WeatherItemRawData =
  { description: String
  , icon: String
  , id: Int
  , main: String
  }

-- Model's data types

type alias Model =
  { city : City
  , timeTable : List (Maybe ForecastItem)
  , groupedByDay : List (ForecastsPerDay)
  }

type alias ForecastItem =
  { day: Day
  , hour: Int
  , description : String
  }

type alias ForecastsPerDay =
  (Day, List ForecastItem)

-- Msg types

type Msg
  = NoOp
  | RequestForecast String
  | UpdateForecast ForecastRawData
  | FetchError Http.Error
