import StartApp.Simple as StartApp
import Html exposing (text, div)
import Html.Events exposing (onClick)

main =
  StartApp.start
    { view = view
    , update = update
    , model = model
    }

model =
  { nextId = 0
  }

type Action = Increment

update action model =

  case action of
    Increment ->
      { model |
          nextId = model.nextId + 1
      }

view address model =
  div [ onClick address Increment ] [ text ("Increment Id: " ++ (toString model.nextId)) ]
