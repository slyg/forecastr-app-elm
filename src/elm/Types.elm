module Types where

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

type alias ForecastItem =
  { dt: Int
  , dt_txt: String
  }

type alias Forecast =
  { city : City
  , list : List ForecastItem
  }

type alias Model =
  { city : City
  , timeTable : List String
  }

type Action
  = NoOp
  | RequestForecast String
  | UpdateForecast Forecast
  | FetchError String
