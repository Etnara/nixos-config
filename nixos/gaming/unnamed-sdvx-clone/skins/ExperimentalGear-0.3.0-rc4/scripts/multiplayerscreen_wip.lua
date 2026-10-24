local json = require("common.json")

local common = require('common.util');
local Sound = require("common.sound")
local difbar = require("components.diff_rectangle");
local spinnybg = require('components.background');
local msg = game.GetSkinSetting("MSG");
local normname = game.GetSkinSetting("username")

local crew = game.GetSkinSetting("single_idol")

local m_jacket = gfx.CreateSkinImage("multi/lobby/multi_jacket.png", 1);
local m_base_panel = gfx.CreateSkinImage("multi/lobby/multi_base_panel.png", 1);
local m_anim = gfx.CreateSkinImage("multi/lobby/panel_laser.png", 1);
local m_panel = gfx.CreateSkinImage("multi/lobby/matching_panel.png", 1);
local m_s_panel = gfx.CreateSkinImage("multi/lobby/song_panel.png", 1);
local m_host_panel = gfx.CreateSkinImage("multi/lobby/user_panel.png", 1);
local m_bpm_panel = gfx.CreateSkinImage("multi/lobby/lane_speed_panel.png", 1);
local m_info_panel = gfx.CreateSkinImage("multi/lobby/button_panel.png", 1);

local headerMatchingImage = gfx.CreateSkinImage("titlescreen/entry.png", 1);

local m_4pb_panels = gfx.CreateSkinImage("multi/lobby/user_panel_2.png", 1);

local ready_bt = gfx.CreateSkinImage("multi/lobby/READY.png", 1);

local bg = gfx.CreateSkinImage("multi/lobby/bg.png", 1);
local bg_graid1 = gfx.CreateSkinImage("multi/lobby/gradient_bottom.png", 1);
local bg_graid2 = gfx.CreateSkinImage("multi/lobby/gradient_top.png", 1);

local idolAnimation = gfx.LoadSkinAnimation('crew/anim/'..crew, 1 / 30, 0, true);
local idolAnimTransitionScale = 0;
if not idolAnimation then
    game.Log("Crew folder crew/anim/"..crew.." does not exist.", game.LOGGER_WARNING)
end

local resX,resY = game.GetResolution()

local mposx = 0;
local mposy = 0;
local hovered = nil;
local buttonWidth = resX*(3/4);
local buttonHeight = 75;
local buttonBorder = 2;
local portrait
local jacket_size;

local BAR_ALPHA = 191;
local HEADER_HEIGHT = 100

local resx, resy = game.GetResolution()
local desw = 1080
local desh = 1920
local scale;

game.LoadSkinSample("click-02")
game.LoadSkinSample("click-01")
game.LoadSkinSample("menu_click")

local loading = true;
local rooms = {};
local lobby_users = {};
local selected_room = nil;
local user_id = nil;
local jacket = 0;
local all_ready;
local user_ready;
local go;
local hard_mode = false;
local rotate_host = false;
local start_game_soon = false;
local host = nil;
local owner = nil;
local missing_song = false;
local placeholderJacket = gfx.CreateSkinImage("song_select/loading.png", 0)
local did_exit = false;

local irHeartbeatRequested = false;
local irText = ''

local grades = {
    {["max"] = 6900000, ["image"] = gfx.CreateSkinImage("common/grades/D.png", 0)},
    {["max"] = 7900000, ["image"] = gfx.CreateSkinImage("common/grades/C.png", 0)},
    {["max"] = 8600000, ["image"] = gfx.CreateSkinImage("common/grades/B.png", 0)},
    {["max"] = 8900000, ["image"] = gfx.CreateSkinImage("common/grades/A.png", 0)},
    {["max"] = 9200000, ["image"] = gfx.CreateSkinImage("common/grades/A+.png", 0)},
    {["max"] = 9400000, ["image"] = gfx.CreateSkinImage("common/grades/AA.png", 0)},
    {["max"] = 9600000, ["image"] = gfx.CreateSkinImage("common/grades/AA+.png", 0)},
    {["max"] = 9700000, ["image"] = gfx.CreateSkinImage("common/grades/AAA.png", 0)},
    {["max"] = 9800000, ["image"] = gfx.CreateSkinImage("common/grades/AAA+.png", 0)},
    {["max"] = 9900000, ["image"] = gfx.CreateSkinImage("common/grades/S.png", 0)}
  }

