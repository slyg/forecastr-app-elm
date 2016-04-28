module Types where

import Date exposing (Date, Day)

type alias City =
  { coord: Coord
  , country: String
  , id: Int
  , name: String
  }

type alias Coord =
  { lat: Float
  , lon: Float
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

type alias ForecastItem =
  { day: Day
  }

type alias Forecast =
  { city : City
  , list : List ForecastItemRawData
  }

type alias ForecastsPerDay =
  (Day, List ForecastItem)

type alias Model =
  { city : City
  , timeTable : List (Maybe ForecastItem)
  , groupedByDay : List (ForecastsPerDay)
  }

type Action
  = NoOp
  | RequestForecast String
  | UpdateForecast Forecast
  | FetchError String
