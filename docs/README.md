## Comparison Study Between Deep Learning and Genetic Programming Application in Cart Pole Balancing Problem

### How to run
Uses python 3

#### Deep Learning (DL) model
Default parameters:
- LR (learning rate): 0.001
- epoch (number of epochs): 10
- SHOW (show simulation): True
- v (verbose): True
- filename (string to be added to the output files names): Default_Try

>> python3 dl_pole.py

is equivalent to

>> python3 dl_pole.py -LR 0.001 -epoch 10 -SHOW 1 -v 1 -filename Default_Try

#### Genetic Programming (GP) model
Default parameters:
- ngen (number of generations): 50
- npop (number of individuals): 25
- mutpb (mutation rate): 0.15
- cxpb (crossover rate): 0.85
- maxdeep (maximum tree depth): 10
- SHOW (show simulation): True
- v (verbose): True
- filename (string to be added to the output files names): Default_Try

>> python3 gp_pole.py

is equivalent to

>> python3 gp_pole.py -ngen 50 -npop 25 -mutpb .15 - cxpb .85 - maxdeep 10 -SHOW 1 -v 1 -filename Default_Try

#### Q-Learning (QL) (Model-free)
Default parameters:
- LR (learning rate): 0.1
- ER (explorer rate): 0.01
- neps (number of episodes): 250
- SHOW (show simulation): True
- v (verbose): True
- filename (string to be added to the output files names): Default_Try

>> python3 ql_pole.py

is equivalent to

>> python3 ql_pole.py -LR 0.1 -ER 0.01 -neps 250 -SHOW 1 -v 1 -filename Default_Try

