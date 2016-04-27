//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2013 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

require(["dojo/on", "dojo/ready", "dijit/registry"], function(on, ready, registry) {
	ready(function() {
		var skin = document.getElementById("skin");
		var wrapper = document.getElementById("previewFrameWrapper");
		var frame = document.getElementById("previewFrame");
		var resizeHandleX = registry.byId("resizeHandleX");
		var resizeHandleY = registry.byId("resizeHandleY");
		var _updateSizing = function(e) {
			//Base
			var tmp = this._getNewCoords(e, 'border', this._resizeHelper.startPosition);
			if(tmp === false) {
				return;
			}
			this._resizeHelper.resize(tmp);
			e.preventDefault();
			//Override
			frame.style.visibility = "hidden"; //Workaround
			var headerDocument = window.frames["headerFrame"].document;
			var sizeDropdown = headerDocument.getElementById("sizeDropdown");
			var customOption = headerDocument.getElementById("customOption");
			if (!customOption) {
				customOption = headerDocument.createElement("option");
				customOption.id = "customOption";
				customOption.value = "custom";
				sizeDropdown.add(customOption, null);
			}
			customOption.text = tmp.w + "x" + tmp.h;
			customOption.selected = true;
		};
		var resize = function(e) {
			frame.style.visibility = "visible"; //Workaround
			var tmp = this._getNewCoords(e, 'border', this._resizeHelper.startPosition);
			skin.className = (tmp.w > tmp.h ? "landscape" : "portrait");
		};
		resizeHandleX._updateSizing = _updateSizing;
		resizeHandleY._updateSizing = _updateSizing;
		on(resizeHandleX, "resize", resize);
		on(resizeHandleY, "resize", resize);
	});
});
