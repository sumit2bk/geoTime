{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
module TimeZone where

import App


-- lookup local time from coordinates
getLocalTime :: Coords -> GeoTimeApp TZone
getLocalTime Coords {..}  = do
    k <- asks key
    let 
        ep = https "api.timezonedb.com" /: "v2.1" /: "get-time-zone"
        reqParams = mconcat [ "key" =: k
                            , "lat" =: lat
                            , "lng" =: lon
                            , "format" =: ("json" :: Text)
                            , "fields" =: ("zoneName,formatted" :: Text)
                            , "by" =: ("position" :: Text)
                            ]
    res <- liftIO $ runReq defaultHttpConfig 
                $ req GET ep NoReqBody jsonResponse reqParams
    pure $ responseBody res