extends Node

enum definedPositions {EMPTY, TOP_LEFT, TOP_CENTER, TOP_RIGHT, 
						MIDDLE_LEFT, MIDDLE_CENTER, MIDDLE_RIGHT,
						BOTTOM_LEFT, BOTTOM_CENTER, BOTTOM_RIGHT,
						OVERTOP_LEFT, OVERTOP_CENTER, OVERTOP_RIGHT,
						OVERBOTTOM_LEFT, OVERBOTTOM_CENTER, OVERBOTTOM_RIGHT,
						OVERLEFT_TOP, OVERLEFT_MIDDLE, OVERLEFT_BOTTOM,
						OVERRIGHT_TOP, OVERRIGHT_MIDDLE, OVERRIHT_BOTTOM}
						
const viewportSize = Vector2(1920, 1080)
const verticalOffset: int = 150
const horizontalOffset: int = 200

const overVerticalMargin: int = 60
const overHorizontalMargin: int = 80

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
		definedPositions.OVERTOP_LEFT:
			coordinates = Vector2(horizontalOffset, -overVerticalMargin)
		definedPositions.OVERTOP_CENTER:
			coordinates = Vector2(viewportSize.x/2, -overVerticalMargin)
		definedPositions.OVERTOP_RIGHT:
			coordinates = Vector2(viewportSize.x - horizontalOffset, -overVerticalMargin)
		definedPositions.OVERBOTTOM_LEFT:
			coordinates = Vector2(horizontalOffset, viewportSize.y + overVerticalMargin)
		definedPositions.OVERBOTTOM_CENTER:
			coordinates = Vector2(viewportSize.x/2, viewportSize.y + overVerticalMargin)
		definedPositions.OVERBOTTOM_RIGHT:
			coordinates = Vector2(viewportSize.x - horizontalOffset, viewportSize.y + overVerticalMargin)
		definedPositions.OVERLEFT_TOP:
			coordinates = Vector2(-overHorizontalMargin, verticalOffset)
		definedPositions.OVERLEFT_MIDDLE:
			coordinates = Vector2(-overHorizontalMargin, viewportSize.y/2)
		definedPositions.OVERLEFT_BOTTOM:
			coordinates = Vector2(-overHorizontalMargin, viewportSize.y - verticalOffset)
		definedPositions.OVERRIGHT_TOP:
			coordinates = Vector2(viewportSize.x + overHorizontalMargin, verticalOffset)
		definedPositions.OVERRIGHT_MIDDLE:
			coordinates = Vector2(viewportSize.x + overHorizontalMargin, viewportSize.y/2)
		definedPositions.OVERRIHT_BOTTOM:
			coordinates = Vector2(viewportSize.x + overHorizontalMargin, viewportSize.y - verticalOffset)
		
	
	return coordinates
