module DataSource.HttpSource exposing (..)

import Css exposing (content)
import DataSource exposing (DataSource)
import DataSource.Http
import Date
import Env.Environment exposing (blogAboutRequestDetails, blogRequestDetails)
import Html exposing (Html)
import Html.Parser
import Html.Parser.Util
import Html.Styled
import Html.Styled.Attributes exposing (css)
import Iso8601
import List
import Markdown exposing (defaultOptions)
import OptimizedDecoder exposing (Decoder)
import OptimizedDecoder.Pipeline exposing (..)
import Pages.Secrets
import Time exposing (Month(..))


contentToHtml : Content -> List (Html msg)
contentToHtml content =
    case Html.Parser.run content.content of
        Result.Ok html ->
            Html.Parser.Util.toVirtualDom html

        Result.Err err ->
            []


getFirstContent : Blog -> Content
getFirstContent blog =
    case List.head blog.contents of
        Nothing ->
            { id = "", title = "", content = "", createdAt = Date.fromCalendarDate 2022 Apr 1, updatedAt = Date.fromCalendarDate 2022 Apr 1, category = [] }

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
        |> required "createdAt" dateDecoder
        |> required "updatedAt" dateDecoder
        |> required "category" (OptimizedDecoder.list contentCategoryDecoder)


contentCategoryDecoder : Decoder ContentCategory
contentCategoryDecoder =
    decode ContentCategory
        |> required "id" OptimizedDecoder.string
        |> required "name" OptimizedDecoder.string


dateDecoder : Decoder Date.Date
dateDecoder =
    OptimizedDecoder.string
        |> OptimizedDecoder.andThen
            (\str ->
                case Iso8601.toTime str of
                    Result.Ok time ->
                        OptimizedDecoder.succeed (Date.fromPosix Time.utc time)

                    Result.Err err ->
                        OptimizedDecoder.fail "Invalid date"
            )


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
    , createdAt : Date.Date
    , updatedAt : Date.Date
    , category : List ContentCategory
    }


type alias ContentCategory =
    { id : String
    , name : String
    }
