import bpy
from .. operators.object_opt import ApplyAllModifiers

class ZH_OBJECT_TOOL_PIE(bpy.types.Menu):
	bl_idname = 'ZHTOOLS_MT_ZhObjectToolPie'
	bl_label = ''

	def draw(self, context):
		layout = self.layout.menu_pie()

		layout.operator(ApplyAllModifiers.bl_idname)