local old_mouse_pressed = PrePlanningMapGui.mouse_pressed
function PrePlanningMapGui:mouse_pressed(button, x, y)
	local inside = self._panel:inside(x, y)
	if _G.IS_VR then
		if inside then
			if button == Idstring("1") then
				self:start_drawing()
			end
		end
	end
	old_mouse_pressed(self, button, x, y)
end

local old_mouse_moved = PrePlanningMapGui.mouse_moved
function PrePlanningMapGui:mouse_moved(o, x, y)
	if _G.IS_VR and self._draw_mode then
		return true, "link"
	end
	return old_mouse_moved(self, o, x, y)
end

Hooks:PreHook(
	PrePlanningMapGui,
	"mouse_released",
	"PrePlanVRMouseReleased",
	function(self, button, x, y)
		if button == Idstring("1") then
			self:end_drawing()
		end
	end
)
