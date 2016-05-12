module Util exposing (..)

import Types exposing (Msg(NoOp))
import Date exposing (Date, Day(Mon, Tue, Wed, Thu, Fri, Sat, Sun), dayOfWeek)

findWeekDay : Day -> String
findWeekDay day =
  case day of
    Mon -> "Monday"
    Tue -> "Tuesday"
    Wed -> "Wednesday"
    Thu -> "Thursday"
    Fri -> "Friday"
    Sat -> "Saturday"
    Sun -> "Sunday"
