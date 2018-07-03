import gym
import random
import numpy as np
import math

import operator
from deap import algorithms
from deap import base
from deap import creator
from deap import tools
from deap import gp
from deap.gp import PrimitiveSetTyped

#import pygraphviz as pgv
#from sympy import simplify, expand

from statistics import median, mean
from collections import Counter
import csv
import time

# Display the pendulum?
SHOW = False 

env = gym.make("CartPole-v0")
env.reset()
goal_steps = 200
score_requirement = 50
initial_games = 10000

def initial_population():
	# [OBS, MOVES]
	training_data = []
	# all scores:
	scores = []
	# just the scores that met our threshold:
	accepted_scores = []
	# iterate through however many games we want:
	for _ in range(initial_games):
		score = 0
		# moves specifically from this environment:
		game_memory = []
		# previous observation that we saw
		prev_observation = []
		# for each frame in 200
		for _ in range(goal_steps):
			# choose random action (0 or 1)
			action = random.randrange(0,2)
			# do it!
			observation, reward, done, info = env.step(action)
			# print(observation)
			# print(reward)
			# print(done)
			# print(info)
			# print(">>>>")
			# input()
			
			# notice that the observation is returned FROM the action
			# so we'll store the previous observation here, pairing
			# the prev observation to the action we'll take.
			if len(prev_observation) > 0 :
				game_memory.append([prev_observation, action])
			prev_observation = observation
			score+=reward
			if done: break

		# IF our score is higher than our threshold, we'd like to save
		# every move we made
		# NOTE the reinforcement methodology here. 
		# all we're doing is reinforcing the score, we're not trying 
		# to influence the machine in any way as to HOW that score is 
		# reached.
		if score >= score_requirement:
			accepted_scores.append(score)
			for data in game_memory:
				# convert to one-hot (this is the output layer for our neural network)
				if data[1] == 1:
					output = [0,1]
				elif data[1] == 0:
					output = [1,0]
					
				# saving our training data
				training_data.append([data[0], output])

		# reset env to play again
		env.reset()
		# save overall scores
		scores.append(score)
	
	# just in case you wanted to reference later
	# training_data_save = np.array(training_data)
	# np.save('saved.npy',training_data_save)
	
	# some stats here, to further illustrate the neural network magic!
	print('Average accepted score:',mean(accepted_scores))
	print('Median score for accepted scores:',median(accepted_scores))
	print(Counter(accepted_scores))
	
	return training_data

def save_log(log, path, filename, nexec):
	log_file = open(path + filename + "_" + str(nexec) + ".csv", 'w')
	log_file.write(str(log))
	log_file.close()

def save_individual(individual, pset, path, filename, nexec):
	function = gp.compile(individual, pset)
	exp_file = open(path + filename + "_" + str(nexec) + ".txt", 'w')
	exp_file.write(str(individual))
	exp_file.close()

def save_fitness(best_fitnesses, times, path, filename, nexec):
	output = open(path + filename + "_" + str(nexec) + ".txt", 'w')
	
	wr = csv.writer(output)
	for i in list(range(len(best_fitnesses))):
		wr.writerow([i, best_fitnesses[i], times[i]])

