{-# LANGUAGE GeneralizedNewtypeDeriving  #-}

module App (module E, runGeoTimeApp, GeoTimeApp) where

import Control.Monad.Reader as E
import Network.HTTP.Req as E
import Types as E
import Data.Text as E
import Data.Aeson as E
import Args as E

import Control.Monad.Catch as E


--- App monad transformer
newtype GeoTimeApp a = GeoTimeApp { runApp :: ReaderT AppConfig IO a } deriving (Functor, Applicative, Monad, MonadIO, MonadReader AppConfig, MonadCatch, MonadThrow)

-- app runner
runGeoTimeApp :: GeoTimeApp a -> AppConfig -> IO a
runGeoTimeApp app = runReaderT (runApp app) 