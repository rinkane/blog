module DataSource.MarkdownSource exposing (..)

import DataSource exposing (DataSource)
import DataSource.File
import OptimizedDecoder as Decode exposing (Decoder)
import OptimizedDecoder.Pipeline as Pipeline exposing (required)


blogPost : DataSource BlogPostMetadata
blogPost =
    DataSource.File.bodyWithFrontmatter blogPostDecoder ""


type alias BlogPostMetadata =
    { body : String
    , title : String
    , tags : List String
    }


blogPostDecoder : String -> Decoder BlogPostMetadata
blogPostDecoder body =
    Decode.map2 (BlogPostMetadata body)
        (Decode.field "title" Decode.string)
        (Decode.field "tags" tagsDecoder)


tagsDecoder : Decoder (List String)
tagsDecoder =
    Decode.map (String.split " ") Decode.string
