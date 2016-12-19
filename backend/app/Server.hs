{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}

module Server (mainServer) where

import           API                   (API, StaticFiles)
import           Database.StatementMap
import           Json.API              (JsonAPI)
import           Json.Server           (jsonServer)
import qualified Util.Config           as Config

import           Database.HDBC         (IConnection)
import           Servant


mainServer ::
  IConnection connection =>
  Config.AppConfig
  -> DbConnection connection
  -> Server API
mainServer appConfig dbConnection =
  let
    jsonAPIHandler :: Server JsonAPI
    jsonAPIHandler = jsonServer appConfig dbConnection
    staticHandler :: Server StaticFiles
    staticHandler = serveDirectory "frontend"
  in
       jsonAPIHandler
  :<|> staticHandler
