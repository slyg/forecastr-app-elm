port module State exposing (..)

import String
import Platform.Cmd as Cmd exposing (Cmd)
import WebApi exposing (requestForecast)
import Types exposing (Msg(..))
import Selectors exposing (selectFromRawForecastItem, groupByDay)


-- MODEL


initModel : Types.Model
initModel =
    { city = Nothing
    , timeTable = []
    , groupedByDay = []
    }


init : ( Types.Model, Cmd Msg )
init =
    ( initModel
    , Cmd.none
    )



-- UPDATE


port sendDebouncedMessage : String -> Cmd msg


port abortDebouncedMessage : Maybe String -> Cmd msg


update : Msg -> Types.Model -> ( Types.Model, Cmd Msg )
update action model =
    case action of
        DebouncedRequestForecast q ->
            if q == "" then
                ( initModel
                , abortDebouncedMessage Nothing
                )
            else
                ( model, sendDebouncedMessage q )

        RequestForecast q ->
            ( model, requestForecast q )

        UpdateForecast data ->
            let
                timeTable =
                    List.map selectFromRawForecastItem data.list

                safeGroupByDay =
                    List.filterMap identity >> List.foldr groupByDay []
            in
                ( { model
                    | city = Just data.city
                    , timeTable = timeTable
                    , groupedByDay = safeGroupByDay timeTable
                  }
                , Cmd.none
                )

        FetchError error ->
            Debug.log (toString error)
                ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


port receiveDebouncedMessage : (String -> msg) -> Sub msg


subscriptions : Types.Model -> Sub Msg
subscriptions model =
    receiveDebouncedMessage RequestForecast
