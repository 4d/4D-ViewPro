class customDesignerFunctions { }

customDesignerFunctions.saveAs = function (blob, fileName, allowAll) {
  const reader = new FileReader();
  reader.readAsDataURL(blob);
  reader.onloadend = function () {
    const content = reader.result.substr(reader.result.indexOf(',') + 1);
    $4d._vp_saveFile(content, fileName, allowAll, function (ret, err) {
      if (err) {
        console.log(err);
      } else {
        console.log(ret);
      }
    });
  };
};

customDesignerFunctions.computePdfFonts = function (sheetIndex, callback) {
  Utils.computePdfFonts(sheetIndex, callback);
};

customDesignerFunctions.localizedCommandList = function (list) {
  if (list == null) {
    console.log("Passed command list is empty");
    console.log(new Error().stack);
    return null;
  }
  if (typeof list === 'function') {
    console.log("Passed command list is a function instead of Array. Please fix. (Function will be called)");
    console.log(new Error().stack);
    list = list();
  }
  const mapping = GC.Spread.CalcEngine.getMapping();

  if (mapping != null) {
    const mapper = mapping.builtInFunctionsMapping;

    list.forEach(i => {
      if ((i.value in mapper) && ('alias' in mapper[i.value])) {
        i.text = mapper[i.value].alias;
      }
    });
  }

  list.sort(function (a, b) {
    return a.text.localeCompare(b.text);
  });

  return list;
};

customDesignerFunctions.localizedCommandName = function (name, lower) {
  const mapping = GC.Spread.CalcEngine.getMapping();

  name = name.toUpperCase();

  if (mapping != null) {
    const mapper = mapping.builtInFunctionsMapping;

    if (name in mapper) {
      name = mapper[name].alias;
    }
  }

  if (lower) {
    name = name.charAt(0).toUpperCase() + name.slice(1).toLowerCase();
  }

  return name;
};

customDesignerFunctions.spreadFrom4vp = function (data) {
  if ((data != null) && (typeof data === "object") && ("spreadJS" in data)) {
  //  vp_resetOptimizer();
    return data.spreadJS;
  } else return null;
};

customDesignerFunctions.spreadTo4vp = function (data) {
  Utils.addFormatedText(data);
  const vpFile = {};
  vpFile.version = 1;
  const d = new Date;
  vpFile.dateCreation = d.toISOString();
  vpFile.dateModified = d.toISOString();
  vpFile.spreadJS = data;
  return vpFile;
};

customDesignerFunctions.notifyReady = function () {
  const loaders = document.getElementsByClassName("loading-placeholder");
  loaders[0].hidden = true;
  loaders[1].hidden = true;
  designerReady = true;
};

customDesignerFunctions.initEvents = function (newSpread) {
  spread = newSpread;
  Utils.initEvents();
  Utils.initCommands();
};

customDesignerFunctions.getCustomFunctionsList = function () {
  const list = Utils.customFunctionNames;
  list.sort();
  return list.map(r => {
    return {
      text: r,
      value: r
    };
  });
};

customDesignerFunctions.fillWithArraySystemFonts = function () {
  return vp_fonts.map(val => { return { text: val, value: val }; });
};

