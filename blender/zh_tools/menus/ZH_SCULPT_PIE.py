import bpy
from .. operators.object_opt import ApplyAllModifiers

class ZH_SCULPT_TOOL_PIE(bpy.types.Menu):
	bl_idname = 'ZHTOOLS_MT_ZhSculptToolPie'
	bl_label = ''

	def draw(self, context):
		layout = self.layout.menu_pie()

		layout.operator('machin3.align')