local badges = {
    gfx.CreateSkinImage("badges/played.png", 0),
    gfx.CreateSkinImage("badges/clear.png", 0),
    gfx.CreateSkinImage("badges/hard-clear.png", 0),
    gfx.CreateSkinImage("badges/full-combo.png", 0),
    gfx.CreateSkinImage("badges/perfect.png", 0)
}

local user_name_key = game.GetSkinSetting('multi.user_name_key')
if user_name_key == nil then
  user_name_key = 'nick'
end
local name = game.GetSkinSetting(user_name_key)
if name == nil or name == '' then
    name = 'Guest'
end

local normal_font = game.GetSkinSetting('multi.normal_font')
if normal_font == nil then
    normal_font = 'NotoSans-Regular.ttf'
end
local mono_font = game.GetSkinSetting('multi.mono_font')
if mono_font == nil then
    mono_font = 'NovaMono.ttf'
end

local SERVER = game.GetSkinSetting("multi.server")

local drawIdol = function(deltaTime)
    if idolAnimation then
        local idolAnimTickRes = gfx.TickAnimation(idolAnimation, deltaTime);
        if idolAnimTickRes == 1 then
            gfx.GlobalAlpha(idolAnimTransitionScale);

            idolAnimTransitionScale = idolAnimTransitionScale + 1 / 60;
            if (idolAnimTransitionScale > 1) then
                idolAnimTransitionScale = 1;
            end

            gfx.ImageRect(0, 0, resX,resY, idolAnimation, 1, 0);
            gfx.GlobalAlpha(1);
        end
    end
end

songjacket = function() -- self explanatory

    if portrait then
        split = resX
        jacket_size = math.min(resX/4, resY/4);
        song_x_off = 0;
    else
        split = resX/2
        jacket_size = math.min(resX/2, resY/2);
        song_x_off = 1/2*resX;
    end

    local jw , jh = gfx.ImageSize(m_jacket);
    gfx.BeginPath();
    gfx.ImageRect(333, 1284, jw/1.18, jh/1.18, m_jacket,1,0);

end

m_own_info = function()

    local x = 0
    local y = 1310
    gfx.BeginPath();
    gfx.FontSize(40)
    gfx.ImageRect(x, y, 343/1.18, 361/1.18,m_host_panel,1,0)
    gfx.Text(normname, x+20, y+78)

   gfx.FontSize(22)
   gfx.Text(irText, x+5, y+288);

end

m_base_part = function() -- just the images which slide up
    local jw , jh = gfx.ImageSize(m_base_panel);
    gfx.BeginPath();
    gfx.ImageRect(1, 1250, jw/1.17, jh/1.18, m_base_panel,1,0);
    gfx.BeginPath();
    gfx.ImageRect(1, 1250, jw/1.17, jh/1.18, m_anim,1,0);

    gfx.LoadSkinFont('Digital-Serial-Bold.ttf')
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_LEFT, gfx.TEXT_ALIGN_LEFT)
    gfx.FontSize(24)
end

m_part = function() -- room name part
    local jw , jh = gfx.ImageSize(m_panel);
    gfx.BeginPath();
    gfx.ImageRect(429, 1142, jw/1.175, jh/1.18, m_panel,1,0);

    gfx.FontSize(32);
    gfx.LoadSkinFont('Digital-Serial-Bold.ttf')
    gfx.TextAlign(gfx.TEXT_ALIGN_LEFT, gfx.TEXT_ALIGN_MIDDLE)
    gfx.Text(selected_room.name, 575, 1179)
end