customDesignerFunctions.fillWithTruncatedArraySystemFonts = function () {
  return vp_fonts.map(val => {
    const value = val.replace(/"/g, '');
    return { text: value, value: val };
  });
};

customDesignerFunctions.handlerExportCsvSetting = function (setting) {
      var rowDelimiter = (setting.rowDelimiter || "\r");
      let columnDelimiter = setting.columnDelimiter || ",";
      setting.rowDelimiter = rowDelimiter.replace(/\\r/g, "\r").replace(/\\n/g, "\n").replace(/\\t/g, "\t");
      setting.columnDelimiter = columnDelimiter.replace(/\\r/g, '\r').replace(/\\n/g, '\n').replace(/\\t/g, '\t');
};


customDesignerFunctions.init = function () {
  /*
  let moduleSupportedFunctions = exported_modules.c["./src/commands/ribbon/formulas/functions/supportedFunctions/supportedFunctions.ts"].exports;
  moduleSupportedFunctions.allFunctionItems = moduleSupportedFunctions.allFunctionItems.concat(customDesignerFunctions.getCustomFunctionsList());
  moduleSupportedFunctions.allFunctionItems.sort(function (a, b) {
    return a.text.localeCompare(b.text);
  });

  let moduleInsertFunctionDialog = exported_modules.c["./src/commands/ribbon/formulas/functionHandler/insertFunctionDialog.tpl.ts"].exports;
   moduleInsertFunctionDialog.insertFunctionDialogTemplate.content[0].children[0].children[1].children[1].children[13].items = customDesignerFunctions.getCustomFunctionsList();
  moduleInsertFunctionDialog.insertFunctionDialogTemplate.content[0].children[0].children[1].children[1].children[0].items = moduleSupportedFunctions.allFunctionItems;
  */

   // add custom functions to the custom section of the insert function dialog

    console.log("inject custom function in panel")

    var InsertFunctionDialogTemplate = "insertFunctionDialogTemplate" // TemplateNames.InsertFunctionDialogTemplate
    var template = GC.Spread.Sheets.Designer.getTemplate(InsertFunctionDialogTemplate);
      const prop$8 = (o, o1) => `${o}.${o1}`;
    // TODO BETTER: inject new ones
    //template.content[0].children[0].children[1].children[1].children[12].items = customDesignerFunctions.getCustomFunctionsList();
    template.content[0].children[0].children[1].children[1].children.push({
      type: "List",
      visibleWhen: prop$8("functionDesc", "functionCategory") + "=14",
      bindingPath: prop$8("functionDesc", "customFunction"),
      items: customDesignerFunctions.getCustomFunctionsList(),
      keyboardSearch: true,
      dblClickSubmit: true
    });

    // todo localize stuff here?
    GC.Spread.Sheets.Designer.registerTemplate("insertFunctionDialogTemplate", template);
};

 class ViewProAppBase {
    constructor() {
        this._ms = [ null, null, () => { return 0 }, () => {} ];
    }
    notifyReady() {
        customDesignerFunctions.notifyReady();  
    }
    showOpenDialog(options) {
        return Promise.reject({
            status: "",
            fileName: ""
        });
    }
    open(fileName) {
        return {
            status: "",
            message: "",
            data: "",
            fileName: ""
        };
    }
    save(fileName, data2, isJSFile) {
        // customDesignerFunctions.saveAs
        return failed;
    }
    exit() {}
    importFile(fileName, options) {
        return Promise.resolve(failed);
    }
    showSaveDialog(options) {
        return cancelled;
    }
    exportFile(fileName, data2) {
        return Promise.resolve(failed);
    }
    needActive() {
        return true;
    }
    setClipboardData(data2) {}
    getClipboardText() {
        return "";
    }
    getBase64(fileName) {
        return "";
    }
    getClipboardHTML() {
        return "";
    }
    getSystemFonts() {
        return customDesignerFunctions.fillWithTruncatedArraySystemFonts();
    }
    closeAllWindows() {}
    setClipboardText(text) {}
    setClipboardHTML(string) {}
    getFileInfo(fullPath) {
        // dir, fileName
        return {};
    }
    joinPath(segments) {
        return segments && segments.toString();
    }
    config(name, value) {
        if (value === void 0) {
            return this.getConfig(name);
        } else {
            this.setConfig(name, value);
            return osEnv;
        }
    }
    getConfig(name) {
        this.initConfig(true);
        let path = name.split(".");
        let value = this._config;
        if (value) {
            for (let i = 0; i < path.length; i++) {
                let sub = value[path[i]];
                if (sub === void 0) {
                    return void 0;
                }
                value = sub;
            }
            if (name === _createdDateKey) {
                let n = parseInt(value, 36);
                return isNaN(n) ? null : new Date(n);
            }
            return value;
        } else {
            return void 0;
        }
    }
    initConfig(onget) {
        if (this._config === void 0) {
            this._config = {};
        }
    }
    setConfig(name, value) {
        this.initConfig(false);
        let path = name.split(".");
        let item = this._config;
        if (item) {
            for (let i = 0; i < path.length - 1; i++) {
                let sub = item[path[i]];
                if (sub === void 0) {
                    item[path[i]] = sub = {};
                }
                item = sub;
            }
            item[path[path.length - 1]] = value;
        }
    }
    restartApp() {}
}

window.osenv = new ViewProAppBase();
window.gc_native_app = true;