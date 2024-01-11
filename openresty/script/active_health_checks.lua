init_worker_by_lua_block {
local hc = require "resty.upstream.healthcheck"

local ok, err = hc.spawn_checker {
    shm = "myhealthcheck", -- defined by "lua_shared_dict"
    upstream = "uk-backend", -- defined by "upstream"
    type = "http",

    http_req = "GET / HTTP/1.0\r\nHost: localhost\r\n\r\n",
    -- raw HTTP request for checking

    interval = 5000, -- run the check cycle every 3 sec
    timeout = 3000, -- 3 sec is the timeout for network operations
    fall = 1, -- # of successive failures before turning a peer down
    rise = 1, -- # of successive successes before turning a peer up
    valid_statuses = { 200 }, -- a list valid HTTP status code
    concurrency = 10, -- concurrency level for test requests
}

ok, err = hc.spawn_checker {
    shm = "myhealthcheck", -- defined by "lua_shared_dict"
    upstream = "us-backend", -- defined by "upstream"
    type = "http",

    http_req = "GET / HTTP/1.0\r\nHost: localhost\r\n\r\n",
    -- raw HTTP request for checking

    interval = 5000, -- run the check cycle every 3 sec
    timeout = 3000, -- 3 sec is the timeout for network operations
    fall = 1, -- # of successive failures before turning a peer down
    rise = 1, -- # of successive successes before turning a peer up
    valid_statuses = { 200 }, -- a list valid HTTP status code
    concurrency = 10, -- concurrency level for test requests
}

ok, err = hc.spawn_checker {
    shm = "myhealthcheck", -- defined by "lua_shared_dict"
    upstream = "rest-world", -- defined by "upstream"
    type = "http",

    http_req = "GET / HTTP/1.0\r\nHost: localhost\r\n\r\n",
    -- raw HTTP request for checking

    interval = 5000, -- run the check cycle every 3 sec
    timeout = 3000, -- 3 sec is the timeout for network operations
    fall = 1, -- # of successive failures before turning a peer down
    rise = 1, -- # of successive successes before turning a peer up
    valid_statuses = { 200 }, -- a list valid HTTP status code
    concurrency = 10, -- concurrency level for test requests
}

if not ok then
    ngx.log(ngx.ERR, "failed to spawn health checker: ", err)
    return
end
}