module Site exposing (config)

import DataSource
import Env.Environment as Env
import Head
import MimeType
import Pages.Manifest as Manifest
import Pages.Url exposing (Url)
import Path
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://images.microcms-assets.io/assets"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head _ =
    [ Head.icon [ ( 192, 192 ) ] MimeType.Png Env.iconUrl ]


manifest : Data -> Manifest.Config
manifest _ =
    Manifest.init
        { name = "Site Name"
        , description = "Void"
        , startUrl = Route.Index |> Route.toPath
        , icons =
            [ { src = Env.iconUrl
              , sizes = [ ( 192, 192 ) ]
              , mimeType = Just MimeType.Png
              , purposes = [ Manifest.IconPurposeAny ]
              }
            ]
        }
