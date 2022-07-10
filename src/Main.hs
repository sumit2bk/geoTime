{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
module Main where

import App
import GeoCoords
import TimeZone
import qualified Data.ByteString as B
import qualified Data.Text.IO as TIO
import Data.Maybe
import Control.Exception (IOException)
import System.IO.Error (isDoesNotExistError, ioeGetFileName)

runWithConfig :: Args -> IO ()
runWithConfig (Args file) = do
    config <- eitherDecodeStrict <$> B.readFile file
    case config of
        Left m -> throwM ConfigError
        Right config' -> runGeoTimeApp processRequest config'


processRequest :: GeoTimeApp ()
processRequest = do
    liftIO $ TIO.putStrLn "Enter your address"
    req <- liftIO TIO.getLine
    gc <- getCoords req
    TZone {..} <- getLocalTime gc
    liftIO $ TIO.putStrLn $ "Local Time: " <> formatted <> "\nZone name: " <> zoneName


main :: IO ()
main = (cmdLineParser >>= runWithConfig) `catches` [Handler printIOError, Handler printOthers]
 where
     printIOError :: IOException -> IO ()
     printIOError e
      | isDoesNotExistError e = do
            let mbfn = ioeGetFileName e
            putStrLn $ "File " ++ fromMaybe "" mbfn  ++ " not found"
      | otherwise = putStrLn $ "I/O error: " ++ show e
     printOthers ::  SomeException -> IO ()
     printOthers = print    