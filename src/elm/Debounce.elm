import Html exposing (input, div, button, text, Html)
import Html.Events exposing (on, onClick, targetValue)
import Html.Attributes exposing (value, type')
import StartApp
import Task
import Signal.Time exposing (settledAfter)
import Time

import Effects exposing (Effects, Never)

type Action
  = Search String
  | Clear
  | NoOp

type alias Model = String

app = StartApp.start
  { init = init
  , update = update
  , view = view
  , inputs = [ debounce ]
  }

main = app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks = app.tasks

init =
 ("", Effects.none)

update action model =
  case action of
    NoOp ->
      (model, Effects.none)
    Clear ->
      ("", Effects.none)
    Search text ->
      (text, Effects.none)

-------------------
debounceProxy : Signal.Mailbox Action
debounceProxy =
  Signal.mailbox NoOp

debounce : Signal Action
debounce =
  settledAfter (500 * Time.millisecond) debounceProxy.signal
-------------------

onTextChange : (String -> Action) -> Html.Attribute
onTextChange contentToValue =
    on "input" targetValue (\str -> Signal.message debounceProxy.address (contentToValue str))

view : Signal.Address Action -> String -> Html
view address model =
    div []
        [ input  [ type' "text", value model, onTextChange Search] []
        , button [ onClick address Clear ] [text "Clear"]
        , div [] [ text model ]
        ]
