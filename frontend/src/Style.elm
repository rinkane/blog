module Style exposing (..)

import Css exposing (..)
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)


layoutIndex : Attribute msg
layoutIndex =
    css
        [ padding2 (px 8) (px 16)
        , margin2 (px 24) (px 0)
        , boxShadow5 (px 0) (px 0) (px 6) (px 1) (rgba 0x00 0x00 0x00 0.2)
        , backgroundColor (rgb 0xFF 0xFF 0xFF)
        ]


fontColorWhite : Style
fontColorWhite =
    color (rgb 0xFF 0xFF 0xFF)


backgroundColorGlobal : Style
backgroundColorGlobal =
    backgroundColor (rgb 0xF0 0xF0 0xF0)
