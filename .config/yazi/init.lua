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

-- cmd for installing/listing/updating plugins: "ya pack ..."
-- nice plugins list: https://yazi-rs.github.io/docs/resources

-- require("starship"):setup() -- a bit distracting..