m_s_part = function () -- song info panel
    local jw , jh = gfx.ImageSize(m_s_panel);
    gfx.BeginPath();
    gfx.ImageRect(283, 1187, jw/1.175, jh/1.18, m_s_panel,1,0);

    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_LEFT);
    gfx.FillColor(255,255,255)
    
    gfx.FontSize(32)
    if selected_song == nil then
        if host == user_id then
                    gfx.Text("NO SONG", 535, 1236)
                    gfx.Text("NO ARIST", 535, 1275)
                gfx.FontSize(24)
                    gfx.Text("NO EFFECTOR", 746, 1378)
                    gfx.Text("NO ILLUSTRATOR", 746, 1406)
                gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
                    gfx.FontSize(22)
                    gfx.Text("BPM    ?",780, 1307)
        else
            if missing_song then
                    gfx.Text("MISSING SONG!!!!", 535, 1235)
                    gfx.Text("MISSING ARIST!!!!", 535, 1275)
                gfx.FontSize(24)
                    gfx.Text("MISSING EFFECTOR!!!!", 744, 1378)
                    gfx.Text("MISSING ILLUSTRATOR!!!!", 744, 1406)
            else
                    gfx.Text("HOST IS SELECTING SONG", 535, 1235)
                    gfx.Text(" ", 535, 1275)
                gfx.FontSize(24)
                    gfx.Text(" ", 746, 1378)
                    gfx.Text(" ", 746, 1406)
                gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
                    gfx.FontSize(22)
                    gfx.Text("BPM    ?",780, 1307)
            end
        end
    else
        if selected_song.min_bpm ~= selected_song.max_bpm then
            gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
            gfx.FontSize(22);  
            gfx.Text("BPM",777, 1307)
            gfx.FontSize(26);
            gfx.Text(string.format("%.0f - %.0f",
                selected_song.min_bpm, selected_song.max_bpm),
                780 + 77, 1307)
        else
            gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
            gfx.FontSize(22);
            gfx.Text("BPM",777, 1307)
            gfx.Text(string.format("%.0f",
                selected_song.min_bpm),
                780 + 77, 1307)
        end
        gfx.TextAlign(gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_LEFT);
        gfx.FontSize(32);
        gfx.Text(selected_song.title, 535, 1236)
        gfx.Text(selected_song.artist, 535, 1275)
        gfx.FontSize(24)
        gfx.Text(selected_song.effector, 746, 1377)
        gfx.Text(selected_song.illustrator, 746, 1406)
    end
end

m_bpm_part = function () -- bpm and lane speed
    local jw , jh = gfx.ImageSize(m_bpm_panel);
    gfx.BeginPath();
    gfx.ImageRect(0, 1692, jw/1.18, jh/1.18, m_bpm_panel,1,0);

    gfx.FontSize(32)
    if selected_song == nil then
        if host == user_id then
            gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
                gfx.FontSize(32)
                    gfx.Text("BPM    ?",76, 1788)
                    gfx.Text("LANE-SPEED    ?",76, 1832)
        else
            if missing_song then
                gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
                gfx.FontSize(32)
                    gfx.Text("BPM    ?",76, 1788)
                    gfx.Text("LANE-SPEED    ?",76, 1832)
            else
                gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
                gfx.FontSize(32)
                    gfx.Text("BPM    ?",76, 1788)
                    gfx.Text("LANE-SPEED    ?",76, 1832)
            end
        end
    end
    if selected_song ~= nil then
        gfx.FillColor(255,255,255)
        gfx.FontSize(32);
        gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)

        if selected_song.min_bpm ~= selected_song.max_bpm then
            
            gfx.Text("BPM",76, 1788)
            gfx.Text(string.format("%.0f - %.0f",
                selected_song.min_bpm, selected_song.max_bpm),
                76 + 75, 1788)
           
            gfx.Text("LANE-SPEED",76, 1832)
            gfx.Text(string.format("%.2f = %.0f",
                selected_song.hispeed, selected_song.speed_bpm * selected_song.hispeed),
                76 + 175, 1832)
        else

            gfx.FontSize(32);
            gfx.Text("BPM",76, 1788)
            gfx.Text(string.format("%.0f",
                selected_song.min_bpm),
                76 + 75, 1788)

            gfx.Text("LANE-SPEED",76, 1832)
            gfx.Text(string.format("%.2f = %.0f",
                selected_song.hispeed, selected_song.speed_bpm * selected_song.hispeed),
                76 + 175, 1832)
        end
    end
end

m_info_part = function () -- the info panel
    local jw , jh = gfx.ImageSize(m_info_panel);
    gfx.BeginPath();
    gfx.ImageRect(475, 1590, jw/1.18, jh/1.18, m_info_panel,1,0);

    local check = 770

    draw_checkbox("Excessive",  check - 200, 1625, toggle_hard, hard_mode, not start_game_soon)
    draw_checkbox("Mirror Mode",check - 15, 1625, toggle_mirror, mirror_mode, not start_game_soon)
    draw_checkbox("Rotate Host",check + 175, 1625, toggle_rotate, do_rotate,
                    (owner == user_id or host == user_id) and not start_game_soon)

    for i, user in ipairs(lobby_users) do 
    
        buttonY = 1775

        local side_button_off = 0
        if owner == user_id and user.id ~= user_id then
            draw_button("K",525+side_button_off, buttonY, 50, function()
                kick_user(user);
            end)
            side_button_off = 60;
        end
        if (owner == user_id or host == user_id) and user.id ~= host then
            draw_button("H",525+side_button_off, buttonY+85, 50, function()
                change_host(user);
            end)
        end

    end

