# Bottlenecks

The _simpleSimulator_ function (in _2023 12 05 simpleSimulator.R_) intoduced earlier (https://github.com/Uyongo/fourStepsProcess) is used to explore the impact of shifting time from the resource-constrained step 3 in the simulation model to step 4, on one hand; and steps 1, 2, and 4, on the other. The simulation model differs slightly from the previously introduced one. Step 3 is only supported by 2 or 3 staff, respectively:

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/dbde01bb-2338-4ac0-a7bd-8c286782d159)

The _numberOfRepetitions_ function argument determines how many times a simulation run is repeated before calculating relevant metrics, incl. throughput and overall queue times. This argument was set to 1000 in the simulation runs below in an attempt to manage the large variation seen in outcomes. Unfortunately, even so, calculated metrics varied somewhat at repeated runs. The _numberOfRepetitions_ argument was not increased further, however, due to long computing times. Other default function arguments were discussed at https://github.com/Uyongo/fourStepsProcess. 

The algorithms in _bottleneckResultsPlotterRedUnequal.R_, _bottleneckResultsPlotterRedEqual.R_, _bottleneckResultsPlotterPurpleUnequal.R_, and _bottleneckResultsPlotterPurpleEqual.R_ compile the data of a different set of simulation runs each. In the 'Red' (see first and second algorithm) and 'Purple' scenarios (see third and fourth algorithm) the number of available staff at step 3 are two and three, respectively. In the 'Unequal' (see first and third algorithm) and 'Equal' scenarios (see second and fourth algorithm), time is shifted from step 3 to step 4 only; or to steps 1, 2, and 4, respectively.

Results:


