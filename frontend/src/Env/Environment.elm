module Env.Environment exposing (..)

import Pages.Url
import Path


imageAsset : Pages.Url.Url
imageAsset =
    [ "d7064c15be8e494f96e0a92425edc81a", "8ea0809ea4b747afae103bdcb6f34459" ] |> Path.join |> Pages.Url.fromPath


iconUrl : Pages.Url.Url
iconUrl =
    [ Pages.Url.toString imageAsset, "masou_gru3.png" ] |> Path.join |> Pages.Url.fromPath
