import gym
import random
import numpy as np
import tflearn
import tensorflow as tf
from tflearn.layers.core import input_data, dropout, fully_connected
from tflearn.layers.estimator import regression
from statistics import median, mean
from collections import Counter
import csv
import time
import sys
import os

'''
    Description: Generates de training data with random games.

    Parameters:
        ran_games: Number of random simulations
        max_steps: Maximum or goal number of steps
        scr_rqmnt: Minimum number of steps to save the game data
'''
def create_data(ran_games, max_steps, scr_rqmnt):
    data = []
    scores = []
    accepted_scores = []

    for _ in range(ran_games):
        score = 0
        game_memory = []
        prev_observation = []
        
        for _ in range(max_steps):
            action = random.randrange(0,2)
            observation, reward, done, info = env.step(action)

            if len(prev_observation) > 0:
                game_memory.append([prev_observation, action])

            prev_observation = observation
            score+=reward
            
            if done:
                break

        if score >= scr_rqmnt:
            accepted_scores.append(score)
            for saved in game_memory:
                if saved[1] == 1:
                    output = [0,1]
                elif saved[1] == 0:
                    output = [1,0]
                    
                data.append([saved[0], output])

        env.reset()
        scores.append(score)
    return data

def dl_model(input_size):

    network = input_data(shape=[None, input_size, 1], name='input')

    network = fully_connected(network, 100, activation='tanh')
    network = fully_connected(network, 50, activation='tanh')
    network = fully_connected(network, 25, activation='linear')
    network = fully_connected(network, 2, activation='softmax')
    network = regression(network, optimizer='adam', learning_rate=LR, loss='categorical_crossentropy', name='targets')
    model = tflearn.DNN(network, tensorboard_dir='log')

    return model

def save_scores(best_scores, times, path, filename, nexec):
    output = open(path + filename + "_" + str(nexec) + ".csv", 'w')
    
    wr = csv.writer(output)
    for i in list(range(len(best_scores))):
        wr.writerow([i, best_scores[i], times[i]])

def train_model(data, model, epoch, fname, steps, verb, SHOW, nexec):
    X = np.array([i[0] for i in data]).reshape(-1,len(data[0][0]),1)
    y = [i[1] for i in data]

    if not model:
        model = dl_model(input_size = len(X[0]))
    
    times = []    
    scores = []
    for i in range(0, epoch):
        init = time.time()

        model.fit({'input': X}, {'targets': y}, n_epoch=1, snapshot_step=500, show_metric=verb, run_id='openai_learning')
    
        score = 0
        prev_obs = []
        env.reset()
        for _ in range(steps):
            if SHOW:
                env.render()

            if len(prev_obs)==0:
                action = random.randrange(0,2)
            else:
                action = np.argmax(model.predict(prev_obs.reshape(-1,len(prev_obs),1))[0])
               
            new_observation, reward, done, info = env.step(action)
            prev_obs = new_observation
            score += reward
            if done: 
                break
            
        end = time.time()

        scores.append(score)
        times.append(end-init)

    save_scores(scores, times, "Scores/SCR_", fname, nexec)
    return model

def test_model(model, tries, SHOW, fname, nexec):
    scores = []
    choices = []
    saving = []
    
    j = 0
    for each_game in range(tries):
        j+=1
        score = 0
        game_memory = []
        prev_obs = []
        env.reset()
        for _ in range(1000):
            if SHOW:
                env.render()

            if len(prev_obs)==0:
                action = random.randrange(0,2)
            else:
                action = np.argmax(model.predict(prev_obs.reshape(-1,len(prev_obs),1))[0])

            choices.append(action)
                    
            new_observation, reward, done, info = env.step(action)
            prev_obs = new_observation
            game_memory.append([new_observation, action])
            saving.append(new_observation)
            score+=reward
            if done: break

        scores.append(score)
        output = open("DL_GAMES/Game_" + fname + "_" + str(nexec) + "_"  + str(j) + ".csv", 'w')
        
        wr = csv.writer(output)
        for k in list(range(len(saving))):
            wr.writerow([k, saving[k][0], saving[k][1], saving[k][2], saving[k][3]])

    return

'''
    Environment definition
'''
tf.reset_default_graph()
env = gym.make("CartPole-v0")
env.reset()

max_steps = 500
scr_rqmnt = 50
ran_games = 10000
''''''''''''''''''''''''''''''

'''
    Default parameters
'''
LR = 1e-3
epoch = 5
SHOW  = True
verb  = True
fname = "Default_Try"
''''''''''''''''''''''''''''''

'''
    User's parameters (If exists)
'''
for i in range(len(sys.argv)-1):  
    if (sys.argv[i] == '-epoch'):
        epoch = int(sys.argv[i+1])

    elif(sys.argv[i] == '-LR'):
        LR = float(sys.argv[i+1]) 

    elif(sys.argv[i] == '-SHOW'):
        SHOW = int(sys.argv[i+1])    

    elif(sys.argv[i] == '-v'):
        verb = int(sys.argv[i+1])

    elif(sys.argv[i] == '-filename'):
        fname = sys.argv[i+1]                                          

data = create_data( ran_games = ran_games,
                    max_steps = max_steps,
                    scr_rqmnt = scr_rqmnt)

model = False
model = train_model(data  = data, 
                    model = model, 
                    epoch = epoch, 
                    fname = fname, 
                    steps = max_steps,
                    verb  = verb, 
                    SHOW  = SHOW, 
                    nexec = 1)

test_model( model = model,
            tries = 5,
            SHOW  = SHOW,
            fname = fname,
            nexec = 1)