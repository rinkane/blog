module Page.About exposing (Data, Model, Msg, page)

import Css exposing (..)
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import Head
import Head.Seo as Seo
import Html.Styled
import List
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared exposing (seoBase)
import Style
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


type alias Data =
    HttpSource.Content


data : DataSource Data
data =
    HttpSource.getBlogAbout


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary { seoBase | title = "About", description = static.data.content }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    let
        content =
            static.data
    in
    { body =
        [ Html.Styled.div
            Style.layoutMainView
            [ Style.contentTitleView content
            , Style.contentPageView content
            ]
        ]
    , title = "About"
    }
