extends GridContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var Button = preload("res://Scene/Button_Prefab.tscn")

var width=20

var tab

func popButton(id):
	var button=Button.instance()
	button.id=id
	add_child(button)

func getTab(x, y):
	if x<0 or x>width-1 or y<0 or y>width-1:
		return -1
	return tab[x+y*width]
		
func checkTab(x, y):
	if getTab(x, y) == 9:
		return 1
	return 0

func checkTabNSee(x, y):
	var z = getTab(x, y)

	if z>-1:
		get_child(x+y*width).see(z)

# Called when the node enters the scene tree for the first time.
func _ready():
	columns=width
	
	tab = PoolByteArray()
	
	var ww=width*width
	
	var ww4=width*width/4
	
	for i in range(ww):
		popButton(i)
		
		if i < ww4:
			tab.append(9)
		else:
			tab.append(0)
	
	randomize()
	
	#melange
	for i in range(ww-1, 1, -1):
		var j = Helper.rand_between(0, i)
		var k = tab[i]
		tab[i] = tab[j]
		tab[j] = k
	
	for i in range(ww):
		if tab[i] == 9:
			continue
		else:
			var x = i%width
			var y = i/width
			
			tab[i] = checkTab(x, y+1) + checkTab(x, y-1) + checkTab(x+1,y) + checkTab(x+1, y+1) + checkTab(x+1, y-1) + checkTab(x-1, y) + checkTab(x-1, y+1) + checkTab(x-1, y-1)
	
	pass # Replace with function body.
	
func see(i):
	var x = i%width
	var y = i/width
	
	checkTabNSee(x, y+1)
	checkTabNSee(x, y-1)
	checkTabNSee(x+1,y)
	checkTabNSee(x-1, y)
	checkTabNSee(x+1, y+1)
	checkTabNSee(x+1, y-1)
	checkTabNSee(x-1, y+1)
	checkTabNSee(x-1, y-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):	
#	pass
