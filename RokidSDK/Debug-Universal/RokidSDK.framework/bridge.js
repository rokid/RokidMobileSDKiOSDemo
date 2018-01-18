function bridgeReq(moduleName, methodName, params, callback) {
  window.RokidWebBridge.jsToNative("request", moduleName, methodName, params, callback);
}

var taro = window.taro || {};

taro.Phone = new function() {
  var self = this;
  self.moduleName = "Phone";
  self.version = "1.0";
  self.Pasteboard = {
    set: function(text, callback) {
      bridgeReq(self.moduleName, "pasteboardSet", {
        "text": text
      }, callback);
    },
    get: function(callback) {
      bridgeReq(self.moduleName, "pasteboardGet", {}, callback);
    }
  };
  self.Socket = {
    sendUdp: function(host, port, data, callback) {
      bridgeReq(self.moduleName, "socketSendUdp", {
        "host": host,
        "port": port,
        "data": data
      }, callback);
    }
  };
}

taro.App = new function() {
  var self = this;
  self.moduleName = "App",
  self.version = "1.0",
  self.Account = {
    getInfo: function(callback) {
      bridgeReq(self.moduleName, "getUserInfo", {}, callback);
    }
  };
  self.Wifi = {
    getInfo: function(callback) {
      bridgeReq(self.moduleName, "getWifiInfo", {}, callback);
    }
  };
  self.Device = {
    switchDevice: function(auto_select, callback) {
      bridgeReq(self.moduleName, "switchDevice", auto_select ? {
        "auto_select": auto_select
      } : {}, callback);
    }
  };
}

taro.NativeUI = new function() {
  var self = this;
  self.moduleName = "View";
  self.version = "1.0";
  self.Toast = {
    show: function(message, callback) {
      bridgeReq(self.moduleName, "toast", {
        "message": message
      }, callback);
    }
  };
  self.Hub = {
    show: function(message, callback) {
      bridgeReq(self.moduleName, "hud", {
        "action": "show",
        "message": message
      }, callback);
    },
    hide: function() {
      bridgeReq(self.moduleName, "hud", {
        "action": "hide"
      }, callback);
    }
  };
  self.NavigationBar = {
    setInfo: function(title, style, buttons, callback) {
      bridgeReq(self.moduleName, "navigationBarInfo", {
        "title": title,
        "style": style,
        "buttons": buttons
      }, callback);
    },
    setRightDot: function(status, callback) {
      bridgeReq(self.moduleName, "navigatorBarRightDot", {
        "status": status
      }, callback);
    }
  };
}

taro.Media = new function() {
  var self = this;
  self.moduleName = "Media";
  self.version = "1.0";
  self.V1 = {
    buildBody: function(intent, params, callback) {
      bridgeReq(self.moduleName, "buildBody", {
        "intent": intent,
        "params": params
      }, callback);
    }
  };
  self.V3 = {
    buildRequest: function(appId, intent, params, callback) {
      bridgeReq(self.moduleName, "buildRequest", {
        "appId": appId,
        "intent": intent,
        "params": params
      }, callback);
    },
    control: function(appId, intent, dataType, index, items, callback) {
      bridgeReq(self.moduleName, "control", {
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
      bridgeReq(self.moduleName, "open", {
        "appId": appId,
        "url": url,
        "params": {
          "dataType": dataType,
          "id": id,
          "extend": extend
        }
      }, callback);
    }
  };
}

taro.OAuth = new function() {
  var self = this;
  self.moduleName = "OAuth";
  self.version = "1.0";
  self.wechatAuth = function(callbackURL, callback) {
    bridgeReq(self.moduleName, "wechatAuth", {
      "callbackURL": callbackURL
    }, callback);
  };
  self.qqAuth = function(callbackURL, callback) {
    bridgeReq(self.moduleName, "qqAuth", {
      "callbackURL": callbackURL
    }, callback);
  };
}

taro.SmartHome = new function() {
  var self = this;
  self.moduleName = "SmartHome";
  self.version = "1.0";
  self.MiHome = {
    auth: function(did, callbackURL, callback) {
      bridgeReq(self.moduleName, "miHomeAuth", {
        "did": did,
        "callbackURL": callbackURL
      }, callback);
    },
    bind: function(did, dsn, model, token, timestamp, callbackURL, callback) {
      bridgeReq(self.moduleName, "miHomeAuth", {
        "did": did,
        "dsn": dsn,
        "model": model,
        "token": token,
        "timestamp": timestamp ? timestamp : 0,
        "callbackURL": callbackURL
      }, callback);
    }
  };
}
