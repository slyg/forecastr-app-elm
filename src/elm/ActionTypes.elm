module ActionTypes where

import DataTypes

type Action
  = NoOp
  | TypingQuery String
  | RequestForecast
  | UpdateForecast DataTypes.City
  | FetchError String
