module Store where

import Effects exposing (Effects)
import WebApi exposing (requestForecast)
import ActionTypes exposing (Action(..))
import DataTypes

type alias Model =
  { nextId : Int
  , city : DataTypes.City
  , query : Maybe (String)
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
    , query = Maybe.Nothing
    }
  , Effects.none
  )

update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of

    TypingQuery q ->
      let
        query =
          if q == "" then
            Maybe.Nothing
          else
            Maybe.Just q
      in
        ( { model | query = query }
          , Effects.none
        )

    RequestForecast ->
      case model.query of
        Just data ->
          (model, requestForecast data)
        Nothing ->
          (model, Effects.none)

    UpdateForecast data ->
      ( { model | city = data }
        , Effects.none
      )

    FetchError error ->
      Debug.log (toString error)
      (model, Effects.none)

    NoOp ->
      (model, Effects.none)
