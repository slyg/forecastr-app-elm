module DataTypes(City, Coord) where

type alias City =
  { coord: Coord
  , country: String
  , id: String
  , name: String
  }

type alias Coord =
  { lat: Float
  , lon: Float
  }
