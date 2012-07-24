module Paths_joust (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch


version :: Version
version = Version {versionBranch = [0,1,0,0], versionTags = []}
bindir, libdir, datadir, libexecdir :: FilePath

bindir     = "/Users/jonathan.fischoff/Library/Haskell/ghc-7.4.1/lib/joust-0.1.0.0/bin"
libdir     = "/Users/jonathan.fischoff/Library/Haskell/ghc-7.4.1/lib/joust-0.1.0.0/lib"
datadir    = "/Users/jonathan.fischoff/Library/Haskell/ghc-7.4.1/lib/joust-0.1.0.0/share"
libexecdir = "/Users/jonathan.fischoff/Library/Haskell/ghc-7.4.1/lib/joust-0.1.0.0/libexec"

getBinDir, getLibDir, getDataDir, getLibexecDir :: IO FilePath
getBinDir = catchIO (getEnv "joust_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "joust_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "joust_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "joust_libexecdir") (\_ -> return libexecdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
