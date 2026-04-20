local connect = require(script.connect)
return {
    StoreProvider = require(script.StoreProvider);
    connect = connect;
    UNSTABLE_connect2 = connect;
}