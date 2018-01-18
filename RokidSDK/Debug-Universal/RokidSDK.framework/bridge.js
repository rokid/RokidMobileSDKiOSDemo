function bridgeReq(moduleName, methodName, params, callback) {
  window.RokidWebViewBridge.jsToNative("request", moduleName, methodName, params, callback);
}

const likeBridge = {}

likeBridge.Phone = {
  version: "1.0",
  moduleName: "Phone",
  Pasteboard: {
    set: function(text, callback) {
      bridgeReq(likeBridge.Phone.moduleName, "pasteboardSet", {
        "text": text
      }, callback);
    },
    get: function(callback) {
      bridgeReq(likeBridge.Phone.moduleName, "pasteboardGet", {}, callback);
    }
  },
  Socket: {
    sendUdp: function(host, port, data, callback) {
      bridgeReq(likeBridge.Phone.moduleName, "socketSendUdp", {
        "host": host,
        "port": port,
        "data": data
      }, callback);
    }
  },
}

likeBridge.App = {
  version: "1.0",
  moduleName: "App",
  Account: {
    getInfo: function(callback) {
      bridgeReq(App.moduleName, "getUserInfo", {}, callback);
    }
  },
  Wifi: {
    getInfo: function(callback) {
      bridgeReq(App.moduleName, "getWifiInfo", {}, callback);
    }
  },
  Device: {
    switchDevice: function(auto_select, callback) {
      bridgeReq(App.moduleName, "switchDevice", auto_select ? {
        "auto_select": auto_select
      } : {}, callback);
    }
  }
}

likeBridge.NativeUI = {
  version: "1.0",
  moduleName: "View",
  Toast: {
    show: function(message, callback) {
      bridgeReq(NativeUI.moduleName, "toast", {
        "message": message
      }, callback);
    }
  },
  Hub: {
    show: function(message, callback) {
      bridgeReq(NativeUI.moduleName, "hud", {
        "action": "show",
        "message": message
      }, callback);
    },
    hide: function() {
      bridgeReq(NativeUI.moduleName, "hud", {
        "action": "hide"
      }, callback);
    }
  },
  NavigationBar: {
    setInfo: function(title, style, buttons, callback) {
      bridgeReq(NativeUI.moduleName, "navigationBarInfo", {
        "title": title,
        "style": style,
        "buttons": buttons
      }, callback);
    },
    setRightDot: function(status, callback) {
      bridgeReq(NativeUI.moduleName, "navigatorBarRightDot", {
        "status": status
      }, callback);
    }
  }
}

likeBridge.Media = {
  version: "1.0",
  moduleName: "Media",
  V1: {
    buildBody: function(intent, params, callback) {
      bridgeReq(Media.moduleName, "buildBody", {
        "intent": intent,
        "params": params
      }, callback);
    }
  },
  V3: {
    buildRequest: function(appId, intent, params, callback) {
      bridgeReq(Media.moduleName, "buildRequest", {
        "appId": appId,
        "intent": intent,
        "params": params
      }, callback);
    },
    control: function(appId, intent, dataType, index, items, callback) {
      bridgeReq(Media.moduleName, "control", {
        "appId": appId,
        "intent": intent,
        "params": {
          "dataType": dataType,
          "index": index,
          "items": items
        }
      }, callback);
    },
    open: function(appId, url, dataType, id, extend) {
      bridgeReq(Media.moduleName, "open", {
        "appId": appId,
        "url": url,
        "params": {
          "dataType": dataType,
          "id": id,
          "extend": extend
        }
      }, callback);
    }
  }
}

likeBridge.OAuth = {
  version: "1.0",
  moduleName: "OAuth",
  wechatAuth: function(callbackURL, callback) {
    bridgeReq(OAuth.moduleName, "wechatAuth", {
      "callbackURL": callbackURL
    }, callback);
  },
  qqAuth: function(callbackURL, callback) {
    bridgeReq(OAuth.moduleName, "qqAuth", {
      "callbackURL": callbackURL
    }, callback);
  }
}

likeBridge.SmartHome = {
  version: "1.0",
  moduleName: "SmartHome",
  MiHome: {
    auth: function(did, callbackURL, callback) {
      bridgeReq(SmartHome.moduleName, "miHomeAuth", {
        "did": did,
        "callbackURL": callbackURL
      }, callback);
    },
    bind: function(did, dsn, model, token, timestamp, callbackURL, callback) {
      bridgeReq(SmartHome.moduleName, "miHomeAuth", {
        "did": did,
        "dsn": dsn,
        "model": model,
        "token": token,
        "timestamp": timestamp ? timestamp : 0,
        "callbackURL": callbackURL
      }, callback);
    }
  }
}
