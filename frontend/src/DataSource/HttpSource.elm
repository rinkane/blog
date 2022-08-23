module DataSource.HttpSource exposing (..)

import DataSource exposing (DataSource)
import DataSource.Http
import Env.Environment exposing (blogRequestDetails)
import List
import OptimizedDecoder exposing (Decoder)
import OptimizedDecoder.Pipeline exposing (..)
import Pages.Secrets


getFirstContent : Blog -> Content
getFirstContent blog =
    case List.head blog.contents of
        Nothing ->
            { id = "", title = "", content = "" }

        Just content ->
            content


getBlog : DataSource Blog
getBlog =
    DataSource.Http.request
        (Pages.Secrets.succeed blogRequestDetails)
        blogDecoder


blogDecoder : Decoder Blog
blogDecoder =
    decode Blog
        |> required "contents" (OptimizedDecoder.list contentDecoder)
        |> required "totalCount" OptimizedDecoder.int
        |> required "offset" OptimizedDecoder.int
        |> required "limit" OptimizedDecoder.int


contentDecoder : Decoder Content
contentDecoder =
    decode Content
        |> required "id" OptimizedDecoder.string
        |> required "title" OptimizedDecoder.string
        |> required "content" OptimizedDecoder.string


type alias Blog =
    { contents : List Content
    , totalCount : Int
    , offset : Int
    , limit : Int
    }


type alias Content =
    { id : String
    , title : String
    , content : String
    }
