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
   vp_insertFunctionDialogTemplate.content[0].children[0].children[1].children[1].children[13].items = customDesignerFunctions.getCustomFunctionsList();

    const TemplateNames = GC.Spread.Sheets.Designer.TemplateNames;
    let template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.FindDialogTemplate);
    try {
      if (customDesignerFunctions.fitFindDialogTemplate(template)) {
        GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.FindDialogTemplate, template);
      }
    } catch (error) {
      console.warn("Change find dialog width failed: ", error.message);
    }

    customDesignerFunctions.localizeCommandPalettePlaceholder();
};

// The columns of the find dialog have fixed widths made for the english texts:
// widen them when the localized texts are longer, so they do not overlap
customDesignerFunctions.fitFindDialogTemplate = function (template) {
  // a direct child of the designer container has the font of the designer dialogs (.gc-designer-container.en>div)
  const measure = document.createElement("div");
  measure.style.cssText = "position:absolute;visibility:hidden;white-space:nowrap;width:auto";
  (document.querySelector(".gc-designer-container") || document.body).appendChild(measure);
  const textWidth = function (text) {
    measure.textContent = text;
    return Math.ceil(measure.getBoundingClientRect().width);
  };

  const columns = { label: [], combo: [], check: [[], []], input: [], spacerWithOption: [], spacerWithoutOption: [] };
  const collect = function (node) {
    if (!node || typeof node !== "object") return;
    if (node.type === "ColumnSet") {
      let checkIndex = 0;
      for (const column of node.children) {
        const child = column.children && column.children[0];
        if (!child) {
          (/=true$/.test(column.visibleWhen) ? columns.spacerWithOption : columns.spacerWithoutOption).push(column);
        } else if (child.type === "TextBlock") {
          columns.label.push(column);
        } else if (child.type === "ListComboEditor") {
          columns.combo.push(column);
        } else if (child.type === "CheckBox") {
          columns.check[checkIndex++].push(column);
        } else if (child.type === "TextEditor") {
          columns.input.push(column);
        }
      }
      return;
    }
    Object.values(node).forEach(collect);
  };
  collect(template.content);

  // extra width needed by a kind of column: text + what the column shows around it (check box, combo arrow)
  const extraWidth = function (list, texts, around) {
    let extra = 0;
    for (const column of list) {
      const needed = Math.max(...texts(column.children[0]).map(textWidth)) + around;
      extra = Math.max(extra, needed - parseInt(column.width, 10));
    }
    return extra;
  };
  const label = extraWidth(columns.label, (child) => [child.text], 8);
  const combo = extraWidth(columns.combo, (child) => child.items.map((item) => item.text), 32);
  const check0 = extraWidth(columns.check[0], (child) => [child.text], 36);
  const check1 = extraWidth(columns.check[1], (child) => [child.text], 36);
  measure.remove();

  if (label + combo + check0 + check1 === 0) {
    return false;
  }
  // keep the rows aligned on the right: the input and the spacers before the option button absorb the other columns
  const widen = function (list, delta) {
    list.forEach((column) => { column.width = (parseInt(column.width, 10) + delta) + "px"; });
  };
  widen(columns.label, label);
  widen(columns.combo, combo);
  widen(columns.check[0], check0);
  widen(columns.check[1], check1);
  widen(columns.input, combo + check0 + check1);
  widen(columns.spacerWithOption, check0 + check1);
  widen(columns.spacerWithoutOption, label + combo + check0 + check1);
  return true;
};

// The designer reads the command palette placeholder before our localized resources are set:
// set it when the command palette is opened
customDesignerFunctions.localizeCommandPalettePlaceholder = function () {
  const placeholder = GC.Spread.Sheets.Designer.getResources().commandPalette.placeholder;
  const selector = ".gc-command-palette-search-container input";
  const observer = new MutationObserver(function (mutations) {
    for (const mutation of mutations) {
      for (const node of mutation.addedNodes) {
        if (node.nodeType !== Node.ELEMENT_NODE) continue;
        const input = node.matches(selector) ? node : node.querySelector(selector);
        if (input && input.placeholder !== placeholder) {
          input.placeholder = placeholder;
        }
      }
    }
  });
  observer.observe(document.body, { childList: true, subtree: true });
};
