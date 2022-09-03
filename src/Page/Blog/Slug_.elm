module Page.Blog.Slug_ exposing (Data, Model, Msg, page)

import Css
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import Date
import Head
import Head.Seo as Seo
import Html.Styled
import Maybe
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Path
import Shared exposing (seoBase)
import Style
import Time exposing (Month(..))
import View exposing (View)


type alias Model =
    ()


type alias Msg =
    Never


type alias RouteParams =
    { slug : String }


page : Page RouteParams Data
page =
    Page.prerender
        { head = head
        , routes = routes
        , data = data
        }
        |> Page.buildNoState { view = view }


routes : DataSource (List RouteParams)
routes =
    HttpSource.getBlog
        |> DataSource.map
            (\blog ->
                List.map
                    (\content ->
                        { slug = content.id }
                    )
                    blog.contents
            )


data : RouteParams -> DataSource Data
data routeParams =
    DataSource.map
        (\blog ->
            List.filter (\content -> content.id == routeParams.slug) blog.contents |> List.head
        )
        HttpSource.getBlog


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    let
        content =
            case static.data of
                Just a ->
                    a

                Nothing ->
                    { id = ""
                    , title = ""
                    , content = ""
                    , createdAt = Date.fromCalendarDate 2022 Sep 3
                    , updatedAt = Date.fromCalendarDate 2022 Sep 3
                    , category = []
                    }
    in
    Seo.summary { seoBase | title = content.title, description = content.content }
        |> Seo.website


type alias Data =
    Maybe HttpSource.Content


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    case static.data of
        Nothing ->
            View.placeholder "Empty..."

        Just content ->
            { body =
                [ Html.Styled.div
                    Style.layoutMainView
                    [ Style.contentDateView content
                    , Style.contentCategoriesView content
                    , Style.contentNoLinkTitleView content
                    , Style.contentPageView content
                    ]
                ]
            , title = "About"
            }
