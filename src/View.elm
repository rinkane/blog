module View exposing (View, map, placeholder)

import Html.Styled exposing (..)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Html.Styled.map fn) doc.body
    }


placeholder : String -> View msg
placeholder moduleName =
    { title = "輪禍rnation"
    , body = [ text moduleName ]
    }
