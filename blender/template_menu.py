import bpy

#filename = "d:\\temp\\d3\\test.py"
#exec(compile(open(filename).read(), filename, 'exec'))

ops = bpy.ops

class SelectToolPie(bpy.types.Menu):
    """Unselect all then change select tool"""
    bl_idname = "ZHTOOLS_MT_SelectToolPie"
    bl_label = "select"


    def draw(self, context):
        layout = self.layout.menu_pie()
        
        operator = layout.operator('view3d.select_circle')

className = SelectToolPie
def register():
    bpy.utils.register_class(className)
    wm = bpy.context.window_manager

    
    km = wm.keyconfigs.addon.keymaps.new(name="3D View", space_type="VIEW_3D")
    kmi = km.keymap_items.new('wm.call_menu_pie', 'U', 'CLICK')
    kmi.properties.name = className.bl_idname
    kmi.active = True


def unregister():
    bpy.utils.unregister_class(className)


if __name__ == "__main__":
    register()

    # test call
    #bpy.ops.zh_object.unselect_select()
