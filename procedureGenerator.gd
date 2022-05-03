extends Node2D

var tileGrass = preload("res://tilesScenes/grassTile.tscn")
var tileStone = preload("res://tilesScenes/stoneTile.tscn")
export var size = 10

func _ready():
	var tileGrid = generateNoice()
	drawing_tiles(tileGrid)
	var new_Tile = noise_conversion(tileGrid)
	for i in range(5):
		yield(get_tree().create_timer(1.0), "timeout")
		for child in get_children():
			remove_child(child)
		new_Tile = noise_conversion(new_Tile)
		drawing_tiles(new_Tile)
	
func drawing_tiles(tileGrid):
	for row in range(len(tileGrid)):
		for col in range(len(tileGrid[0])):
			var new_tile
			if not tileGrid[row][col]:
				continue
			else:
				new_tile = tileGrid[row][col]
			if row % 2 == 1:
				new_tile.position = Vector2(64 * col + 32 - 64, 16 * row - 16)
			else:
				new_tile.position = Vector2(64 * col - 64, 16 * row - 16)
			add_child(new_tile)
			
func generateNoice():
	var tileGrid = []
	var tiles = [tileGrass, tileStone]
	for row in range(size):
		tileGrid.append([])
		for col in range(size):
			randomize()
			var tile = tiles[int(rand_range(0, 2))]
			if row == 0 or row == size - 1 or col == 0 or col == size - 1:
				tileGrid[row].append(false)
				continue
			tileGrid[row].append(tile.instance())
	return tileGrid

func noise_conversion(tileGrid):
	var sourceTiles = tileGrid
	for row in range(1, len(sourceTiles) - 1):
		for col in range(1, len(sourceTiles[0]) - 1):
			var stoneCount = 0
			var grassCount = 0
			var tile = sourceTiles[row][col]
			
			for r in range(row - 1, row + 2):
				for c in range(col - 1, col + 2):
					if r == row and c == col:
						continue
					if not sourceTiles[r][c]:
						stoneCount += 1
						grassCount += 1
						continue
					if compareTile(sourceTiles[r][c].name):
						stoneCount += 1
					else:
						grassCount += 1
			if stoneCount >= 5:
				sourceTiles[row][col] = tileStone.instance()
			elif grassCount >= 5:
				sourceTiles[row][col] = tileGrass.instance()
	return sourceTiles

func compareTile(tileName):
	if tileName.find('@') == -1:
		return tileName == 'stone'
	var name = ''
	for i in range(1, 6):
		name += tileName[i]
	return name == 'stone'
