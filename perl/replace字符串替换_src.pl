* { word-break: break-all; }

body { margin: 0; font: 12px "Trebuchet MS", "Lucida Console", "Lucida Sans", sans-serif; color:#0; text-align: center; background: #F7F6F0; }

label { cursor: pointer; }

.wrap { margin: 10px auto; background: #E6E9E0; text-align: left; padding: 2px; width: 778px; w\idth: 774px; }

#header { background: #657278 url(../images/user_logo.jpg); text-align: right; color: #918D78;}
		#header a { color: #003660; text-decoration: none; }
			#header a:hover { color: #E6E9E0; background-color: #8A9AAA; }
		#headertitle { padding: 20px 0 20px 20px; text-align: left; }
			#headertitle p { margin: 0; }
			h1 { font-size: 16px; margin: 0; }
				#header h1 a { color: #333; }

	#topmenu { margin: 10px 10px 0 auto; padding: 0; list-style: none; color: #8B90A2; }
		#topmenu li { display: inline; padding: 0 0 0 4px; }
	#actions { margin: 30px 10px 0 auto; padding: 0; list-style: none; }
		#actions li {display: inline; padding: 0 0 0 4px; border-left: 4px solid #8A9AAA; margin-left: 10px; }
			#actions a { color: #918D78; }
				#actions a:hover { color: #E6E9E0; }

#menu { background: #E4E4E4 url(../images/menu_bg.gif) repeat-x top; }
	#menu ul { margin: 0; padding: 0; list-style: none; }
		#menu li { float: left; line-height: 48px; background: url(../images/menu_bg.gif) no-repeat 100% -48px; padding-right: 12px; }
		#menu a { float: left; height: 48px; text-decoration: none; color: #333; padding-left: 10px; }
			#menu a:hover { color: #003660; background-color: transparent; }
			#menu li.current { background-position: 100% -144px; padding-right: 17px;  }
				#menu li.current a { background: url(../images/menu_bg.gif) no-repeat 0 -96px; padding-left: 15px; font-weight: bold; color: #E6E9E0; }
.popupmenu {background:#FFF url(bg_popupmenu.jpg) center bottom repeat-x; border:1px solid #DFDFDF; padding:10px 12px;text-align: left;overflow: hidden; height:auto !important;}
	.popupmenu p{line-height:24px;margin:0; white-space:nowrap;}
	.popupmenu a{height:auto !important; float:none !important;padding:0px !important;}

#footer { height: 40px; line-height: 40px; text-align: center; background: #657278; border-top: 1px solid #B1A682; }
	.copyright { font-size: 0.83em; margin: 0; font-family: Verdana, Arial, Helvetica, sans-serif; }
		.copyright strong { color: #ED1C24; text-transform: uppercase; }
		.copyright strong span { color: #0954A6; }
			.copyright em { font-style: normal; font-weight: bold; color: #96A800; }

h2 { margin: 0; font-size: 12px; }

#sidebar { width: 180px; vertical-align: top; padding-top: 10px; background: #8A9AA2; border-right: 1px solid #FFFFFB; }
	#sidebar div { margin: 0 8px 10px; padding: 5px; border: 1px solid; border-color: #FFF #FFFFFB #FFFFFB #E6E9E0; background: #CAD2CA; }
		#sidebar ul { margin: 0; padding: 0; list-style: none; line-height: 2em; }
			#sidebar li { padding: 0 5px; border-bottom: 1px solid #8A9AA2;}
			#sidebar li .current {color: #D89C2B; font-weight:bold; border-bottom: 3px solid #8A9AAA; }
				#sidebar a { text-decoration: none; color: #333; }
					#sidebar a:hover { color: #003660; }
	#sidebar div.light { background: #FCFFEF; }

#mainarea { vertical-align: top;  height: expression(this.height < 360 ? 360: true) }
	#mainarea a { color:#333; text-decoration: none; }
		#mainarea a:hover { color: #E6E9E0; background: #8A9AAA; }

#nav { line-height: 26px; padding: 0 10px; margin: 10px; background: #F7F6F0; color: #918D78; }
	#nav a { color: #918D78; }
		#nav a:hover { color: #003660; background: transparent; }
	#nav span { font-family: Arial, Helvetica, sans-serif; font-size: 9px; }

.notice { border: 1px solid #FFFFFA; background: #CAD2CA; padding: 5px; margin: 10px; color: #003660; line-height: 1.6em; }
	.notice h3 { margin: 3px 0; border-bottom: 1px solid #FFFFFA; font-size: 1.17em; }
	.notice ul { margin: 0; padding: 0; list-style: none; }
		/*\*/ * html .notice ul { *height: 1%; } /**/ .notice>ul { overflow: hidden; }
			.notice li { float: left; width: 49.9%; padding: 3px 0;}

.warning { border: 2px solid red; background: #E6E9E0; padding: 10px; margin: 10px; color: red; text-align: left; line-height: 1.6em; }

.block { margin: 0 10px 10px; }
	.block th { padding: 5px; vertical-align: top; padding-top: 7px; border-bottom: 1px solid #FFFFFB; font-weight: normal; }
		.block th .help { float: right; font-weight: normal; text-decoration: none; background: #6C6; color: #E6E9E0; padding: 0 0.2em; }
		.block th em { color: #003660; font-style: normal; }
	.block td { padding: 5px; border-bottom: 1px solid #FFFFFB; }
	.block p { margin: 0.3em 0; font-size: 12px; }
		.block td th, .block td td { border: none; }
	.block h3 { font-size: 1.17em; margin: 8px 0 0; line-height: 1.6em; border-bottom: 1px solid #FFFFFB; color: #003660; }

.tips { position: absolute; font-size: 12px; border: solid #C3CD95; border-width: 1px 1px 1px 3px; background: #F7FFD3; margin: 0; padding: 8px; width: 180px; display: none; }

form { margin: 0; padding: 0; }

input, textarea { font-family: Arial, Helvetica, sans-serif, "????"; font-size: 12px; background: #F9F9F9 url(../images/input_bg.gif) no-repeat; border:1px solid #A1A1A1; padding: 0.4em;}
		input:focus, textarea:focus, input.focus, textarea.focus { background-color: #E6E9E0; background-position: 0 -300px; border-color: #00B800; }
		input[type="radio"] { padding: 0; border: none; }

select { font-family: Arial, Helvetica, sans-serif, "????"; font-size: 12px;  padding: 2px; }
	.addoption { color: red; font-weight: bold; background: #FCFFEF; }

button { border-width: 1px; height: 2em; overflow: hidden; margin-left: 2px; padding: 0 5px; cursor: pointer; font-family: Arial, Helvetica, sans-serif; width: 0; overflow: visible; }
	*>button { width: auto; }
	* html button { line-height: 2em; }
	.submit { background: #8A9AAA; font-weight: bold; color: #E6E9E0; border: 1px solid; border-color: #FFD68B #B1A682 #B1A682 #FFD68B; }
	button.light { background: #FFFFFA; color: red; }
	button.tags { background: #E6E9E0; border: 1px solid #999; margin-right: 5px; }
	button.warningbtn { background: #657278; color: #808080; border: 1px solid; border-color: #FFF #A1A1A1 #A1A1A1 #E6E9E0; }
	button.relatekw{height:30px !important; line-height:10px; padding:6px; font-size:12px;}
	*html button.relatekw{height:26px !important; line-height:10px; padding:6px; font-size:12px;}

.avatar { border: 1px solid #FFFFFA; background: #FCFFEF; padding: 5px; margin-bottom: 5px; }


.time { font-size: 11px; text-align: center; }


.tabs { border-bottom: 1px solid #FFFFFB; padding-bottom: 27px; padding-left: 5px; margin: 0 10px; }
	.tabs a, .tabs span { float: left; padding: 0 5px; border: 1px solid #FFFFFB;  margin-right: 5px; text-decoration: none; height: 26px; line-height: 26px; background: #E6E9E0; }
		.tabs a.current, .tabs span.current { color: #003660 !important; font-weight: bold; cursor: default; border-bottom: 1px solid #8A9AA2; background: #8A9AA2 !important; }
			#mainarea .tabs a:hover { color: #003660; background: transparent; }

.tbtopaction { background: #8A9AA2; border: 1px solid #FFFFFB; text-align: right; padding: 3px; margin: 0 10px; }
	.tabaction { border-top: none; }
	.tbtopaction * { font-size: 12px !important; }
		.tbtopaction input { padding: 3px; }

#uploadbox .tabs { margin: 0; }
#uploadbox table { border: 1px solid #CCC; border-top: none; background:#8A9AA2; }

#batchpreview { background: #E6E9E0; height: 300px; border: 1px solid #EEE; overflow: auto; }
	.picspace { border-bottom: 1px solid #CCC; margin: 3px; }
		.picspace img { margin: 3px 6px 3px 0; border: 3px solid #EEE; max-width: 60px; max-height: 60px; width: expression(this.width > 60 ? 60: true);; height: expression(this.width > 40 ? 40: true);; }

tr.selected { background: #8A9AA2; }


.tbfootaction { background: #8A9AA2; border: 1px solid #FFFFFB; text-align: left; padding: 5px; margin: 10px 10px; }
	.tbfootaction * { font-size: 12px; }
	.tbfootaction div, .tbfootaction table { text-align: left; }
		.tbfootaction div { padding: 0.3em; }
		.tbfootaction th { vertical-align: middle; padding: 0; width: 7em; }


.welcomepanel { margin: 1em; padding: 0; list-style: none; }
	/*\*/ * html .welcomepanel { height: 1%; } /**/ *>.welcomepanel { overflow: hidden; }
	.welcomepanel li { float: left; line-height: 2em; text-align: center; font-size: 1.17em; }
		.welcomepanel a { display: block; border: 1px solid #FFFFFA; background: #E6E9E0; margin: 0.5em; padding: 0 20px; text-decoration: none; }
			.welcomepanel a:hover { background: #8A9AAA; border: 1px solid; border-color: #FFD68B #B1A682 #B1A682 #FFD68B; color: #333; }


/* ??? */
.pagediv { text-align: right; }
	/*\*/ * html .pagediv { height: 1%; } /**/ *>.pagediv { overflow: hidden; }
	.xspace-page { float: right; margin: 5px 5px 0 0; }
		.xspace-page a, .xspace-page span { float: left; display: inline; text-decoration: none; margin-right: 3px; line-height: 20px; padding: 0 5px; border: 1px solid; border-color: #CEE3EA #90AAB4 #90AAB4 #CEE3EA; background: #F5FBFF; }
			.xspace-page a:hover { color: #333; }
			span.xspace-totlerecord, span.xspace-totlepages { color: #090; }
				span.xspace-totlerecord { margin-right: 0; border-right: none; }
			span.xspace-current { background: #F90; border-color: #0A0 #060 #060 #0A0; color: #E6E9E0; font-weight: bold; }

.smalltxt { color: #8B90A2; }
.normaltxt { font-size: 12px; color: #000; font-weight: normal; }

.errtips { border: 1px solid #E9E9E9; background: red; }
.presubject { font-weight: normal; color: #003660; }

.xspace-quote{ background: #8A9AA2; border: 1px solid #FFFFFB; text-align: left; padding: 5px; }

/*AJAX div*/
.xspace-ajaxmsg { position: fixed; right: 0; top: 0; background: red; color: #E6E9E0; line-height: 2em; padding: 0 20px; }
	* html .xspace-ajaxmsg { position: absolute; top: expression(( ignoreMe = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop ) + 'px'); }
.xspace-ajaxdiv { position:absolute; padding: 5px; border: 1px solid #BBB; background: #FCFFEF; text-align: left; }
	.xspace-ajaxdiv h5 { line-height: 24px; font-size: 1em; margin: 0; }
		.xspace-ajaxdiv h5 a { float: right; font-weight: normal; }
	.xspace-ajaxcontent { background: #E6E9E0; border: 1px solid #EEE; }
		.xspace-ajaxcontent form { margin: 0; }

/*??????*/
.trbgcolor {background: #CAD2CA;}

