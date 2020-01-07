-- Initialize local namespace 
local addonName, addon = ...
local _G = _G

-- Static class
addon.Frame = {
    ---
    --- This function will attach static functions directly to a frame, so instead of calling
    --- DoIt.Frame.Move(frame), you can do DoIt.Frame.AddDoItMethods(frame) once then be able to call
    --- these functions (the ones with frame as an initial argument) as methods, such as frame:Move()
    ---
    AddDoItMethods = function (frame)
        frame.Move = addon.Frame.Move;
        frame.GetPoints = addon.Frame.GetPoints;
        frame.SetPoints = addon.Frame.SetPoints;
        frame.GetFrameData = addon.Frame.GetFrameData;
        frame.SetFrameData = addon.Frame.SetFrameData;
        return frame;
    end,
    ---
    --- Get the frame that the mouse is under
    ---
    GetFocus = function ()
        return GetMouseFocus(), GetMouseFocus():GetName();
    end,
    ---
    --- Call's Move() with the argument of GetFocus()
    ---
    MoveFocus = function (start)
        return addon.Frame.Move(addon.Frame.GetFocus(), start);
    end,
    ---
    --- Starts and stops the process or moving a frame
    ---
    Move = function (frame, start)
        -- Argument checks
        if (not frame) then frame = addon.Frame.GetFocus() end
        if (type(frame) == "string" and _G[frame]) then frame = _G[frame] end
        if (not frame or frame == WorldFrame or frame == UIParent) then return false end
        if (not frame.SetMovable) then return false end

        -- The move part
        local isMovable = frame:IsMovable();
        if (start) then
            frame:SetClampedToScreen(true);
            frame:SetMovable(true);
            frame:StartMoving();
            addon.Frame._DoItMoveIt = frame;
        else
            if (addon.Frame._DoItMoveIt) then
                frame = addon.Frame._DoItMoveIt;
                addon.Frame._DoItMoveIt = nil;
            end
            frame:StopMovingOrSizing();
            frame:SetMovable(isMovable);
        end
        return true;
    end,
    ---
    --- Returns all anchor points in a single table, which is savable and restorable with SetPoints()
    ---
    GetPoints = function (frameObject)
        -- Argument check
        if (not frameObject or type(frameObject) ~= "table") then return nil end
        local frameData = { }
        
        -- Get anchors
        local points = frameObject:GetNumPoints();
        for idx = 1, points do
            local point, relativeTo, relativePoint, xOfs, yOfs = frameObject:GetPoint(idx)
            frameData[idx] = {
                point = point,
                relativeTo = relativeTo,
                relativePoint = relativePoint,
                xOfs = xOfs,
                yOfs = yOfs,
            }
        end
        return frameData;
    end,
    ---
    --- Set's all points from the single table returned by GetPoints()
    ---
    SetPoints = function (frame, pt)
        frame:ClearAllPoints();
        for i = 1, #pt do
            frame:SetPoint(pt[i].point, pt[i].relativeTo, pt[i].relativePoint, pt[i].xOfs, pt[i].yOfs);
        end
    end,
    ---
    --- Returns all the information needed to size and position a frame... a table containing
    --- frame name, achors, scale, width, and height. This is savable in variables.
    ---
    GetFrameData = function (frameObject)
        return {
            points = addon.Frame.GetPoints(frameObject),
            name = frameObject:GetName(),
            scale = frameObject:GetScale(),
            width = frameObject:GetWidth(),
            height = frameObject:GetHeight(),
        }
    end,
    ---
    --- Uses the data from GetFrameData() to size and position a frame
    ---
    RestoreFrameData = function (frameData)
        -- find by .name property in frameData
        if (type(frameData) ~= "table" or not frameData.name or not _G[frameData.name]) then return false end
        if (InCombatLockdown()) then return false end -- Anti-taint
        local frame = _G[frameData.name];
        
        -- Set scale
        if (frame:GetScale() ~= frameData.scale) then
            frame:SetScale(frameData.scale);
        end
        
        -- Set anchor points
        addon.Frame.SetPoints(frame, frameData.points);
       
        -- set width
        if (frame:GetWidth() ~= frameData.width) then
            frame:SetWidth(frameData.width);
        end
        
        -- set height
        if (frame:GetHeight() ~= frameData.height) then
            frame:SetHeight(frameData.height);
        end
    end,
}

-- Export
DoIt.Frame = addon.Frame;

