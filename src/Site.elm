module Site exposing (config)

import DataSource
import Head
import MimeType
import Pages.Manifest as Manifest
import Pages.Url exposing (Url)
import Path
import Route
import SiteConfig exposing (SiteConfig)
import Url


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = "https://www.rinkaneisdead.ml/"
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head _ =
    [ Head.icon [ ( 175, 175 ) ] MimeType.Png (Pages.Url.fromPath (Path.fromString "icon.png")) ]


manifest : Data -> Manifest.Config
manifest _ =
    Manifest.init
        { name = "ブックオフを守る翼竜"
        , description = "rinkane's personal journal"
        , startUrl = Route.Index |> Route.toPath
        , icons =
            [ { src = Pages.Url.fromPath (Path.fromString "icon.png")
              , sizes = [ ( 175, 175 ) ]
              , mimeType = Just MimeType.Png
              , purposes = [ Manifest.IconPurposeAny ]
              }
            ]
        }
