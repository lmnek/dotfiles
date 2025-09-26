-- This file is used to:
-- - extend the functionality of Yazi (e.g. status bar behavior)
-- - customize plugins

-- Show symlink in statusbar (from 'tips' in docs)
Status:children_add(function(self)
    local h = self._current.hovered
    if h and h.link_to then
        return " -> " .. tostring(h.link_to)
    else
        return ""
    end
end, 3300, Status.LEFT)

-- Hide tab bar
function Tabs.height()
    return 0
end

-- Put tabs in top line bar
Header:children_add(function()
    if #cx.tabs <= 1 then
        return ""
    end
    local spans = {}
    for i = 1, #cx.tabs do
        local name = ya.truncate(string.format(" %d %s ", i, cx.tabs[i].name), { max = 20 })
        if i == cx.tabs.idx then
            spans[#spans + 1] = ui.Span(" " .. name .. " "):style(th.tabs.active)
        else
            spans[#spans + 1] = ui.Span(" " .. name .. " "):style(th.tabs.inactive)
        end
    end
    return ui.Line(spans)
end, 9000, Header.RIGHT)

-- cmd for installing/listing/updating plugins: "ya pack ..."
-- nice plugins list: https://yazi-rs.github.io/docs/resources

-- require("starship"):setup() -- a bit distracting..
