import bpy

class SelectToolPie(bpy.types.Menu):
    """Unselect all then change select tool"""
    bl_idname = "ZHTOOLS_MT_SelectToolPie"
    bl_label = "select"


    def draw(self, context):
        layout = self.layout.menu_pie()
        
        layout.operator('view3d.select_circle')
        layout.operator('view3d.select_box')
        layout.operator('view3d.select_lasso')