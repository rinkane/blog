module Page.Blog.Slug_ exposing (Data, Model, Msg, page)

import Css
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import Head
import Head.Seo as Seo
import Html.Styled
import Maybe
import Page exposing (Page, PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Path
import Shared
import Style
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
    let
        maybeBody =
            List.filter (\content -> content.id == (static.path |> Path.toSegments |> List.reverse |> List.head |> Maybe.withDefault "")) static.data.contents |> List.head
    in
    case maybeBody of
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
