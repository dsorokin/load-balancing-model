
module Experiment (experiment, generators) where

import Data.Monoid

import Simulation.Aivika
import Simulation.Aivika.Experiment
import Simulation.Aivika.Experiment.Chart

specs = Specs { spcStartTime = 0.0,
                spcStopTime = 5000.0,
                spcDT = 10.0,
                spcMethod = RungeKutta4,
                spcGeneratorType = SimpleGenerator }

experiment :: Experiment
experiment =
  defaultExperiment {
    experimentSpecs = specs,
    experimentRunCount = 10000,
    experimentDescription = "Experiment Description" }

i = resultByName "winner"

generators :: ChartRendering r => [WebPageGenerator r]
generators =
  [outputView defaultExperimentSpecsView,
   outputView $ defaultFinalHistogramView {
     finalHistogramPlotTitle = "The winner node",
     finalHistogramSeries = i },
   outputView $ defaultFinalTableView {
     finalTableSeries = i } ]
