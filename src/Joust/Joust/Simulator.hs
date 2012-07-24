{-# LANGUAGE TemplateHaskell  #-}
module Joust.Joust.Simulator where
import Joust.Joust.Types
import Control.Monad.RWS
import Control.Monad.Identity
import Physics.V2
import Lens.Family2
import Lens.Family2.State
import Lens.Family2.Unchecked
import Lens.Family2.TH

type Log = ()

data Config = Config {
        _cfgLevel :: Level
    }
$(mkLenses ''Config)

data Environment = Environment {
        _envEnemies   :: [Character],
        _envHero      :: Character,
        _envLives     :: Int,
        _envScore     :: Int
    }
$(mkLenses ''Environment)

type ContextT = RWST Config Log Environment    
type Context  = ContextT Identity    

levelBodies :: Level -> [PassiveBody]
levelBodies = map _platPassiveBody . _lvlPlatforms

rigidBodiesL :: Lens Environment [(CharacterType, ActiveBody)]
rigidBodiesL = undefined

mapSndL :: Lens [(a, b)] [b]
mapSndL = undefined

updMainChar :: Movement -> Context ()
updMainChar m = envHero.charBody.aBodyAccel += mToAccell m

mToAccell :: Movement -> V2 Double
mToAccell Up   = undefined
mToAccell Down = undefined
mToAccell R    = undefined
mToAccell L    = undefined

updEnemies :: Context ()
updEnemies = undefined -- randomly accellerate

resolveConflict :: [Collision] -> Context Result
resolveConflict = undefined

updPhysics :: Context [Collision] 
updPhysics = do 
    ps <- asks $ levelBodies . _cfgLevel
    as <- access $ rigidBodiesL.mapSndL 
    let (newAs, events) = simulate ps as
    rigidBodiesL.mapSndL ~= newAs
    return events
    
simulate :: [PassiveBody] -> [ActiveBody] 
         -> ([ActiveBody], [Collision])
simulate ps as = undefined -- update the velocity

detectCollision :: Body -> Body -> Maybe Collision
detectCollision = undefined

lifeEval :: Maybe Movement -> Context Result
lifeEval m = do
    maybe (return ()) updMainChar m
    updEnemies
    events <- updPhysics
    resolveConflict events    