import bpy

from . import menu_util

selectTool = menu_util.sculpt_tool

class ZH_SCULPT_TOOL_PIE(bpy.types.Menu):
	bl_idname = 'ZHTOOLS_MT_ZhSculptToolPie'
	bl_label = ''

	def selectTool(self, layout, tool_name):
		operator = layout.operator('paint.brush_select')
		operator.sculpt_tool = tool_name

	def draw(self, context):
		layout = self.layout.menu_pie()

		selectTool(layout, 'CLAY_STRIPS', "F", 'BRUSH_CLAY_STRIPS')
		selectTool(layout, 'CREASE', "D", 'BRUSH_CREASE')
		selectTool(layout, 'SCRAPE', "A", 'BRUSH_SCRAPE')
		selectTool(layout, 'SNAKE_HOOK', 'S', 'BRUSH_SNAKE_HOOK')
		selectTool(layout, 'BLOB', 'Q', 'BRUSH_BLOB')
		selectTool(layout, 'FILL', 'W', 'BRUSH_FILL')
		selectTool(layout, 'THUMB', 'E', 'BRUSH_THUMB')
		selectTool(layout, 'INFLATE', 'R', 'BRUSH_INFLATE')