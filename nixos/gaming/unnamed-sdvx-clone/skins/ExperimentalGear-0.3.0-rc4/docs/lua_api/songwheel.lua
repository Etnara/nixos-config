---@diagnostic disable: lowercase-global
-- songwheel `songwheel` table

---@class SongWheelScore
---@field auto_flags integer # Autoplay flag
---@field badge integer # `0` = Manual Exit, `1` = Played, `2` = Cleared, `3` = Hard Cleared, `4` = Full Chain, `5` = Perfect Chain
---@field combo integer # Max combo
---@field earlies integer # Total early hits
---@field gauge number # Ending gauge percentage, `0.0` to `1.0`
---@field gauge_option integer # Gauge option e.g. ARS
---@field gauge_type integer # `0` = Normal, `1` = Hard, `2` = Permissive, `3` = Blastive
---@field goods integer # Total near hits
---@field isLocal integer # `0` = false, `1` = true
---@field lates integer # Total late hits
---@field mirror integer # Mirror mode flag
---@field misses integer # Total errors
---@field playerName string # Name of the player
---@field perfects integer # Total critical hits
---@field random integer # Random mode flag
---@field score integer # Result score
---@field timestamp integer # Unix timestamp of the score
SongWheelScore = {}

---@class SongWheelDifficulty
---@field difficulty integer # Difficulty index
---@field effector string # Name of charter
---@field hash string # Difficulty hash
---@field id integer # Difficulty id, unique static identifier
---@field illustrator string # Difficulty jacket illustrator
---@field jacketPath string # Full filepath to the jacket image on the disk
---@field level integer # Difficulty level
---@field scores SongWheelScore[] # Scores for the current difficulty
---@field topBadge integer # `0 = Never Played`, `1 = Played`, `2 = Cleared`, `3 = Hard Cleared`, `4 = Full Chain`, `5 = Perfect Chain`
SongWheelDifficulty = {}

---@class SongWheelSong
---@field artist string # Chart artist
---@field difficulties SongWheelDifficulty[] # Array of difficulties for the current song
---@field bpm string # Chart BPM
---@field id integer # Song id, unique static identifier
---@field path string # Full filepath to the chart folder on the disk
---@field title string # Chart title
SongWheelSong = {}

---@class songwheel
---@field allSongs SongWheelSong[] # Array of all available songs
---@field searchInputActive boolean # Search status
---@field searchStatus string # Current song database status
---@field searchText string # Search input text
---@field songs SongWheelSong[] # Array of songs with the current filters/sorting applied
songwheel = {}

---Render, called every frame
---@param deltaTime number # time in seconds between frames
render = function (deltaTime) end

---Called when selected difficulty changes
---@param diff integer # Difficulty level
set_diff = function (diff) end

---Called when song database changes
---@param withAll boolean # Reload all songs
songs_changed = function (withAll) end
