{-# LANGUAGE OverloadedStrings #-}

module  App.Context(
  ServerError(..)
  ,status
  ,message
  ,createContext
  ,runApp
) where

import Control.Monad.Reader (runReaderT)
import qualified Data.Text.Lazy as T

import Web.Scotty.Trans (ScottyT, ActionT, ScottyError(..))

import App.Types

createContext ::DBConnections -> String -> AppContext
createContext conns key =
  AppContext {
    dbConns = conns
    ,secret = key
}

runApp :: AppContext ->App a -> IO a
runApp ctx app = runReaderT app ctx
