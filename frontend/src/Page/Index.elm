module Page.Index exposing (Data, Model, Msg, page)

import Array
import Css exposing (..)
import DataSource exposing (DataSource)
import Head
import Head.Seo as Seo
import Html.Styled exposing (text, toUnstyled)
import Html.Styled.Attributes exposing (css)
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
    DataSource.succeed ()


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
    ()


view :
    Maybe PageUrl
    -> Shared.Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel static =
    { body =
        [ Html.Styled.div
            [ css [ margin2 (px 24) (px 16) ] ]
            (List.repeat 1000 (Html.Styled.div [] [ text "Index" ]))
        ]
    , title = "Index"
    }
