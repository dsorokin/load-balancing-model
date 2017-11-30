
The Load Balancing Model

### Prerequisites

You need [Stack](http://docs.haskellstack.org/) installed on your computer. But to reproduce the test, you don't need to know the Haskell programming language, though.

### Downloading the code

Download the code from repository `load-balancing-model`.

### Building Project

For the first time, you will have to set up the Stack project. In the next time, you can skip this step.

`$ stack setup`

In the beginning and after each change of the corresponding Haskell code, you have to build a binary executable anew.

`$ stack build`

### Running Simulation

To run the simulation, type in the Terminal window:

`$ stack exec load-balancing-model`

After the application finishes, you should see the simulation results in your opening Web browser.
