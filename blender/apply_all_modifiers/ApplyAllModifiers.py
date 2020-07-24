
# 一个简陋的小插件，把选中物体的修改器全部应用

bl_info = {
    "name": "Apply all modifiers",
    "blender": (2, 80, 0),
    "category": "Object",
}

import bpy


class ObjectMoveX(bpy.types.Operator):
    """My Object Modifiers Apply"""      # Use this as a tooltip for menu items and buttons.
    bl_idname = "object.modifiers_all_apply"        # Unique identifier for buttons and menu items to reference.
    bl_label = "Apply All Modifiers"         # Display name in the interface.
    bl_options = {'REGISTER', 'UNDO'}  # Enable undo for the operator.

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
    
class hiadd(bpy.types.Panel):  
    bl_idname = 'hiadd'     
    bl_space_type = 'VIEW_3D'  
    bl_region_type = 'TOOLS'   
    bl_label = 'Hi Addons'   
 
    def draw(self,context):  
        layout = self.layout
        self.layout.label(text='你好插件！ ')
        layout.operator('object.modifiers_all_apply')
        
def register():
    bpy.utils.register_class(ObjectMoveX)
    bpy.utils.register_class(hiadd)


def unregister():
    bpy.utils.unregister_class(ObjectMoveX)
    bpy.utils.unregister_class(hiadd)

if __name__ == "__main__":
    register()