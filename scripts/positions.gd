extends Node

enum definedPositions {EMPTY, TOP_LEFT, TOP_CENTER, TOP_RIGHT, 
						MIDDLE_LEFT, MIDDLE_CENTER, MIDDLE_RIGHT,
						BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT}
const viewportSize = Vector2(512, 384)
const verticalOffset: int = 30
const horizontalOffset: int = 40

func getCoordinates(definedPosition: definedPositions):
	var coordinates: Vector2
	match definedPosition:
		definedPositions.TOP_LEFT:
			coordinates = Vector2(horizontalOffset, verticalOffset)
		definedPositions.TOP_CENTER:
			coordinates = Vector2(viewportSize.x/2, verticalOffset)
		definedPositions.TOP_RIGHT:
			coordinates = Vector2(viewportSize.x - horizontalOffset, verticalOffset)
		definedPositions.MIDDLE_LEFT:
			coordinates = Vector2(horizontalOffset, viewportSize.y/2)
		definedPositions.MIDDLE_CENTER:
			coordinates = viewportSize/2
		definedPositions.MIDDLE_RIGHT:
			coordinates = Vector2(viewportSize.x - horizontalOffset, viewportSize.y/2)
		definedPositions.BOTTOM_LEFT:
			coordinates = Vector2(horizontalOffset, viewportSize.y - verticalOffset)
		definedPositions.BOTTOM_CENTER:
			coordinates = Vector2(viewportSize.x/2, viewportSize.y - verticalOffset)
		definedPositions.BOTTOM_RIGHT:
			coordinates = viewportSize - Vector2(horizontalOffset, verticalOffset)
	
	return coordinates
