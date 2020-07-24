
def sculpt_tool(layout, tool_name, text = "", icon = 'NONE'):
	operator = layout.operator('paint.brush_select', text = text, icon = icon)
	operator.sculpt_tool = tool_name
