module Util where

import ActionTypes exposing (Action(NoOp))

debounceProxy : Signal.Mailbox Action
debounceProxy =
  Signal.mailbox NoOp
