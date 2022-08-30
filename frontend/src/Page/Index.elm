module Page.Index exposing (Data, Model, Msg, page)

import Css exposing (..)
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import DataSource.MarkdownSource as MarkdownSource
import Date
import Head
import Head.Seo as Seo
import Html
import Html.Styled exposing (text)
import Html.Styled.Attributes exposing (css)
import List
import Page exposing (Page, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
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
        , title = "ブックオフを守る翼竜" -- metadata.title -- TODO
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
        List.map contentView static.data.contents
    , title = "ブックオフを守る翼竜"
    }


contentView : HttpSource.Content -> Html.Styled.Html msg
contentView content =
    Html.Styled.div
        Style.layoutPartialView
        [ pageLinkView content
        , Html.Styled.div []
            [ Style.contentDateView content
            , Style.contentCategoriesView content
            , Style.contentTitleView content
            , Style.contentPageView content
            ]
        ]


pageLinkView : HttpSource.Content -> Html.Styled.Html msg
pageLinkView content =
    Html.Styled.a
        [ Html.Styled.Attributes.href ("blog/" ++ content.id)
        , css
            [ position absolute
            , bottom (px 0)
            , left (px 0)
            , width (pct 100)
            , height (pct 50)
            , Css.backgroundImage (linearGradient (stop <| rgba 0xFF 0xFF 0xFF 0) (stop2 (rgba 0xFF 0xFF 0xFF 0.4) (pct 10)) [ stop <| rgba 0xFF 0xFF 0xFF 1 ])
            , displayFlex
            , justifyContent center
            , alignItems end
            , fontSize (rem 1)
            ]
        ]
        [ Html.Styled.span
            [ css
                [ paddingBottom (rem 1) ]
            ]
            [ text "続きを読む" ]
        ]
