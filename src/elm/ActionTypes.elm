module ActionTypes where

type Action
  = NoOp
  | RequestIP
  | UpdateIP (Maybe String)