end

user_setup = function () -- (semi new) user layering
    local distance = 350
    for i, user in ipairs(lobby_users) do
        
        
        if i == 1 then
            draw_user(user, -distance, 1142-360/1.2, 420/1.2, 330/1.2, i,215,245.5)
        elseif i == 2 then
            draw_user(user, 16, 1142-360/1.2, 420/1.2, 330/1.2, i,215,245.5)
        elseif i == 3 then
            draw_user(user, 16+distance, 1142-360/1.2, 420/1.2, 330/1.2, i,215,245.5)
        elseif i == 4 then
            draw_user(user, 16+distance+distance, 1142-360/1.2, 420/1.2, 330/1.2, i,215,245.5)
        elseif i > 4 then
            draw_user(user, 16+distance+distance+distance+distance, 1142-360/1.2, 420/1.2, 330/1.2, i,215,245.5)
        end
    end
end

function drawHeader()
    gfx.BeginPath();
    gfx.FillColor(0, 0, 0, BAR_ALPHA);
    gfx.Rect(0, 0, desw, HEADER_HEIGHT);
    gfx.Fill();
    gfx.ClosePath()

    gfx.ImageRect(desw/2 - 200, HEADER_HEIGHT/2 - 20, 400, 40, headerMatchingImage, 1, 0)
end

mouse_clipped = function(x,y,w,h)
    return mposx > x and mposy > y and mposx < x+w and mposy < y+h;
end;

draw_room = function(name, x, y, selected, hoverindex)
    local buttonWidth = resX*(3/4);
    local rx = x - (buttonWidth / 2);
    local ty = y - (buttonHeight / 2);
    local roomButtonBorder = buttonBorder;
    gfx.BeginPath();
    gfx.FillColor(0,128,255);
    if selected then
       gfx.FillColor(0,255,0);
       roomButtonBorder = 4;
    end
    if mouse_clipped(rx,ty, buttonWidth, buttonHeight) then
       hovered = hoverindex;
       gfx.FillColor(255,128,0);
    end
    gfx.Rect(rx - roomButtonBorder,
        ty - roomButtonBorder,
        buttonWidth + (roomButtonBorder * 2),
        buttonHeight + (roomButtonBorder * 2));
    gfx.Fill();
    gfx.BeginPath();
    gfx.FillColor(40,40,40);
    gfx.Rect(rx, ty, buttonWidth, buttonHeight);
    gfx.Fill();
    gfx.BeginPath();
    gfx.FillColor(255,255,255);
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_MIDDLE);
    gfx.FontSize(40);
    gfx.Text(name, x, y);
end;

draw_button = function(name, x, y, buttonWidth, hoverindex)
    draw_button_color(name, x, y, buttonWidth, hoverindex, 40,40,40, 0,128,255)
end

draw_button_color = function(name, x, y, buttonWidth, hoverindex,r,g,b, olr,olg,olb)
    local rx = x - (buttonWidth / 2);
    local ty = y - (buttonHeight / 2);
    gfx.BeginPath();
    gfx.FillColor(olr, olg, olb);
    if mouse_clipped(rx,ty, buttonWidth, buttonHeight) then
       hovered = hoverindex;
       gfx.FillColor(255,128,0);
    end
    gfx.Rect(rx - buttonBorder,
        ty - buttonBorder,
        buttonWidth + (buttonBorder * 2),
        buttonHeight + (buttonBorder * 2));
    gfx.Fill();
    gfx.BeginPath();
    gfx.FillColor(r,g,b);
    gfx.Rect(rx, ty, buttonWidth, buttonHeight);
    gfx.Fill();
    gfx.BeginPath();
    gfx.FillColor(255,255,255);
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_MIDDLE);
    gfx.FontSize(40);
    gfx.Text(name, x, y);
end;

draw_checkbox = function(text, x, y, hoverindex, current, can_click)
    gfx.BeginPath();
    
    if can_click then
        gfx.FillColor(255,255,255);
    else
        gfx.FillColor(150,100,100);
    end
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_MIDDLE);
    gfx.FontSize(35);
    gfx.FillColor(201,0,0);
    gfx.Text(text, x, y)

    local xmin,ymin,xmax,ymax = gfx.TextBounds(x, y, text);

    local sx = xmin - 40;
    local sy = y - 15;

    if can_click and mouse_clipped(xmin-10, ymin, xmax-xmin, ymax-ymin) then
        hovered = hoverindex;
     end

    if current then
        -- Draw checkmark
        gfx.BeginPath();
        gfx.FillColor(0, 236, 0);
        gfx.Text(text, x, y)
        gfx.Fill();
    end
