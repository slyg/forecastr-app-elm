module ActionTypes where

import DataTypes
import Time exposing (Time)

type Action
  = NoOp
  | RequestForecast String
  | UpdateForecast DataTypes.City
  | FetchError String
