dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "SpamPlayerghost"
mod_settings_version = 1
mod_settings =
{
    {
        category_id = "spawn_settings",
        ui_name = "Spawn Settings",
        ui_description = "Configure playerghost spawn settings",
        settings = {
            {
                id = "freq",
                ui_name = "Spawn Frequency",
                ui_description = "How often should ghost spawn?",
                value_default = "0",
                values = {{"0","Often"}, {"1","More often"}},
                scope = MOD_SETTING_SCOPE_RUNTIME_RESTART,
            },
        },
    },
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end
