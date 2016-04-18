module Store where

import Effects exposing (Effects)
import WebApi exposing (requestIP)
import ActionTypes exposing (Action(..))

type alias Model =
  { nextId : Int
  , ip : String
  }

init : (Model, Effects Action)
init =
  ( { nextId = 0
    , ip = "Unknown"
    }
  , Effects.none
  )

update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of

    RequestIP ->
      (model, requestIP "http://jsonip.com")

    UpdateIP ip ->
      ( { model | ip = (Maybe.withDefault "No response" ip) }
        , Effects.none
      )

    NoOp ->
      (model, Effects.none)
