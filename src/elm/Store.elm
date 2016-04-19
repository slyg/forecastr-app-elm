module Store where

import Effects exposing (Effects)
import WebApi exposing (requestForecast)
import ActionTypes exposing (Action(..))
import DataTypes

type alias Model =
  { nextId : Int
  , city : DataTypes.City
  }

initCoord : DataTypes.Coord
initCoord =
  { lat = 0.0
  , lon = 0.0
  }

initCity : DataTypes.City
initCity =
  { country = "UKN"
  , id = 0
  , name = "Unknown"
  , coord = initCoord
  }

init : (Model, Effects Action)
init =
  ( { nextId = 0
    , city = initCity
    }
  , Effects.none
  )

update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of

    RequestForecast ->
      (model, requestForecast "Paris")

    UpdateForecast city ->
      ( { model | city = (Maybe.withDefault initCity city) }
        , Effects.none
      )

    NoOp ->
      (model, Effects.none)
