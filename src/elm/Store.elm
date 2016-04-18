module Store where

import Effects exposing (Effects)
import WebApi exposing (requestForecast)
import ActionTypes exposing (Action(..))

type alias Model =
  { nextId : Int
  , cod : String
  }

init : (Model, Effects Action)
init =
  ( { nextId = 0
    , cod = "Unknown"
    }
  , Effects.none
  )

update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of

    RequestForecast ->
      (model, requestForecast "London")

    UpdateForecast cod ->
      ( { model | cod = (Maybe.withDefault "No response" cod) }
        , Effects.none
      )

    NoOp ->
      (model, Effects.none)
