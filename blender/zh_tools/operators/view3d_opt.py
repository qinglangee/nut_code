import bpy

ops = bpy.ops


class VIEW3D_OT_UnselectSelect(bpy.types.Operator):
    """Unselect all then change select tool"""
    bl_idname = "zh_object.unselect_select"
    bl_label = "Circle"
    bl_options = {'REGISTER', 'UNDO'}


    def execute(self, context):
        if ops.mesh.select_all.poll():
            ops.mesh.select_all(action='DESELECT')
        elif ops.object.select_all.poll():
            ops.object.select_all(action='DESELECT')
            
        ops.view3d.select_circle('INVOKE_DEFAULT')
        
        return {'FINISHED'}
