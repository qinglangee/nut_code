import bpy


def main(context):
    print('test operator')


class SimpleOperator(bpy.types.Operator):
    """Tooltip"""
    bl_idname = "object.simple_operator"
    bl_label = "Simple Object Operator"
    bl_options = {'REGISTER', 'UNDO'}

    @classmethod
    def poll(cls, context):
        return context.active_object is not None

    def execute(self, context):
        main(context)
        return {'FINISHED'}

className = SimpleOperator

def register():
    bpy.utils.register_class(className)
    wm = bpy.context.window_manager

    km = wm.keyconfigs.addon.keymaps.new('Object Mode')
    kmi = km.keymap_items.new(className.bl_idname, 'U', 'CLICK')
    #kmi.properties.name = ''
    kmi.active = True


def unregister():
    bpy.utils.unregister_class(className)


if __name__ == "__main__":
    register()

    # test call
    #bpy.ops.object.simple_operator()
