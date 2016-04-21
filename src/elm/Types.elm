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

type alias Model =
  { city : City
  }

type Action
  = NoOp
  | RequestForecast String
  | UpdateForecast City
  | FetchError String
