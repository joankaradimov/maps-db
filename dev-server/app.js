'use strict';

const liveServer = require("live-server");

liveServer.start({
    host: 'localhost',
    port: 8080,
    root: "../mapsdb",
    wait: 500, // Waits for all changes, before reloading. Defaults to 0 sec.
    logLevel: 2, // 0 = errors only, 1 = some, 2 = lots
});
