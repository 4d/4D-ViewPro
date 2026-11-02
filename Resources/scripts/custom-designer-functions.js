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

  try {
    const TemplateNames = GC.Spread.Sheets.Designer.TemplateNames;
    const template = GC.Spread.Sheets.Designer.getTemplate(TemplateNames.FindDialogTemplate);
    if (template && customDesignerFunctions.fitFindDialogTemplate(template)) {
      GC.Spread.Sheets.Designer.registerTemplate(TemplateNames.FindDialogTemplate, template);
    }
  } catch (error) {
    console.warn("Change find dialog width failed: ", error.message);
  }
};

// The columns of the find dialog (SpreadJS 17.1) have fixed widths made for the english texts:
// widen them when the localized texts are longer, so they do not overlap.
// Layout of each tab:
//   rows "Find what" / "Replace with": [label 80px][text editor 380px]
//   option row: [380px column > Container (option=true) > 3 rows [label 80px][combo 120px][check box, auto]][option button]
customDesignerFunctions.fitFindDialogTemplate = function (template) {
  // a direct child of the designer container has the font of the designer dialogs
  const measure = document.createElement("div");
  measure.style.cssText = "position:absolute;visibility:hidden;white-space:nowrap;width:auto";
  (document.querySelector(".gc-designer-container") || document.body).appendChild(measure);
  const textWidth = function (text) {
    measure.textContent = text;
    return Math.ceil(measure.getBoundingClientRect().width);
  };
  const widthOf = function (column) {
    return parseInt(column.width, 10);
  };

  const columns = { label: [], combo: [], check: [], input: [], option: [] };
  const collect = function (node) {
    if (!node || typeof node !== "object") return;
    if (node.type === "Column" && Array.isArray(node.children) && node.children.length > 0) {
      const child = node.children[0];
      if (child.type === "TextBlock" && !isNaN(widthOf(node))) {
        columns.label.push(node);
      } else if (child.type === "ListComboEditor" && !isNaN(widthOf(node))) {
        columns.combo.push(node);
      } else if (child.type === "CheckBox") {
        columns.check.push(node);
      } else if (child.type === "TextEditor" && !isNaN(widthOf(node))) {
        columns.input.push(node);
      } else if (child.type === "Container" && /=true$/.test(child.visibleWhen || "") && !isNaN(widthOf(node))) {
        columns.option.push(node);
      }
    }
    Object.values(node).forEach(collect);
  };
  collect(template.content);

  let label = 0, combo = 0, check = 0;
  try {
    // extra width needed by a kind of column: text + what the column shows around it (combo arrow, check box)
    const extraWidth = function (list, texts, around, available) {
      let extra = 0;
      for (const column of list) {
        const needed = Math.max(0, ...texts(column.children[0]).map(textWidth)) + around;
        extra = Math.max(extra, needed - available(column));
      }
      return extra;
    };
    label = extraWidth(columns.label, (child) => [child.text || ""], 8, widthOf);
    combo = extraWidth(columns.combo, (child) => (child.items || []).map((item) => item.text || ""), 32, widthOf);
    // check boxes take what the option column leaves after the label and the combo
    const optionWidth = columns.option.length > 0 ? Math.min(...columns.option.map(widthOf)) : NaN;
    const labelWidth = columns.label.length > 0 ? Math.max(...columns.label.map(widthOf)) : 0;
    const comboWidth = columns.combo.length > 0 ? Math.max(...columns.combo.map(widthOf)) : 0;
    if (!isNaN(optionWidth)) {
      check = extraWidth(columns.check, (child) => [child.text || ""], 24, () => optionWidth - labelWidth - comboWidth);
    }
  } finally {
    measure.remove();
  }

  if (label + combo + check === 0) {
    return false;
  }
  const widen = function (list, delta) {
    list.forEach((column) => { column.width = (widthOf(column) + delta) + "px"; });
  };
  // keep the rows aligned on the right: the text editors grow with the option rows
  widen(columns.label, label);
  widen(columns.combo, combo);
  widen(columns.option, label + combo + check);
  widen(columns.input, combo + check);
  return true;
};
