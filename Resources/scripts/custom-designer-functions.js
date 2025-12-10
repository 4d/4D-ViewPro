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

customDesignerFunctions.getFirstCustomFunctionName = function () {
  const list = Utils.customFunctionNames;
  if (list.length == 0) {
    return "ABS" // just none
  }
  list.sort();
  return list[0];
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
    var TemplateNames = GC.Spread.Sheets.Designer.TemplateNames;

    // console.log("Remove 'export JS file' button from interface")
    var template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.FileMenuPanelTemplate);
    // Try the known path first
    let removed = false;
    try {
      const exportSSJsonPanel = template.content[0].children[0].children[1].children[2].children[1].children[1].children[0].children;
      
      if (exportSSJsonPanel && Array.isArray(exportSSJsonPanel)) {
        const buttonIndex = exportSSJsonPanel.findIndex(child => 
          child && child.bindingPath === "button_export_javascript"
        );
        
        if (buttonIndex !== -1) {
          // console.log("Found 'export JS file' button at known path, index:", buttonIndex);
          exportSSJsonPanel.splice(buttonIndex, 1);
          // console.log("Successfully removed 'export JS file' button!");
          removed = true;
        }
      }
    } catch (error) {
      console.warn("Remove 'export JS file' button from interface: Known path not accessible:", error.message);
    }

    // If not found at known path, search recursively
    if (!removed) {
      console.warn("Button not found at known path, searching entire template...");
      
      function findAndRemoveButton(obj, path = "") {
        if (!obj || typeof obj !== 'object') return null;
        
        if (Array.isArray(obj)) {
          for (let i = 0; i < obj.length; i++) {
            if (obj[i] && obj[i].bindingPath === "button_export_javascript") {
              const foundPath = path + "[" + i + "]";
              console.error("ALERT: Button found at NEW PATH:", foundPath);
              console.error("Please update the code with this new path!");
              console.log("Button object:", obj[i]);
              obj.splice(i, 1);
              console.log("Successfully removed 'export JS file' button!");
              return foundPath;
            }
            const result = findAndRemoveButton(obj[i], path + "[" + i + "]");
            if (result) return result;
          }
        } else {
          for (let key in obj) {
            if (obj.hasOwnProperty(key)) {
              const result = findAndRemoveButton(obj[key], path + "." + key);
              if (result) return result;
            }
          }
        }
        return null;
      }

      removed = findAndRemoveButton(template, "template");
      if (!removed) {
        console.error("ERROR: 'export JS file' button with bindingPath 'button_export_javascript' not found in entire template!");
      }
    }
    if (removed) {
      GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.FileMenuPanelTemplate, template);
    }

    // console.log("Add custom functions to the custom section of the insert function dialog")
    template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.InsertFunctionDialogTemplate);
    try {
      const prop$8 = (o, o1) => `${o}.${o1}`;
      template.content[0].children[0].children[1].children[1].children.unshift({
        type: "List",
        visibleWhen: prop$8("functionDesc", "functionCategory") + "=" + String(template.content[0].children[0].children[1].children[1].children.length),
        bindingPath: prop$8("functionDesc", "customFunction"),
        items: customDesignerFunctions.getCustomFunctionsList(),
        keyboardSearch: true,
        dblClickSubmit: true
      });
      template.content[0].children[0].children[0].children[1].items.sort(function (a, b) {
        return a.text.localeCompare(b.text);
      });
      GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.InsertFunctionDialogTemplate, template);
    } catch (error) {
      console.warn("Add custom functions to the custom section: ", error.message);
    }
    template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.InsertFunctionAllowDynamicArrayDialogTemplate);
    try {
      const prop$8 = (o, o1) => `${o}.${o1}`;
      template.content[0].children[0].children[1].children[1].children.unshift({
        type: "List",
        visibleWhen: prop$8("functionDesc", "functionCategory") + "=" + String(template.content[0].children[0].children[1].children[1].children.length),
        bindingPath: prop$8("functionDesc", "customFunction"),
        items: customDesignerFunctions.getCustomFunctionsList(),
        keyboardSearch: true,
        dblClickSubmit: true
      });
      template.content[0].children[0].children[0].children[1].items.sort(function (a, b) {
        return a.text.localeCompare(b.text);
      });
      GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.InsertFunctionAllowDynamicArrayDialogTemplate, template);
    } catch (error) {
      console.warn("Add custom functions to the custom dynamic section: ", error.message);
    }

    template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.FormatDialogTemplate);
    try {
      if(template.content[0].width<720)
      {
        template.content[0].width = 720;
      }
      GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.FormatDialogTemplate, template);
    } catch (error) {
      console.warn("Change format dialog width failed: ", error.message);
    }


    // todo localize stuff here?
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