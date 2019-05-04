extends Node

static func rand_between(a, b):
	a=int(a)
	b=int(b)

	if a==b:
		return a

	return randi()%(b+1-a)+a