module Args where

import Options.Applicative

newtype Args = Args FilePath -- config file

-- parse user command line arguments
mkArgs :: Parser Args
mkArgs = Args <$> config
 where
    config = strOption (long "conf" <> short 'c' <> value "config.json" <> showDefault <>
                        metavar "CONFIGNAME" <> help "Configuration file" )

-- run the parser
cmdLineParser :: IO Args
cmdLineParser = execParser opts
  where opts = info (mkArgs <**> helper)
                    (fullDesc <> progDesc "Reports current local time for the specified location")