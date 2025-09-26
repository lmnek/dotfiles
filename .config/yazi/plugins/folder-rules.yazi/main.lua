local function setup()
    ps.sub("cd", function()
        local cwd = cx.active.current.cwd
        if cwd:ends_with("Downloads") or cwd:ends_with("pix/screens") then
            -- DOWNLOADS:
            ya.emit("sort", { "mtime", reverse = true, dir_first = false })
        else
            -- EVERYTHING ELSE:
            ya.emit("sort", { "natural", reverse = false, dir_first = true })
        end
    end)
end

return { setup = setup }
