
-- To run, package aivika-experiment-diagrams must be installed.

import Simulation.Aivika.Experiment
import Simulation.Aivika.Experiment.Chart
import Simulation.Aivika.Experiment.Chart.Backend.Diagrams

import Graphics.Rendering.Chart.Backend.Diagrams

import Web.Browser

import System.FilePath
import System.Directory

import Model
import Experiment

filePath = WritableFilePath "experiment"

main = 
  do fonts <- loadCommonFonts
     let renderer = DiagramsRenderer SVG (return fonts)
     runExperimentParallel experiment generators (WebPageRenderer renderer filePath) model
     dir <- getCurrentDirectory
     let index = dir </> "experiment" </> "index.html"
     _ <- openBrowser index
     return ()