end;

--look into user changing -- IMPORTANT !!!
draw_user = function(user, x, y , w, h, rank, breadx,bready)
    local name = user.name
    local showthing = false
    if user.id == user_id then
        name = name
    end
    if user.id == host then
        name = name
    elseif user.ready then
        showthing = true
    elseif not user.ready then
        showthing = false
   end

    gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_MIDDLE);
    gfx.FillColor(255,255,255)
    gfx.FontSize(42)

    
        gfx.FontSize(30)
        gfx.BeginPath();
        gfx.ImageRect(x, y ,w, h,m_4pb_panels,1,0)
        gfx.Text(name, x+135, y+51)


    if showthing == true then
        local jw , jh = gfx.ImageSize(ready_bt);
        gfx.BeginPath();
        gfx.ImageRect(x+breadx, y+bready, jw/1.18, jh/1.18, ready_bt,1,0);
    elseif showthing == false then
        local jw , jh = gfx.ImageSize(ready_bt);
        gfx.BeginPath();
        gfx.ImageRect(x+breadx, y+bready, jw/1.18, jh/1.18, ready_bt,0,0);
    end

end;

function render_loading()
    if not loading then return end
    gfx.Save()
    gfx.ResetTransform()
    gfx.BeginPath()
    gfx.MoveTo(resX, resY)
    gfx.LineTo(resX - 350, resY)
    gfx.LineTo(resX - 300, resY - 50)
    gfx.LineTo(resX, resY - 50)
    gfx.ClosePath()
    gfx.FillColor(33,33,33)
    gfx.Fill()
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_RIGHT, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("LOADING...", resX - 20, resY - 3)
    gfx.Restore()
end

function render_info()
 
    if searchStatus then
		gfx.BeginPath()
		gfx.FillColor(255,255,255)
		gfx.FontSize(20);
		gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
		gfx.Text(searchStatus, 3, 3)
    end

end


draw_diff_icon = function(diff, x, y, w, h)
    difbar.render(deltaTime, x, y, 1, diff.difficulty, diff.level);
end

local doffset = 0;
local timer = 0;

local possy = 1095;
local possx = 150;

draw_diffs = function(diffs, x, y, w, h, selectedDiff)
    local diffWidth = w/2
    local diffHeight = w/2
    local diffCount = #diffs
    gfx.Scissor(x+84 + possx,y + possy,w/2.451,h)
    for i = math.max(selectedDiff - 2, 1), math.max(selectedDiff - 1,1) do
      local diff = diffs[i]
      local xpos = x + ((w/2 - diffWidth/2) + (selectedDiff - i + doffset)*(-0.8*diffWidth))
      if  i ~= selectedDiff then
        draw_diff_icon(diff, xpos + possx, y + possy, diffWidth, diffHeight, false)
      end
    end

    --after selected
  for i = math.min(selectedDiff + 2, diffCount), selectedDiff + 1,-1 do
      local diff = diffs[i]
      local xpos = x + ((w/2 - diffWidth/2) + (selectedDiff - i + doffset)*(-0.8*diffWidth))
      if  i ~= selectedDiff then
        draw_diff_icon(diff, xpos + possx, y + possy, diffWidth, diffHeight, false)
      end
    end
    local diff = diffs[selectedDiff]
    local xpos = x + ((w/2 - diffWidth/2) + (doffset)*(-0.8*diffWidth))
  draw_diff_icon(diff, xpos + possx, y + possy, diffWidth, diffHeight, true)
  gfx.ResetScissor()

end

set_diff = function(oldDiff, newDiff)
    game.PlaySample("click-02")
    doffset = doffset + oldDiff - newDiff
end;

local selected_room_index = 1;
local ioffset = 0;

