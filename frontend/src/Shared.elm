module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Navigation
import Css exposing (..)
import Css.Global
import DataSource
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Path exposing (Path)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Just OnPageChange
    }


type Msg
    = OnPageChange
        { path : Path
        , query : Maybe String
        , fragment : Maybe String
        }
    | SharedMsg SharedMsg


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMobileMenu : Bool
    }


init :
    Maybe Browser.Navigation.Key
    -> Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : Path
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Cmd Msg )
init navigationKey flags maybePagePath =
    ( { showMobileMenu = False }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnPageChange _ ->
            ( { model | showMobileMenu = False }, Cmd.none )

        SharedMsg globalMsg ->
            ( model, Cmd.none )


subscriptions : Path -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


view :
    Data
    ->
        { path : Path
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : Html.Html msg, title : String }
view sharedData page model toMsg pageView =
    { body =
        toUnstyled
            (div
                [ css
                    [ minWidth (px 700)
                    , height (pct 100)
                    , margin (px 0)
                    ]
                ]
                (global :: header :: pageView.body)
            )
    , title = pageView.title
    }


global : Html msg
global =
    Css.Global.global
        [ Css.Global.selector "body"
            [ margin (px 0)
            ]
        , Css.Global.selector "html"
            [ backgroundColor (rgb 0xF1 0xE7 0xED)
            ]
        ]


header : Html msg
header =
    div
        [ css
            [ width auto
            , height (px 60)
            , boxShadow5 (px 0) (px 0) (px 5) (px 1) (rgba 0x36 0x20 0x6E 0.8)
            , backgroundColor (rgb 0x36 0x20 0x6E)
            , color (rgb 0xFF 0xFF 0xFF)
            , displayFlex
            , alignItems center
            ]
        ]
        [ div
            [ css
                [ textAlign start
                ]
            ]
            [ a
                [ css
                    [ fontSize (px 24)
                    , padding2 (px 0) (px 24)
                    , display inlineFlex
                    , height (px 60)
                    , alignItems center
                    , cursor pointer
                    ]
                ]
                [ text "ブックオフに潜む物の怪" ]
            ]
        ]
