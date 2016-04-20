module ActionTypes where

import DataTypes
import Time exposing (Time)

type Action
  = NoOp
  | UpdateTime Time
  | TypingQuery String
  | RequestForecast
  | UpdateForecast DataTypes.City
  | FetchError String