function draw_rooms(y, h)
    if #rooms == 0 then
        return
    end
    local num_rooms_visible = math.floor(h / (buttonHeight + 10))

    local first_half_rooms = math.floor(num_rooms_visible/2)
    local second_half_rooms = math.ceil(num_rooms_visible/2) - 1

    local start_offset = math.max(selected_room_index - first_half_rooms, 1);
    local end_offset = math.min(selected_room_index + second_half_rooms + 2, #rooms);

    local start_index_offset = 1;

    -- If our selection is near the start or end we have to offset
    if selected_room_index <= first_half_rooms then
        start_index_offset = 0;
        end_offset = math.min(#rooms, num_rooms_visible + 1)
    end
    if selected_room_index >= #rooms - second_half_rooms then
        start_offset = math.max(1, #rooms - num_rooms_visible)
        end_offset = #rooms
    end

    for i = start_offset, end_offset do
        local room = rooms[i];
        -- if selected room < halfvis then we start at 1
        -- if sel > #rooms - halfvis then we start at -halfvis
        local offset_index = (start_offset + first_half_rooms) - i + start_index_offset

        local offsetY = (offset_index + ioffset) * (buttonHeight + 10);
        local ypos = y + (h/2) - offsetY;
        local status = room.current..'/'..room.max
        if room.ingame then
            status = status..' (IN MATCH)'
        end
        if room.password then
            status = status..' <P>'
        end
        draw_room(room.name .. ':  '.. status, resX / 2, ypos, i == selected_room_index, function()
            join_room(room)
        end)
    end
end

change_selected_room = function(off)

    local new_index = selected_room_index + off;
    --selected_room_index = 2;
    if new_index < 1 or new_index > #rooms then
        return;
    end

    local h = resY - 290;

    local num_rooms_visible = math.floor(h / (buttonHeight + 10))

    local first_half_rooms = math.floor(num_rooms_visible/2)
    local second_half_rooms = math.ceil(num_rooms_visible/2) - 1

    if off > 0 and (selected_room_index < first_half_rooms or selected_room_index >= #rooms - second_half_rooms - 1) then
    elseif off < 0 and (selected_room_index <= first_half_rooms or selected_room_index >= #rooms - second_half_rooms) then 
    else
        ioffset = ioffset - new_index + selected_room_index;
    end

    game.PlaySample("menu_click")

    selected_room_index = new_index;
end

local IR_HeartbeatResponse = function(res)
    if res.statusCode == IRData.States.Success then
        irText = res.body.serverName .. ' ' .. res.body.irVersion;
    else
        game.Log("Can't connect to IR!", game.LOGGER_WARNING)
    end
end

local IR_Handle = function()
    if not irHeartbeatRequested then
        IR.Heartbeat(IR_HeartbeatResponse)
        irHeartbeatRequested = true;
    end
end

function render_lobby(deltaTime)

    local jw , jh = gfx.ImageSize(bg);
    gfx.BeginPath();
    gfx.ImageRect(0, 0, resX, resY, bg,1,0);
    drawIdol(deltaTime)
    gfx.BeginPath();
    gfx.ImageRect(0, 0, resX, resY, bg_graid1,1,0);
    gfx.ImageRect(0, 0, resX, resY, bg_graid2,1,0);
    drawHeader()
    gfx.BeginPath();
    m_base_part()

    m_own_info()
    user_setup()

    m_info_part()
    m_part()
    m_s_part()
    m_bpm_part()
    songjacket()

    
    if selected_song == nil then
        if jacket == 0 then
            jacket = placeholderJacket
        end
    else
        draw_diffs(selected_song.all_difficulties, split/2 + song_x_off - 150, 200, 300, 100, selected_song.diff_index+1)

        if selected_song.jacket == nil or selected_song.jacket == placeholderJacket then
            selected_song.jacket = gfx.LoadImageJob(selected_song.jacketPath, placeholderJacket)
            jacket = selected_song.jacket
        end
    end
    gfx.Save()
    gfx.BeginPath()
    gfx.Translate(481, 1303+jacket_size/2)
    gfx.ImageRect(-jacket_size/2,-jacket_size/2,jacket_size,jacket_size,jacket,1,0)

    if mouse_clipped(481-jacket_size/2,1423+-jacket_size/2,jacket_size,jacket_size) and host == user_id then
        hovered = function() 
            missing_song = false
            mpScreen.SelectSong()
        end
    end
    gfx.Restore()
end

function render_room_list(deltaTime)

    spinnybg.draw(deltaTime);

    draw_rooms(175, resY - 290);

    -- Draw cover for rooms out of view
    gfx.BeginPath()
    gfx.FillColor(20, 20, 20)
    gfx.Rect(0, 0, resX, 145)
    gfx.Rect(0, resY-170, resX, 170)
    gfx.Fill()
    
    gfx.BeginPath()
    gfx.FillColor(60, 60, 60)
    gfx.Rect(0, 145, resX, 2)
    gfx.Rect(0, resY-170-2, resX, 2)
    gfx.Fill()

    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("Multiplayer Rooms", resX/2, 100)


    if not loading then
        draw_button("Create new room", resX/2, resY-40-buttonHeight, resX*(3/4), new_room);
    end
end


passwordErrorOffset = 0;
function render_password_screen(deltaTime)
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("Joining "..selected_room.name.."...", resX/2, resY/4)

    gfx.FillColor(50,50,50)
    gfx.BeginPath() 
    gfx.Rect(0, resY/2-10, resX, 40)
    gfx.Fill(); 

    gfx.FillColor(255,255,255)
    gfx.Text("Please enter room password:", resX/2, resY/2-40)
    gfx.Text(string.rep("*",#textInput.text), resX/2, resY/2+40) 
    if passwordError then
        
        gfx.FillColor(255,50,50)
        gfx.FontSize(60 + math.floor(passwordErrorOffset*20))
        gfx.Text("Invalid password", resX/2, resY/2+80) 
    end
    draw_button("Join", resX/2, resY*3/4, resX/2,  mpScreen.JoinWithPassword);
end

function render_new_room_password(delta_time)
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("Create New Room", resX/2, resY/4)

    gfx.FillColor(50,50,50)
    gfx.BeginPath() 
    gfx.Rect(0, resY/2-10, resX, 40)
    gfx.Fill(); 

    gfx.FillColor(255,255,255)
    gfx.Text("Enter room password:", resX/2, resY/2-40)
    gfx.Text(string.rep("*",#textInput.text), resX/2, resY/2+40) 
    draw_button("Create Room", resX/2, resY*3/4, resX/2, mpScreen.NewRoomStep);
end
--here
function render_new_room_name(deltaTime)
    gfx.BeginPath();
    gfx.LoadSkinFont("segoeui.ttf")
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("Create New Room", resX/2, resY/4)

    gfx.Rect(0, resY/2-10, resX, 60)


    gfx.Text("Please enter room name:", resX/2, resY/2-40)
    gfx.Text(textInput.text, resX/2, resY/2+40) 
    draw_button("Next", resX/2, resY*3/4, resX/2, mpScreen.NewRoomStep);
end

function render_set_username(deltaTime)
    gfx.FillColor(255,255,255)
    gfx.TextAlign(gfx.TEXT_ALIGN_CENTER, gfx.TEXT_ALIGN_BOTTOM)
    gfx.FontSize(70)
    gfx.Text("First things first...", resX/2, resY/4)

    gfx.FillColor(50,50,50)
    gfx.BeginPath() 
    gfx.Rect(0, resY/2-10, resX, 60)
    gfx.Fill(); 

    gfx.FillColor(255,255,255)
    gfx.Text("Enter a display name:", resX/2, resY/2-40)
    gfx.Text(textInput.text, resX/2, resY/2+40) 
    draw_button("Join Multiplayer", resX/2, resY*3/4, resX/2, function()
        loading = true;
        mpScreen.SaveUsername()
    end);

end

render = function(deltaTime)
    resX,resY = game.GetResolution();
	buttonWidth = resX*(3/4);
    mposx,mposy = game.GetMousePos();
    portrait = resY > resX

    IR_Handle()
    Sound.stopMusic();

    doffset = doffset * 0.9
    ioffset = ioffset * 0.9
    passwordErrorOffset = passwordErrorOffset * 0.9
    timer = (timer + deltaTime)
    timer = timer % 2
    
    hovered = nil;

    gfx.LoadSkinFont(normal_font);

    do_sounds(deltaTime);

    -- Room Listing View
    if screenState == "inRoom" then
        render_lobby(deltaTime);
    elseif screenState == "roomList" then
        render_room_list(deltaTime);
    elseif screenState == "passwordScreen" then
        render_password_screen(deltaTime);
    elseif screenState == "newRoomName" then
        render_new_room_name()
    elseif screenState == "newRoomPassword" then
        render_new_room_password()
    elseif screenState == "setUsername" then
        loading = false;
        render_set_username()
    end
    render_loading();
    render_info();

end

-- Ready up to play
function ready_up()
    Tcp.SendLine(json.encode({topic="user.ready.toggle"}))
end

-- Toggle hard gauage
function toggle_hard()
    Tcp.SendLine(json.encode({topic="user.hard.toggle"}))
end

-- Toggle hard gauage
function toggle_mirror()
    Tcp.SendLine(json.encode({topic="user.mirror.toggle"}))
end

function new_room()
    host = user_id
    owner = user_id
    mpScreen.NewRoomStep()
end

-- Toggle host rotation
function toggle_rotate()
    Tcp.SendLine(json.encode({topic="room.option.rotation.toggle"}))
end

-- Change lobby host
function change_host(user)
    Tcp.SendLine(json.encode({topic="room.host.set", host=user.id}))
end

-- Kick user
function kick_user(user)
    Tcp.SendLine(json.encode({topic="room.kick", id=user.id}))
end

-- Tell the server to start the game
function start_game()
    selected_song.self_picked = false
    if (selected_song == nil) then
        return
    end
    if (start_game_soon) then
        return
    end
    
    Tcp.SendLine(json.encode({topic="room.game.start"}))
end

-- Join a given room
function join_room(room)
    host = user_id
    selected_room = room;
    if room.password then
        mpScreen.JoinWithPassword(room.id)
    else
        mpScreen.JoinWithoutPassword(room.id)
    end
end
local que1 = 0
-- Handle button presses to advance the UI
button_pressed = function(button)
  
    if button == game.BUTTON_FXL and game.BUTTON_FXR then
        if start_game_soon then
            return
        end
        if screenState == "roomList" then
            if #rooms == 0 then
                new_room()
            else
                -- TODO navigate room selection
                join_room(rooms[selected_room_index]) 
            end
        elseif screenState == "inRoom" then
            if host == user_id then
                if selected_song and selected_song.self_picked then
                    if all_ready then
                        start_game()
                    else
                        missing_song = false
                        mpScreen.SelectSong()
                    end
                else
                    missing_song = false
                    mpScreen.SelectSong()
                end
            else
                ready_up()
            end
        end
    end
    
    if button == game.BUTTON_BTA then
        toggle_hard();
    end
    if button == game.BUTTON_BTB then
        toggle_mirror();
    end
end

-- Handle the escape key around the UI
function key_pressed(key)
    if key == 27 then --escape pressed
        if screenState == "roomList" then
            did_exit = true;
            mpScreen.Exit();
            return
        end

        -- Reset room data
        screenState = "roomList" -- have to update here
        selected_room = nil;
        rooms = {};
        selected_song = nil
        selected_song_index = 1;
        jacket = 0;
    end

end

-- Handle mouse clicks in the UI
mouse_pressed = function(button)
    if hovered then
        hovered()
    end
    return 0
end

function init_tcp()
Tcp.SetTopicHandler("server.info", function(data)
    loading = false
    user_id = data.userid
end)
-- Update the list of rooms as well as get user_id for the client
Tcp.SetTopicHandler("server.rooms", function(data)

    rooms = {}
    for i, room in ipairs(data.rooms) do
        table.insert(rooms, room)
    end
end)

Tcp.SetTopicHandler("server.room.joined", function(data)
    selected_room = data.room
end)

local sound_time = 0;
local sound_clip = nil;
local sounds_left = 0;
local sound_interval = 0;

function repeat_sound(clip, times, interval)
    sound_clip = clip;
    sound_time = 0;
    sounds_left = times - 1;
    sound_interval = interval;
    game.PlaySample(clip)
end

function do_sounds(deltaTime)
    if sound_clip == nil then
        return
    end

    sound_time = sound_time + deltaTime;
    if sound_time > sound_interval then
        sound_time = sound_time - sound_interval;
        game.PlaySample(sound_clip);
        sounds_left = sounds_left - 1
        if sounds_left <= 0 then
            sound_clip = nil
        end
    end
end

local last_song = nil

-- Update the current lobby
Tcp.SetTopicHandler("room.update", function(data)
    -- Update the users in the lobby
    lobby_users = {}
    local prev_all_ready = all_ready;
    all_ready = true
    for i, user in ipairs(data.users) do
        table.insert(lobby_users, user)
        if user.id == user_id then
            user_ready = user.ready
        end
        if not user.ready then
            all_ready = false
        end
    end

    if user_id == host and #data.users > 1 and all_ready and not prev_all_ready then
        repeat_sound("click-02", 3, .1)
    end

    if data.host == user_id and host ~= user_id then
        repeat_sound("click-02", 3, .1)
    end

    if data.song ~=nil and last_song ~=data.song then
        game.PlaySample("menu_click")
        last_song = data.song
    end
    host = data.host
    if data.owner then
        owner = data.owner
    else
        owner = host
    end
    hard_mode = data.hard_mode
    mirror_mode = data.mirror_mode
    do_rotate = data.do_rotate
    if data.start_soon and not start_game_soon then
        repeat_sound("click-01", 5, 1)
    end
    start_game_soon = data.start_soon

end)
end
