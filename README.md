# Bottlenecks

The _simpleSimulator_ function (in _2023 12 05 simpleSimulator.R_) intoduced earlier (https://github.com/Uyongo/fourStepsProcess) is used to explore the impact of shifting time from the resource-constrained step 3 in the simulation model to step 4, on one hand; and steps 1, 2, and 4, on the other. The simulation model differs slightly from the previously introduced one. Step 3 is only supported by 2 or 3 staff, respectively:

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/dbde01bb-2338-4ac0-a7bd-8c286782d159)

The _numberOfRepetitions_ function argument determines how many times a simulation run is repeated before calculating relevant metrics, incl. throughput and overall queue times. This argument was set to 1000 in the simulation runs below in an attempt to manage the large variation seen in outcomes. Unfortunately, even so, calculated metrics varied somewhat at repeated runs. The _numberOfRepetitions_ argument was not increased further, however, due to long computing times. Other default function arguments were discussed at https://github.com/Uyongo/fourStepsProcess. 

The algorithms in _bottleneckResultsPlotterRedUnequal.R_, _bottleneckResultsPlotterRedEqual.R_, _bottleneckResultsPlotterPurpleUnequal.R_, and _bottleneckResultsPlotterPurpleEqual.R_ gather the data of a different set of simulation runs each. In the 'Red' (see first and second algorithm) and 'Purple' scenarios (see third and fourth algorithm) the number of available staff at step 3 are two and three, respectively. In the 'Unequal' (see first and third algorithm) and 'Equal' scenarios (see second and fourth algorithm), time is shifted from step 3 to step 4 only; or to steps 1, 2, and 4, respectively.

Due to the large variation mentioned above, polynomial functions were fitted to the data-points obtained by the multiple simulation runs. These functions were used to determine local minima.

Results:
In the _Red Unequal_ scenarios, a local minimum of throughput times showed at a duration of step 4 of about 14 min. Compared to the initial set of parameters (average duration of steps 3 and 4 at 10 min. each), average throughput times were reduced from 274 min. to 154 min. (i.e. by 44%).

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/b9058b2a-2ef8-4be8-9f06-e974e9e83245)

In the _Purple Unequal_ scenarios, a local minimum was reached at 11.5 min. (duration of step 4). Average throughput times were reduced from 135 min. to 116 min. (by 14%). 

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/b1c4a369-6297-482d-ab1f-8e96df5dec00)

In the _Red Equal_ scenarios, a local minimum was reached at 11.7 min. (duration of steps 1, 2, and 4). Average throughput times were reduced from 275 min. to 128 min. (i.e. by 53%). 

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/6da54fbc-f218-435c-9f6d-bfb5031c048e)

In the Purple Equal scenarios, a local minimum was reached at 10.8 min. Average throughput times were reduced from 134 min. to 109 min. (i.e. by 18%). 

  ![image](https://github.com/Uyongo/bottlenecks/assets/53852545/af654b57-af66-4c8f-8140-552f937ee886)



