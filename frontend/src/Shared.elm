module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import Browser.Navigation
import DataSource
import Element exposing (Element, column, layout, link, row, text)
import Element.Background
import Element.Border
import Element.Font as Font
import Html exposing (Html)
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
    -> { body : Html msg, title : String }
view sharedData page model toMsg pageView =
    { body =
        layout
            [ Element.width (Element.fill |> Element.minimum 700)
            , Element.Background.color (Element.rgb255 0xF1 0xE7 0xED)
            ]
            (column
                [ Element.width Element.fill ]
                (header :: pageView.body)
            )
    , title = pageView.title
    }


header : Element msg
header =
    Element.row
        [ Element.width Element.fill
        , Element.height (Element.px 60)
        , Element.paddingXY 24 8
        , Element.Border.shadow { blur = 5, size = 1, offset = ( 0, 0 ), color = Element.rgba255 0x36 0x20 0x6E 0.8 }
        , Element.Background.color (Element.rgb255 0x36 0x20 0x6E)
        , Font.color (Element.rgb255 0xFF 0xFF 0xFF)
        ]
        [ Element.el [ Element.alignLeft ] <|
            Element.link
                [ Font.size 24
                ]
                { url = "/", label = text "ブックオフに潜む物の怪" }
        ]