def train_model(training_data, npop, ngen, mutpb, cxpb, tam_max, nexec, verbose, filename):
	def if_then_else(input, output1, output2):
		return output1 if input else output2

	def op_and(a, b):
		return a and b

	def op_or(a, b):
		return a or b

	def op_not(a):
		return not a

	def greater(a, b):
		if(abs(a) > abs(b)):
			return True
		return False

	def less(a, b):
		if(abs(a) < abs(b)):
			return True
		return False

	def move_to_left(a):
		if a:
			return 0
		return 1

	def move_to_right(a):
		if a:
			return 1
		return 0

	def p_div(left, right):
		try:
			return left / right
		except ZeroDivisionError:
			return 1

	pset = PrimitiveSetTyped("MAIN", [float, float, float, float], int)
	# pset.addPrimitive(op_and, [bool, bool], bool)
	# pset.addPrimitive(if_then_else, [bool, float, float], float)
	# pset.addPrimitive(op_or, [bool, bool], bool)
	# pset.addPrimitive(op_not, [bool], bool)
	pset.addPrimitive(move_to_right, [bool], int)
	pset.addPrimitive(move_to_left, [bool], int)
	pset.addPrimitive(operator.neg, [float], float)
	pset.addPrimitive(operator.add, [float, float], float)
	pset.addPrimitive(operator.sub, [float, float], float)
	pset.addPrimitive(operator.mul, [float, float], float)
	pset.addPrimitive(p_div, [float, float], float)
	# pset.addPrimitive(operator.xor, [bool, bool], bool)
	# pset.addPrimitive(math.sin, [float], float)
	# pset.addPrimitive(math.cos, [float], float)
	pset.addPrimitive(greater, [float, float], bool)
	pset.addPrimitive(less, [float, float], bool)
	# pset.addTerminal(True, bool)
	# pset.addTerminal(False, bool)
	# pset.addEphemeralConstant(lambda: float(random.randint(-1,1)), float)
	pset.addTerminal(1.00, float)
	pset.addTerminal(-1.00, float)
	pset.addTerminal(10.0, float)
	pset.addTerminal(-10.0, float)
	pset.addTerminal(2.0, float)
	pset.addTerminal(-2.0, float)

	pset.renameArguments(ARG0='x')
	pset.renameArguments(ARG1='x_')
	pset.renameArguments(ARG2='theta')
	pset.renameArguments(ARG3='theta_')

	creator.create("FitnessMax", base.Fitness, weights=(1.0,))
	creator.create("Individual", gp.PrimitiveTree, fitness=creator.FitnessMax)
	toolbox = base.Toolbox()
	toolbox.register("expr", gp.genHalfAndHalf, pset=pset, min_=5, max_=8)
	toolbox.register("individual", tools.initIterate, creator.Individual, toolbox.expr)
	toolbox.register("population", tools.initRepeat, list, toolbox.individual)
	toolbox.register("compile", gp.compile, pset=pset)

	def f_fitness(individual, training_data):
		score = 0
		f_approx = toolbox.compile(expr=individual)

		# action = random.randrange(0,2)
		# observation, reward, done, info = env.step(action)
		for i in range(len(training_data)):
			observation = list(training_data[i][0])
			# choose random action (0 or 1)
			action = f_approx(*observation)
			# do it!
			# observation, reward, done, info = list(training_data[i][0])

			if action == training_data[i][1][1]:
				score += 1

		return score,

	toolbox.register("evaluate", f_fitness, training_data = training_data)
	# toolbox.register("select", tools.selRoulette)
	toolbox.register("select", tools.selTournament, tournsize=3)
	toolbox.register("mate", gp.cxOnePoint)
	# toolbox.register("mate", gp.cxOnePointLeafBiased, termpb = .05)
	toolbox.register("expr_mut", gp.genFull, min_=3, max_=6)
	toolbox.register("mutate", gp.mutUniform, expr=toolbox.expr_mut, pset=pset)

	# toolbox.register("mutate", gp.mutShrink)
	# toolbox.register("mutate", gp.mutInsert, pset=pset)

	toolbox.decorate("mate", gp.staticLimit(key=operator.attrgetter("height"), max_value = 20))
	toolbox.decorate("mutate", gp.staticLimit(key=operator.attrgetter("height"), max_value = 6))

	start = time.time()
	random.seed(318)
	
	stats_fit = tools.Statistics(lambda ind: ind.fitness.values)
	stats_size = tools.Statistics(lambda ind: ind.height)
	mstats = tools.MultiStatistics(fitness=stats_fit, size=stats_size)
	mstats.register("avg", np.mean)
	mstats.register("std", np.std)
	mstats.register("min", np.min)
	mstats.register("max", np.max)

	pop = toolbox.population(npop)
	
	fitnesses = list(map(toolbox.evaluate, pop))
	for ind, fit in zip(pop, fitnesses):
		ind.fitness.values = fit

	log = tools.Logbook()
	print(">> Cart Pole Balancing - GP: ")

	pop = toolbox.select(pop, len(pop))
	scores = []
	times = []
	for g in range(NGEN):
		env.reset()

		bst = tools.selBest(pop, 1)
		f_approx = toolbox.compile(expr=bst[0])

		game_memory = []
		prev_obs = []
		scr = 0
		for _ in range(goal_steps):
			if SHOW:
				env.render()

			if len(prev_obs)==0:
				action = random.randrange(0,2)
			else:
				action = f_approx(*list(prev_obs))

			
			new_observation, reward, done, info = env.step(action)
			prev_obs = new_observation
			game_memory.append([new_observation, action])
			scr += reward
			if done: break


		geninit = time.time()

		offspring = algorithms.varAnd(pop, toolbox, cxpb, mutpb)

		fitnesses = list(map(toolbox.evaluate, offspring))
		for ind, fit in zip(offspring, fitnesses):
			ind.fitness.values = fit

		pop[:] = tools.selBest(pop, 1) + offspring 

		log.record(gen = g, time = time.time() - geninit,**mstats.compile(pop))
		scores.append(scr)
		times.append(time.time()-geninit)

		if verbose:
			print(log.stream)


	end = time.time()

	print(">> Fim da execucao (" + str(end - start) + " segundos)\n")

	hof = tools.selBest(pop, 1)
	f_approx = toolbox.compile(expr=hof[0])
	print("\n>>>>>\n" + str(gp.PrimitiveTree(hof[0])) + "\n>>>>>\n")

	save_fitness(scores, times, "Log_Fitness/FIT_", filename, nexec)
	save_individual(hof[0], pset, "Best_Expressions/EXPR_", filename, nexec)
	save_log(log, "Log_Exec/LOG_", filename, nexec)

	return f_approx

NPOP = 500
NGEN = 300
MUTPB = .10
CXPB = .85
TAM_MAX = 20
filename = "GP_20"
verbose = False

for i in range(0,5):
	training_data = initial_population()
	model = train_model(training_data, NPOP, NGEN, MUTPB, CXPB, TAM_MAX, i, verbose, filename)

	scores = []
	choices = []
	saving = []
	j = 0
	for each_game in range(10):
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
				action = model(*list(prev_obs))

			choices.append(action)
					
			new_observation, reward, done, info = env.step(action)
			prev_obs = new_observation
			game_memory.append([new_observation, action])
			saving.append(new_observation)
			score += reward
			if done: break

		scores.append(score)

		output = open("GP_GAMES/Game_" + filename + "_" + str(i) + "_"  + str(j) + ".csv", 'w')
		
		wr = csv.writer(output)
		for k in list(range(len(saving))):
			wr.writerow([k, saving[k][0], saving[k][1], saving[k][2], saving[k][3]])


print('Average Score:',sum(scores)/len(scores))
print('choice 1:{}  choice 0:{}'.format(choices.count(1)/len(choices),choices.count(0)/len(choices)))
print(score_requirement)
