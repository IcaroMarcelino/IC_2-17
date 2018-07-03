import gym
import numpy as np
import random
import math
from time import sleep
import time
import csv
import sys
import os


def save_scores(best_scores, times, path, fname, nexec):
    output = open(path + fname + "_" + str(nexec) + ".csv", 'w')
    
    wr = csv.writer(output)
    for i in list(range(len(best_scores))):
        wr.writerow([i, best_scores[i], times[i]])

def simulate(nexec):
    ## Instantiating the learning related parameters
    learning_rate = get_learning_rate(0)
    explore_rate = get_explore_rate(0)
    discount_factor = 0.99  # since the world is unchanging

    num_streaks = 0

    scores = []
    times = []
    for episode in range(neps):
        print("\nEpisode = %d" % episode)

        saving = []

        # Reset the environment
        obv = env.reset()

        # the initial state
        state_0 = state_to_bucket(obv)
        t = 0
        init = time.time()

        scr = 0
        for t in range(steps_lim):
            if SHOW:
                env.render()

            # Select an action
            action = select_action(state_0, explore_rate)

            # Execute the action
            obv, reward, done, _ = env.step(action)
            scr += reward

            if episode >= (neps - 10):
                saving.append(obv)

            # Observe the result
            state = state_to_bucket(obv)

            # Update the Q based on the result
            best_q = np.amax(q_table[state])
            q_table[state_0 + (action,)] += learning_rate*(reward + discount_factor*(best_q) - q_table[state_0 + (action,)])

            # Setting up for the next iteration
            state_0 = state

            # Print data
            if (verb):
                print("t = %d" % t)
                print("Action: %d" % action)
                print("State: %s" % str(state))
                print("Obv: %s" % str(obv))
                print("Reward: %f" % reward)
                print("Best Q: %f" % best_q)
                print("Explore rate: %f" % explore_rate)
                print("Learning rate: %f" % learning_rate)
                print("Streaks: %d" % num_streaks)

                print("")



            if done:
               print("Episode %d finished after %f time steps" % (episode, t))
               if (t >= max_steps):
                   num_streaks += 1
               else:
                   num_streaks = 0
               break

            #sleep(0.25)
        
        if episode >= (neps - 10):

            output = open("QL_GAMES/Game_" + fname + "_" + str(nexec) + "_"  + str(neps - episode) + ".csv", 'w')
        

            wr = csv.writer(output)
            for k in list(range(len(saving))):
                wr.writerow([k, saving[k][0], saving[k][1], saving[k][2], saving[k][3]])

        
        end = time.time()
        scores.append(scr)
        times.append(end-init)


        # It's considered done when it's solved over 120 times consecutively
        if num_streaks > scr_rqmnt:
            break

        # Update parameters
        explore_rate = get_explore_rate(episode)
        learning_rate = get_learning_rate(episode)

    save_scores(scores, times, "Scores/SCR_", fname, nexec)

def select_action(state, explore_rate):
    # Select a random action
    if random.random() < explore_rate:
        action = env.action_space.sample()
    # Select the action with the highest q
    else:
        action = np.argmax(q_table[state])
    return action

def get_explore_rate(t):
    return max(ER, min(1, 1.0 - math.log10((t+1)/25)))

def get_learning_rate(t):
    return max(LR, min(0.5, 1.0 - math.log10((t+1)/25)))

def state_to_bucket(state):
    bucket_indice = []
    for i in range(len(state)):
        if state[i] <= STATE_BOUNDS[i][0]:
            bucket_index = 0
        elif state[i] >= STATE_BOUNDS[i][1]:
            bucket_index = NUM_BUCKETS[i] - 1
        else:
            # Mapping the state bounds to the bucket array
            bound_width = STATE_BOUNDS[i][1] - STATE_BOUNDS[i][0]
            offset = (NUM_BUCKETS[i]-1)*STATE_BOUNDS[i][0]/bound_width
            scaling = (NUM_BUCKETS[i]-1)/bound_width
            bucket_index = int(round(scaling*state[i] - offset))
        bucket_indice.append(bucket_index)
    return tuple(bucket_indice)

'''
    Environment definition
'''
env = gym.make("CartPole-v0")
env.reset()
neps = 400
steps_lim = 1000
scr_rqmnt = 50
max_steps = 500

NUM_BUCKETS = (1, 1, 6, 3)      # (x, x', theta, theta')
NUM_ACTIONS = env.action_space.n# (left, right)
# Bounds for each discrete state
STATE_BOUNDS = list(zip(env.observation_space.low, env.observation_space.high))
STATE_BOUNDS[1] = [-0.5, 0.5]
STATE_BOUNDS[3] = [-math.radians(50), math.radians(50)]
# Index of the action
ACTION_INDEX = len(NUM_BUCKETS)

## Creating a Q-Table for each state-action pair
q_table = np.zeros(NUM_BUCKETS + (NUM_ACTIONS,))


'''
    Default parameters
'''
ER = 0.01
LR = 0.1
verb = False
fname = 'Default_Try'
SHOW = True

'''
    User's parameters (If exists)
'''
for i in range(len(sys.argv)-1):  
    if (sys.argv[i] == '-epoch'):
        epoch = int(sys.argv[i+1])

    elif(sys.argv[i] == '-LR'):
        LR = float(sys.argv[i+1]) 

    elif(sys.argv[i] == '-ER'):
        ER = float(sys.argv[i+1]) 

    elif(sys.argv[i] == '-SHOW'):
        SHOW = int(sys.argv[i+1])    

    elif(sys.argv[i] == '-v'):
        verb = int(sys.argv[i+1])

    elif(sys.argv[i] == '-filename'):
        fname = sys.argv[i+1]                                           


simulate(1)