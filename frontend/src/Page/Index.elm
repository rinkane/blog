module Page.Index exposing (Data, Model, Msg, page)

import Css exposing (..)
import DataSource exposing (DataSource)
import DataSource.HttpSource as HttpSource
import DataSource.MarkdownSource as MarkdownSource
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
        List.map contentView static.data.contents
    , title = "Index"
    }


contentView : HttpSource.Content -> Html.Styled.Html msg
contentView content =
    Html.Styled.div
        [ Style.layoutIndex ]
        [ contentDateView content
        , contentTitleView content
        , content |> HttpSource.contentToHtml |> Html.Styled.fromUnstyled
        ]


contentDateView : HttpSource.Content -> Html.Styled.Html msg
contentDateView content =
    Html.Styled.div
        [ css
            [ margin2 (rem 0.33) (rem 0)
            , fontSize (rem 0.75)
            ]
        ]
        [ text ("公開日: " ++ content.id) ]


contentTitleView : HttpSource.Content -> Html.Styled.Html msg
contentTitleView content =
    Html.Styled.div
        []
        [ Html.Styled.h1
            [ css
                [ borderBottom3 (px 2) solid (rgb 0xDD 0xDD 0xDD)
                , height (rem 2)
                , lineHeight (rem 2)
                , padding3 (rem 0) (rem 0) (rem 0.5)
                , marginTop (rem 0)
                ]
            ]
            [ Html.Styled.text content.title ]
        ]
