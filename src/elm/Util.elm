module Util where

import Types exposing (Action(NoOp))
import Date exposing (Date, Day(Mon, Tue, Wed, Thu, Fri, Sat, Sun), dayOfWeek)

debounceProxy : Signal.Mailbox Action
debounceProxy =
  Signal.mailbox NoOp

findWeekDay : Date -> String
findWeekDay date =
  let
    day = dayOfWeek date
  in
    case day of
      Mon -> "Monday"
      Tue -> "Tuesday"
      Wed -> "Wednesday"
      Thu -> "Thursday"
      Fri -> "Friday"
      Sat -> "Saturday"
      Sun -> "Sunday"
