module ActionTypes where

import DataTypes

type Action
  = NoOp
  | RequestForecast
  | UpdateForecast (Maybe DataTypes.City)
