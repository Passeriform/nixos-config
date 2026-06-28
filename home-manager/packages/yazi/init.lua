local old_icon = Entity.icon

function Entity:icon(...)
    local icon = self._file:icon()

    if icon then
        return ui.Span(" " .. icon.text .. "  "):style(icon.style)
    end

    return old_icon(self, ...)
end
