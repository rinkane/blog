module DataSource.HttpSource exposing (..)

import DataSource exposing (DataSource)
import DataSource.Http
import Env.Environment exposing (blogAboutRequestDetails, blogRequestDetails)
import Html exposing (Html)
import Html.Parser
import Html.Parser.Util
import List
import Markdown exposing (defaultOptions)
import OptimizedDecoder exposing (Decoder)
import OptimizedDecoder.Pipeline exposing (..)
import Pages.Secrets


contentToHtml : Content -> Html msg
contentToHtml content =
    case Html.Parser.run content.content of
        Result.Ok html ->
            Html.div [] (Html.Parser.Util.toVirtualDom html)

        Result.Err err ->
            Html.div [] []


getFirstContent : Blog -> Content
getFirstContent blog =
    case List.head blog.contents of
        Nothing ->
            { id = "", title = "", content = "" }

        Just content ->
            content


getBlogAbout : DataSource Content
getBlogAbout =
    DataSource.Http.request
        (Pages.Secrets.succeed blogAboutRequestDetails)
        contentDecoder


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
