-- challengeresult `result` table

---@diagnostic disable:lowercase-global
---@diagnostic disable:missing-return

---@class ChallengeHitStat
---@field timeFrac number -- Fraction of when in the chart the note was hit, `0.0` to `1.0`
---@field lane integer -- `0` = A, `1` = B, `2` = C, `3` = D, `4` = L, `5` = R, `6` = Left Laser, `7` = Right Laser
---@field time integer -- When in the chart the note was hit, in milliseconds
---@field delta integer -- Delta value of the hit from 0
---@field rating integer -- `0 = Miss`, `1 = Near`, `2 = Crit`

---@class ChallengeHitWindow
---@field good integer # Near window, default `92`
---@field hold integer -- Hold window, default `138`
---@field miss integer -- Miss window, default `250`
---@field perfect integer -- Critical window, default `46`
---@field slam integer -- Slam window, default `84`
---@field type integer -- `1 = Normal` default, `2 = Hard` default values halved

---@class ChartResultScore
---@field auto_flags integer # Autoplay flag
---@field badge integer # `0` = Manual Exit, `1` = Played, `2` = Cleared, `3` = Hard Cleared, `4` = Full Chain, `5` = Perfect Chain
---@field combo integer # Best combo reached
---@field earlies integer # Total early hits
---@field gauge number # Ending gauge percentage, `0.0` to `1.0`
---@field gauge_option integer # Gauge option e.g. ARS
---@field gauge_type integer # `0` = Normal, `1` = Hard, `2` = Permissive, `3` = Blastive
---@field goods integer # Total near hits
---@field hitWindow ChallengeHitWindow # Hit windows of the score
---@field lates integer # Total late hits
---@field mirror integer # Mirror mode flag
---@field misses integer # Total errors
---@field perfects integer # Total critical hits
---@field random integer # Random mode flag
---@field score integer # Result score
---@field timestamp integer # Unix timestamp of the score

---@class ChartResult
---@field artist string # Chart artist
---@field autoplay boolean # Autoplay bool, always false
---@field auto_flags integer # Autoplay flag
---@field badge integer # `0` = Manual Exit, `1` = Played, `2` = Cleared, `3` = Hard Cleared, `4` = Full Chain, `5` = Perfect Chain
---@field bpm number # Chart BPM
---@field difficulty integer # Difficulty index
---@field duration integer # Chart duration, in milliseconds
---@field earlies integer # Total early hits
---@field effector string # Chart effector
---@field failReason string # Reason for failing the chart
---@field gauge number # Ending gauge percentage, `0.0` to `1.0`
---@field gaugeSamples number[] # Gauge values sampled (256 total) throughout the play
---@field gauge_option integer # Gauge option e.g. ARS
---@field gauge_type integer # `0` = Normal, `1` = Hard, `2` = Permissive, `3` = Blastive
---@field goods integer # Total near hits
---@field grade string # Result grade
---@field highScores ChartResultScore[] # All scores
---@field hitWindow ChallengeHitWindow # Result hit windows
---@field illustrator string # Chart jacket illustrator
---@field isSelf boolean # Always true
---@field jacketPath string # Full filepath to the jacket image on the disk
---@field lates integer # Total late hits
---@field level integer # Chart level
---@field maxCombo integer # Result max chain
---@field meanHitDelta number # Mean hit delta
---@field meanHitDeltaAbs number # Absolute value of mean hit delta
---@field medianHitDelta integer # Median hit delta
---@field medianHitDeltaAbs integer # Absolute value of median hit delta
---@field mirror boolean # Mirror mode bool
---@field misses integer # Total errors
---@field mission string # Always empty string
---@field noteHitStats ChallengeHitStat[] # Hit stats for every chip hit
---@field passed boolean # Chart passed
---@field percent integer # Chart challenge percent
---@field perfects integer # Total critical hits
---@field playbackSpeed number # Always 1.0
---@field random boolean # Random mode bool,
---@field realTitle string # Chart title, always without player name
---@field retryCount integer # Always 0
---@field score integer # Result score
---@field speedModType integer # `0` = XMOD, `1` = MMOD, `2` = CMOD
---@field speedModValue number # `HiSpeed` for `XMOD`, `ModSpeed` otherwise
---@field title string # Chart title

---@class ChallengeResult
---@field avgCrits integer # Average number of critical hits across the charts
---@field avgErrors integer # Average number of error hits across the charts
---@field avgGauge number # Average gauge percentage across the charts
---@field avgNears integer # Average number of near hits of the charts
---@field avgPercentage integer # Average completion percentage across the charts
---@field avgScore integer # Average score across the charts
---@field badge integer # `0` = Manual Exit, `1` = Played, `2` = Cleared, `3` = Hard Cleared, `4` = Full Chain, `5` = Perfect Chain
---@field charts ChartResult[] # array of result information for all played charts (note: might not be all charts in course)
---@field failReason string # Reason for failing the challenge
---@field grade string # Result grade
---@field isSelf boolean # Always true
---@field level integer # Chart or challenge level
---@field overallCrits integer # Total number of critical hits across the charts
---@field overallErrors integer # Total number of error hits across the charts
---@field overallNears integer # Total number of near hits across the charts
---@field passed boolean # Whether or not the challenge was passed
---@field requirement_text string # The challenge requirements separated by newline character `"\n"`
---@field title string # Challenge title

---Render, called every frame
---@param deltaTime number # time in seconds between frames
---@param showStats boolean # true when left FX is pressed
render = function (deltaTime, showStats) end

---This is called right after result is set, either for initial display or when the player whose score is being displayed is changed.
result_set = function () end

---The region of the screen to be saved in score screenshots.
---@return number x # top left X coordinate
---@return number y # top left Y coordinate
---@return number w # width
---@return number h # height
get_capture_rect = function () end

---Called when a screenshot has been captured successfully.
---@param path string # path to the saved screenshot
screenshot_captured = function (path) end
