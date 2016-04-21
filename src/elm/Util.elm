module Util where

import Types exposing (Action(NoOp))

debounceProxy : Signal.Mailbox Action
debounceProxy =
  Signal.mailbox NoOp
