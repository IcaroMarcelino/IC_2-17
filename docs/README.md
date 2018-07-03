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
>> python3 gp_pole.py


#### Q-Learning (QL) (Model-free)
>> python3 ql_pole.py

