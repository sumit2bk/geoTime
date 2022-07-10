{-# LANGUAGE OverloadedStrings #-}

module GeoCoords where

import App
import Data.Text.Encoding

-- lookup coordinates from Address
getCoords :: Address -> GeoTimeApp Coords
getCoords addr = do
    config <- ask
    let
        ep = https "nominatim.openstreetmap.org" /: "search"
        reqParams =
             mconcat [
                "q" =: addr,
                "format" =: ("json" :: Text),
                "limit" =: (1 :: Int),
                "email" =: email config,
                header "User-agent" (encodeUtf8 $ agent config)
            ]
        request = req GET ep NoReqBody jsonResponse reqParams
    res <-  liftIO $ responseBody <$> runReq defaultHttpConfig request
    case res of
        (coords:_) -> pure coords
        [] -> throwM $ InvalidAdress addr 