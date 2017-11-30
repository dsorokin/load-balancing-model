
module Model (model) where

import qualified Data.Array as A

import Control.Monad
import Control.Monad.Trans

import System.Random.Shuffle

import Simulation.Aivika
import Simulation.Aivika.Experiment

minPings = 5
maxPings = 10

-- each pair ~ N (mu, nu)
pings = [(60, 5), (61, 5), (200, 10), (53, 5), (62, 5)]

-- available node number
nodeCount = length pings

-- what we had before
oldPingCount i = maxPings

-- what we have now
currPingCount 0 = minPings
currPingCount _ = maxPings

-- what we can receive
newPingCount 0 = minPings
newPingCount i = minPings + round (fromIntegral (i * (maxPings - minPings))
                                   / fromIntegral (nodeCount - 1))

model :: Simulation Results
model =
  do winner <- newRef 0

     pings' <- liftIO $ shuffleM $ zip pings [1 :: Int ..]
     let nodeMu = A.listArray (0, nodeCount - 1) $ fmap (fst . fst) pings'
         nodeNu = A.listArray (0, nodeCount - 1) $ fmap (snd . fst) pings'
         nodes  = A.listArray (0, nodeCount - 1) $ fmap snd pings'

     forM_ [0 .. nodeCount - 1] $ \i ->
       runProcessInStartTime $
       do let mu   = nodeMu A.! i
              nu   = nodeNu A.! i
              node = nodes A.! i
              n    = newPingCount i
          forM_ [1 .. n] $ \ping ->
            randomNormalProcess mu nu
          x <- liftEvent $ readRef winner
          when (x == 0) $
            liftEvent $ writeRef winner node

     return $
       results
       [resultSource "winner" "The winner node" winner]
