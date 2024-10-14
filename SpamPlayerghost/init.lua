ModTextFileSetContent("mods/SpamPlayerGhost/magicnum.xml", [[
<MagicNumbers
    BIOME_APPARITION_CHANCE="1"
    APPARITION_MIN_BONES_REQUIRED="1"/>
]])
ModMagicNumbersFileAdd("mods/SpamPlayerGhost/magicnum.xml")

local spawn_freq = tonumber(ModSettingGet("SpamPlayerghost.freq")) or 0

local function get_world_comp()
    local world_state = GameGetWorldStateEntity()
    return EntityGetFirstComponent(world_state, "WorldStateComponent")
end

local function get_apl()
    local w = get_world_comp()
    return ComponentGetValue2(w, "apparitions_per_level")[1]
end

local function reset_apl()
    local w = get_world_comp()
    ComponentSetValue(w, "apparitions_per_level", "")
end

function OnWorldPreUpdate()
    if get_apl() == 4 then
        reset_apl()
    end

    -- Get apl back up to 3
    if spawn_freq > 0 then
        local app_per = get_apl()

        -- Avoid infinite loop
        local tries_left = 20

        while app_per == nil or app_per < 3 do
            if tries_left <= 0 then
                break
            end

            SpawnApparition(0, 0, 0)
            local w = get_world_comp()
            app_per = ComponentGetValue2(w, "apparitions_per_level")[1]

            tries_left = tries_left - 1
        end
    end
end
