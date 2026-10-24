-- IR State enum
---@class States
local States = {
    Unused = 0,
    Pending = 10,
    Success = 20,
    Accepted = 22,
    BadRequest = 40,
    Unauthorized = 41,
    ChartRefused = 42,
    Forbidden = 43,
    NotFound = 44,
    ServerError = 50,
    RequestFailure = 60
}

---@class IRData
---@field Active boolean # USC IR configured and active
---@field States States # IR reposonse state enum
IRData = {}

---@class IRHeartbeatResponseBody
---@field serverTime integer
---@field serverName string
---@field irVersion string

---@class IRRecordResponseBody
---@field record ServerScore

---@alias IRLeaderboardResponseBody ServerScore[]

---@class IRResponse
---@field statusCode integer
---@field description string

---@class IRHeartbeatResponse : IRResponse
---@field body IRHeartbeatResponseBody

---@class IRChartTrackedResponse : IRResponse
---@field body {}

---@class IRRecordResponse : IRResponse
---@field body IRRecordResponseBody

---@class IRLeaderboardResponse : IRResponse
---@field body ServerScore[]

-- Performs a Heartbeat request.
---@param callback fun(res: IRHeartbeatResponse) # Callback function receives IRResponse as it's first parameter
local function Heartbeat(callback) end

-- Performs a Chart Tracked request for the chart with the provided hash.
---@param hash string # song hash
---@param callback fun(res: IRChartTrackedResponse) # Callback function receives IRResponse as it's first parameter
local function ChartTracked(hash, callback) end

-- Performs a Record request for the chart with the provided hash.
---@param hash string # song hash
---@param callback fun(res: IRRecordResponse) # Callback function receives IRResponse as it's first parameter
local function Record(hash, callback) end

-- Performs a Leaderboard request for the chart with the provided hash, with parameters mode and n.
---@param hash string # song hash
---@param mode "best"|"rivals" # request leaderboard mode
---@param n integer # limit the number of requested scores
---@param callback fun(res: IRLeaderboardResponse) # Callback function receives IRResponse as it's first parameter
local function Leaderboard(hash, mode, n, callback) end

---@class IR
IR = {
    Heartbeat = Heartbeat,
    ChartTracked = ChartTracked,
    Record = Record,
    Leaderboard = Leaderboard
}
