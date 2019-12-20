U1RegisterAddon("alaTalentEmu", {
    title = "跨职业天赋模拟器",
    tags = { TAG_INTERFACE, },
    desc = "天赋模拟器，可以模拟天赋、导出代码、导入代码、观察其他玩家天赋、应用模拟器天赋等。",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    minimap = 'LibDBIcon10_alaTalentEmu', 
    icon = [[interface\buttons\ui-microbutton-talents-up]],

    runBeforeLoad = function(info, name)
        if emu_set_config then
            emu_set_config("show_equipment", true);
        end
    end,
    -- {
    --     text = "配置选项",
    --     callback = function(cfg, v, loading)
    --             -- InterfaceOptionsFrame_Show();
    --             -- InterfaceOptionsFrame_OpenToCategory("alaChat_Classic");
    --     end
    -- }
});

