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
                    [ height (pct 100)
                    , margin2 (px 0) auto
                    ]
                ]
                [ global
                , header
                , pageBodyView pageView.body
                ]
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
            [ backgroundColor (rgb 0xF0 0xF0 0xF0)
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
            , alignItems center
            ]
        ]
        [ div
            [ css
                [ textAlign start
                , pageMaxWidth
                , displayFlex
                , margin2 (px 0) auto
                ]
            ]
            [ headerLogo
                [ text "ブックオフを守る翼竜"
                , div
                    [ css
                        [ fontSize (px 14)
                        , marginLeft (rem 0.25)
                        , position relative
                        , top (rem 0.25)
                        ]
                    ]
                    [ text "ver0.1" ]
                ]
            , headerLink [ a [] [ text "Home" ] ]
            ]
        ]


headerLogo : List (Html msg) -> Html msg
headerLogo content =
    div
        [ css
            (headerContentCss
                ++ [ fontSize (px 24)
                   , paddingRight (px 24)
                   ]
            )
        ]
        content


headerLink : List (Html msg) -> Html msg
headerLink content =
    div
        [ css
            (headerContentCss
                ++ [ padding2 (px 0) (px 24) ]
            )
        ]
        content


headerContentCss : List Style
headerContentCss =
    [ display inlineFlex
    , height (px 60)
    , alignItems center
    , cursor pointer
    ]


pageBodyView : List (Html msg) -> Html msg
pageBodyView content =
    div
        [ css
            [ pageMaxWidth
            , margin2 (px 0) auto
            ]
        ]
        content


pageMaxWidth : Style
pageMaxWidth =
    maxWidth (Css.em 50)
