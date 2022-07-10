{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}

module Types where

import Data.Aeson
import Data.Text
import GHC.Generics
import Control.Monad.Catch

-- Adress of the location for which we need to find local time.
type Address = Text



-- Types used in deserialization of JSON repsonse obtained after calling the APIs.
data Coords = Coords {lon :: Text, lat :: Text } deriving (Show, Generic, FromJSON)

data TZone = TZone {zoneName :: Text, formatted :: Text} deriving (Show, Generic, FromJSON)



-- Application config
data AppConfig =  AppConfig {key :: Text, email :: Text, agent :: Text } deriving (Show, Generic, FromJSON)

-- Exceptions possible in geo time app
data GeoTimeException = ConfigError | InvalidAdress Text deriving Exception 

instance Show GeoTimeException where
    show ConfigError = "Error parsing config file."
    show (InvalidAdress _) = "Could not find coords for this address."