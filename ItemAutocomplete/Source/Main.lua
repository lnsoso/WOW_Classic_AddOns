select(2, ...) 'Main'

-- Imports
local AceConfig = LibStub('AceConfig-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')
local EventSource = require 'Shared.EventSource'
local Persistence = require 'Shared.Persistence'
local TaskScheduler = require 'Shared.TaskScheduler'
local ItemDatabase = require 'ItemDatabase'
local ChatAutocompleteIntegrator = require 'ChatAutocompleteIntegrator'
local util = require 'Utility.Functions'

------------------------------------------
-- Bootstrap
------------------------------------------

local eventSource = EventSource.New()

eventSource:AddListener('ADDON_LOADED', function (addonName)
  if addonName ~= util.GetAddonName() then
    return
  end

  local taskScheduler = TaskScheduler.New()
  local persistence = Persistence.New(addonName .. 'DB')
  local itemDatabase = ItemDatabase.New(persistence, eventSource, taskScheduler)
  local chatAutocompleteIntegrator = ChatAutocompleteIntegrator.New(itemDatabase)

  local updateItemDatabase = function()
    util.Print('Updating item database')
    itemDatabase:UpdateItemsAsync(function()
      util.Print('The database has been updated.')
    end)
  end

  if itemDatabase:IsEmpty() then
    updateItemDatabase()
  end

  local options = persistence:GetAccountItem('options')
  local inputs = chatAutocompleteIntegrator:Config(options)
  chatAutocompleteIntegrator:Enable()

  AceConfig:RegisterOptionsTable(addonName, { type = 'group', args = inputs })
  AceConfigDialog:AddToBlizOptions(addonName, addonName)

  util.RegisterSlashCommand('iaupdate', updateItemDatabase)
end)