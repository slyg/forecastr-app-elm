import StartApp
import Html exposing (Html, text, div, button)
import Html.Events exposing (onClick)

import Signal exposing (Address)
import Effects exposing (Effects, Never)
import Http
import Json.Decode as Json exposing ((:=))
import Task exposing (..)

app =
  StartApp.start
    { init = init
    , view = view
    , update = update
    , inputs = []
    }

main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks

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

model = init

type Action
  = NoOp
  | RequestIP
  | UpdateIP (Maybe String)

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


view : Address Action -> Model -> Html
view address model =
  div []
    [ button [ onClick address RequestIP ] [ text "Get Ip" ]
    , div [] [ text model.ip ]
  ]

requestIP : String -> Effects Action
requestIP url =
  Http.get ("ip" := Json.string) url
    |> Task.toMaybe
    |> Task.map UpdateIP
    |> Effects.task
