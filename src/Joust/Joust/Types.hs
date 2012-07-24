{-# LANGUAGE TemplateHaskell  #-}
module Joust.Joust.Types where
import Physics.V2
import Lens.Family2
import Lens.Family2.State
import Lens.Family2.TH
import Control.Applicative

data Level = Level {
        _lvlPlatforms :: [Platform]
    }

data Platform = Platform {
        _platPassiveBody  :: PassiveBody, --position, scale, rotation
        _platSpawnPoint   :: Maybe SpawnPoint 
    }

data SpawnPoint = SpawnPoint {
        _spwnPosition   :: V2 Double -- local to the Platform
    }

data Square = Square {
        sqrHeight :: Double,
        sqrWidth  :: Double
    }

data Circle = Circle {
        _cirRadius :: Double
    }

data Geometry = S Square
              | C Circle

data Body = BP PassiveBody
          | BR ActiveBody

data PassiveBody = PassiveBody {
      _pbodyId       :: Int,
      _pbodyShape    :: Geometry,
      _pbodyPosition :: V2 Double
    }

--needs size 
data ActiveBody = ActiveBody {
        _aBodyId        :: Int,
        _aBodyShape     :: Geometry,
        _aBodyMass      :: Double,
        _aBodyPosition  :: V2 Double,
        _aBodyVelocity  :: V2 Double,
        _aBodyAccel     :: V2 Double
    }

data Character = Character {
        _charBody :: ActiveBody,
        _charAI   :: AI,
        _charType :: CharacterType
    }

data AI = Human
        | Computer

data CharacterType = Enemy
                   | Hero

data Movement = Up
              | Down
              | R
              | L

data Result = GameOver
            | LevelCleared
            | StillOn

data CollisionDatum = CollisionDatum {
        cdatId      :: Int,
        cdatLast    :: V2 Double,
        cdatCurrent :: V2 Double 
    }
    
data Collision = Collision {
        colFst :: CollisionDatum,
        colSnd :: CollisionDatum        
    }

$(do 
     let types = [''Level,
                  ''Platform,
                  ''SpawnPoint,
                  ''Square,
                  ''Circle,
                  ''PassiveBody,
                  ''ActiveBody,
                  ''Character,   
                  ''CollisionDatum, 
                  ''Collision]

     concat <$> mapM mkLenses types)





