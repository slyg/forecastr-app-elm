module ActionTypes where

import DataTypes

type Action
  = NoOp
  | RequestForecast
  | UpdateForecast DataTypes.City
  | FetchError String
