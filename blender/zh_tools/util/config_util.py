
keymap_conf = [
	{
		'km':{'name':'Object Mode', 
			'space_type11':"EMPTY"},
		'item':{'op':'wm.call_menu_pie',
			'key':'W', 'type':'CLICK_DRAG',
			'ctrl':False, 'shift':False, 'alt':False, 'oskey':False
		},
		'prop':{'name':'ZHTOOLS_MT_ZhObjectToolPie'}
	},
	{
		'km':{'name':'Sculpt', 
			'space_type11':"EMPTY"},
		'item':{'op':'wm.call_menu_pie',
			'key':'W', 'type':'CLICK',
			'ctrl':False, 'shift':False, 'alt':False, 'oskey':False
		},
		'prop':{'name':'ZHTOOLS_MT_ZhSculptToolPie'}
	},
	{
		'km':{'name':"3D View", 
			'space_type11':"VIEW_3D"},
		'item':{'op':'wm.call_menu_pie',
			'key':'C', 'type':'CLICK_DRAG',
			'ctrl':False, 'shift':False, 'alt':False, 'oskey':False
		},
		'prop':{'name':'ZHTOOLS_MT_SelectToolPie'}
	},
	{
		'km':{'name':"3D View", 
			'space_type11':"VIEW_3D"},
		'item':{'op':'zh_object.unselect_select',
			'key':'C', 'type':'CLICK',
			'ctrl':False, 'shift':False, 'alt':False, 'oskey':False
		},
	},
]