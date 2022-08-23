module Page.Index exposing (Data, Model, Msg, page)

import Css exposing (..)
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import DataSource.MarkdownSource as MarkdownSource
import Head
import Head.Seo as Seo
import Html.Styled exposing (text)
import Html.Styled.Attributes exposing (css)
import List
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    {}


page : Page RouteParams Data
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildNoState { view = view }


data : DataSource Data
data =
    HttpSource.getBlog


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "TODO"
        , locale = Nothing
        , title = "TODO title" -- metadata.title -- TODO
        }
        |> Seo.website


type alias Data =
    HttpSource.Blog


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { body =
        [ Html.Styled.div
            [ css
                [ padding2 (px 8) (px 16)
                , margin2 (px 24) (px 0)
                , boxShadow5 (px 0) (px 0) (px 6) (px 1) (rgba 0x00 0x00 0x00 0.2)
                , backgroundColor (rgb 0xFF 0xFF 0xFF)
                ]
            ]
            [ Html.Styled.fromUnstyled (HttpSource.contentToHtml (HttpSource.getFirstContent static.data)) ]
        ]
    , title = "Index"
    }
