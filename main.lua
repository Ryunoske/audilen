--- @since 25.5.31

-- Get selected paths using ya.sync
local get_paths = ya.sync(function()
    local paths = {}
    for _, u in pairs(cx.active.selected) do
        paths[#paths + 1] = tostring(u)
    end
    return paths
end)

-- Function to get total duration from given mp3 items
local function get_total_duration(items)
    local total = 0
    local mp3_count = 0
    for _, path in ipairs(items) do
        if path:lower():match("%.mp3$") then
            mp3_count = mp3_count + 1
            local file_path = path:gsub("^file://", "")  -- Remove file:// prefix
            local output = Command("mediainfo"):arg({"--Inform=Audio;%Duration%", file_path}):output()
            if output and output.stdout then
                local duration = tonumber(output.stdout)
                if duration then
                    total = total + (duration / 1000) -- Convert from ms to seconds
                end
            end
        end
    end
    return total, mp3_count
end

-- Format seconds to HH:MM:SS
local function format_duration(seconds)
    if not seconds or seconds == 0 then return "00:00:00" end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02d:%02d:%02d", h, m, s)
end

return {
    entry = function(_, job)

        local items = get_paths()
        if #items == 0 then
            ya.err("No files selected")
            return
        end

        local total_secs, mp3_count = get_total_duration(items)
        local formatted_duration = format_duration(total_secs)

        ya.notify {
            title = "Audio Length",
            content = string.format("Found %d MP3s\nTotal duration: %s", mp3_count, formatted_duration),
            timeout = 4,
        }
    end,
}