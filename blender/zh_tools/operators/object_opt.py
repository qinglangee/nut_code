# <pep8 compliant>
import bpy


class ApplyAllModifiers(bpy.types.Operator):
	"""独立关联物体，应用所有的修改器"""
	bl_idname = 'zh_object.apply_all_modifiers'
	bl_label = 'apply modifier'
	bl_options = {'REGISTER', 'UNDO'}

	def execute(self, context):        # execute() is called when running the operator.

		C = context
		bpy.ops.object.make_single_user(type='SELECTED_OBJECTS', object=True, obdata=True, material=False, animation=False)

		for c in C.selected_objects:
			C.view_layer.objects.active = c 
			modifiers = c.modifiers
			for m in modifiers:
				print(m.name)
				bpy.ops.object.modifier_apply(apply_as='DATA',modifier=m.name)

		return {'FINISHED'}            # Lets Blender know the operator finished successfully.
    