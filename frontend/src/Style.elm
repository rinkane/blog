module Style exposing (..)

import Css exposing (..)
import DataSource.HttpSource as HttpSource
import Date
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)


contentPageView : HttpSource.Content -> Html.Styled.Html msg
contentPageView content =
    Html.Styled.div
        [ css
            [ Css.lineHeight (Css.rem 1.7)
            , Css.paddingTop (Css.rem 1)
            , Css.maxHeight (Css.pct 100)
            ]
        ]
        (content
            |> HttpSource.contentToHtml
            |> List.map Html.Styled.fromUnstyled
        )


contentDateView : HttpSource.Content -> Html.Styled.Html msg
contentDateView content =
    Html.Styled.div
        [ css
            [ marginTop (rem 0.33)
            , fontSize (rem 0.75)
            ]
        ]
        [ text ("公開日: " ++ Date.format "yyyy/MM/dd" content.createdAt) ]


contentCategoriesView : HttpSource.Content -> Html.Styled.Html msg
contentCategoriesView content =
    Html.Styled.div
        [ css
            [ margin2 (rem 0.33) (rem 0)
            , fontSize (rem 0.75)
            ]
        ]
        (text
            "カテゴリ: "
            :: List.map contentCategoryView content.category
        )


contentCategoryView : HttpSource.ContentCategory -> Html.Styled.Html msg
contentCategoryView category =
    Html.Styled.span
        [ css
            [ margin2 (rem 0) (rem 0.33) ]
        ]
        [ text category.name ]


contentNoLinkTitleView : HttpSource.Content -> Html.Styled.Html msg
contentNoLinkTitleView content =
    Html.Styled.div
        [ css
            [ lineHeight (rem 2)
            , height (rem 2)
            ]
        ]
        [ Html.Styled.h1
            [ css
                [ borderBottom3 (px 2) solid (rgb 0xDD 0xDD 0xDD)
                , padding3 (rem 0) (rem 0) (rem 0.5)
                , marginTop (rem 1.25)
                ]
            ]
            [ Html.Styled.a
                [ css (aTagFontColor <| rgb 0x33 0x33 0x33)
                , Html.Styled.Attributes.href "#"
                ]
                [ text content.title ]
            ]
        ]


contentTitleView : HttpSource.Content -> Html.Styled.Html msg
contentTitleView content =
    Html.Styled.div
        [ css
            [ lineHeight (rem 2)
            , height (rem 2)
            ]
        ]
        [ Html.Styled.h1
            [ css
                [ borderBottom3 (px 2) solid (rgb 0xDD 0xDD 0xDD)
                , padding3 (rem 0) (rem 0) (rem 0.5)
                , marginTop (rem 1.25)
                ]
            ]
            [ Html.Styled.a
                [ css (aTagFontColor <| rgb 0x33 0x33 0x33)
                , Html.Styled.Attributes.href ("blog/" ++ content.id)
                ]
                [ text content.title ]
            ]
        ]


layoutMainView : List (Attribute msg)
layoutMainView =
    [ css
        [ padding2 (px 8) (px 16)
        , margin2 (px 48) (px 0)
        , boxShadow5 (px 0) (px 0) (px 6) (px 1) (rgba 0x00 0x00 0x00 0.2)
        , backgroundColor (rgb 0xFF 0xFF 0xFF)
        , color (rgb 0x33 0x33 0x33)
        ]
    ]


layoutPartialView : List (Attribute msg)
layoutPartialView =
    css
        [ maxHeight (rem 25)
        , overflow hidden
        , position relative
        ]
        :: layoutMainView


fontColorWhite : Style
fontColorWhite =
    color (rgb 0xFF 0xFF 0xFF)


backgroundColorGlobal : Style
backgroundColorGlobal =
    backgroundColor (rgb 0xF0 0xF0 0xF0)


aTagFontColor : Color -> List Style
aTagFontColor fontColor =
    [ textDecoration none
    , color fontColor
    , hover
        [ textDecoration none
        , color fontColor
        ]
    , active
        [ textDecoration none
        , color fontColor
        ]
    ]
