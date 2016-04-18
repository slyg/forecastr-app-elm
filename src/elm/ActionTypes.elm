module ActionTypes where

type Action
  = NoOp
  | RequestForecast
  | UpdateForecast (Maybe String)
