/*!
 *
 * 4DView Pro library 0.0.0
 *
 * Copyright(c) 4D SAS.  All rights reserved.
 *
 * 4D (the "Software") and the corresponding source code remain
 * the exclusive property of 4D and/or its licensors and are protected by national
 * and/or international legislations.
 *
 * This file is part of the source code of the Software provided under the relevant
 * 4D License Agreement available on http://www.4D.com/license whose compliance
 * constitutes a prerequisite to any use of this file and more generally of the
 * Software and the corresponding source code.
 *
 */

function _vp_do_callback(params) {
  if ((Utils.customFunctionsInProgress > 0) && (params.command.startsWith("import")) ) {
    setTimeout(() => {
      if (Utils.customFunctionsLog) {
        console.log("Postpone callback after import: " + JSON.stringify(params));
        if (Utils.customFunctionsLogStack) {
          console.log(new Error().stack);
        }
      }
      _vp_do_callback(params);
    }, Utils.customFunctionsCheckDelay);
  }
  else {
    if (Utils.customFunctionsLog) {
      console.log("Callback: " + JSON.stringify(params));
      if (Utils.customFunctionsLogStack) {
          console.log(new Error().stack);
      }
    }
    $4d._vp_callback(params);
  }
}

function _vp_callback(params) {
  if (params.command.startsWith("import")) {
    Utils.importInProgress -= 1;
  } else {
    Utils.exportInProgress -= 1;
  }
  setTimeout(() => {
    _vp_do_callback(params);
  }, Utils.customFunctionsDelayBeforeCheck);
}

Utils.addCommand('import-json', function (params) {
  Utils.currentDocument = {};
  const doc = params.doc;

  if (doc.version) Utils.currentDocument.d4Version = doc.version;
  if (doc.dateCreation) Utils.currentDocument.d4DateCreation = doc.dateCreation;
  if (doc.dateModified) Utils.currentDocument.d4DateModified = doc.dateModified;
  if (doc.meta) Utils.currentDocument.d4Meta = doc.meta;

  const deserializationOptions = {};
  const deserializationOptionNames = ["ignoreFormula", "ignoreStyle", "frozenColumnsAsRowHeaders", "frozenRowsAsColumnHeaders", "doNotRecalculateAfterLoad"];
  for (const option of deserializationOptionNames) {
    if (option in params) {
      deserializationOptions[option] = params[option];
    }
  }

  Utils.importInProgress += 1;
  try {
    if (useToolbar) {
      importJson(doc.spreadJS, deserializationOptions);
      Utils.initEvents();
      Utils.initCommands();
    } else {
      Utils.spread.fromJSON(doc.spreadJS, deserializationOptions);
      if (useRibbon) {
        designer.refresh();
      }
    }

    if (params.new && (vp_localizedFolder != '')) {
      let sheetName = GC.Spread.Sheets.SR[vp_localizedFolder.substring(0, 2)].SHEET_NAME;
      sheetName += '1';
      Utils.currentSheet.name(sheetName);
    }
    _vp_callback(params);
  } catch (e) {
    params.error = e;
    _vp_callback(params);
    Utils.logEvent({ type: 'error-catched', data: e });
  }

  //vp_resetOptimizer();
});


Utils.addCommand('import-sjs', function (params) {
  const blob = Utils.b64ToBlob(params.content);

  let options = {};
  if (params.sjsOptions != null)
    options = params.sjsOptions;

  Utils.importInProgress += 1;
  Utils.spread.open(blob,
    function () {
      _vp_callback(params);
    },
    function (e) {
      params.error = e;
      _vp_callback(params);
    },
    options);
});

Utils.addCommand('export-sjs', function (params) {

  let options = {};
  if (('sjsOptions' in params) && (typeof (params.sjsOptions) === 'object')) {
    options = params.sjsOptions;
  }

  if (options.includeBindingSource == null) {
    options.includeBindingSource = true;
  }

  Utils.exportInProgress += 1;
  Utils.spread.save(
    function (blob) {
      const reader = new FileReader();
      reader.onloadend = function () {
        params.content = reader.result.substr(reader.result.indexOf(',') + 1);
        _vp_callback(params);
      };
      reader.readAsDataURL(blob);
    },
    function (e) {
      params.error = e;
      _vp_callback(params);
    },
    options
  );
});

Utils.addCommand('export-json', function (params) {
  const doc = {};
  const document = Utils.currentDocument;

  if (document.d4Version) doc.version = document.d4Version;
  if (document.d4DateCreation) doc.dateCreation = document.d4DateCreation;
  if (document.d4DateModified) doc.dateModified = document.d4DateModified;
  if (document.d4Meta) doc.meta = document.d4Meta;

  const serializationOption = { includeBindingSource: true };

  if (("valuesOnly" in params) && (typeof params.valuesOnly == "boolean"))
    serializationOption.ignoreFormula = params.valuesOnly;

  const serializationOptionNames = ["includeBindingSource", "ignoreFormula", "ignoreStyle", "ignoreFormula", "rowHeadersAsFrozenColumns", "columnHeadersAsFrozenRows"]; //  "saveAsView"
  for (const option of serializationOptionNames) {
    if (option in params) {
      serializationOption[option] = params[option];
    }
  }

  doc.spreadJS = Utils.spread.toJSON(serializationOption);

  let storeIncludeFormatInfo = true;

  if (("includeFormatInfo" in params) && (typeof params.includeFormatInfo == "boolean"))
    storeIncludeFormatInfo = params.includeFormatInfo;

  if (storeIncludeFormatInfo) {
    Utils.addFormatedText(doc.spreadJS);
  }

  if (!serializationOption.ignoreStyle) {
    Utils.addCompositeStyles(doc.spreadJS);
    Utils.addConditionalFormattingSnapshots(doc.spreadJS);
  }

  return doc;
});

Utils.addCommand('export-excel', function (params) {

  const tabStripVisible = Utils.spread.options.tabStripVisible;
  Utils.spread.options.tabStripVisible = true; // export with visible tabs

  const options = {};
  if (params["password"] != null)
    options.password = params.password;

  if (!options.excelIO) {

    options.fileType = GC.Spread.Sheets.FileType.excel;

    // Default value from ui
    options.includeStyles = true;
    options.includeUnusedNames = true;
    options.includeFormulas = true;
    if (params["valuesOnly"] != null)
      options.includeFormulas = !params.valuesOnly;
    if (params["includeBindingSource"] != null)
      options.includeBindingSource = params.includeBindingSource;

    // apply all options from excelOptions
    for (const key in params["excelOptions"] || {}) { // copy all not, filtering to not limit
      options[key] = params["excelOptions"][key];
    }

    Utils.exportInProgress += 1;
    Utils.spread.save(
      function (blob) {
        Utils.spread.options.tabStripVisible = tabStripVisible;
        const reader = new FileReader();
        reader.onloadend = function () {
          params.content = reader.result.substr(reader.result.indexOf(',') + 1);
          _vp_callback(params);
        };
        reader.readAsDataURL(blob);
      },
      function (e) {
        Utils.spread.options.tabStripVisible = tabStripVisible;
        params.error = e;
        _vp_callback(params);
      },
      options);
    return;
  }

  const serializationOption = {};
  if (params["valuesOnly"] != null)
    serializationOption.ignoreFormula = params.valuesOnly;

  if (params["includeBindingSource"] != null)
    serializationOption.includeBindingSource = params.includeBindingSource;

  const json = Utils.spread.toJSON(serializationOption);

  Utils.exportInProgress += 1;
  const excelIO = new GC.Spread.Excel.IO();
  excelIO.save(json,
    function (blob) {
      Utils.spread.options.tabStripVisible = tabStripVisible;
      const reader = new FileReader();
      reader.onloadend = function () {
        params.content = reader.result.substr(reader.result.indexOf(',') + 1);
        _vp_callback(params);
      };
      reader.readAsDataURL(blob);
    },
    function (e) {
      Utils.spread.options.tabStripVisible = tabStripVisible;
      params.error = e;
      _vp_callback(params);
    },
    options);
});

Utils.addCommand('import-excel', function (params) {
  const blob = Utils.b64ToBlob(params.content);

  const options = {};
  if (params["password"] != null)
    options.password = params.password;

  if (!options.excelIO) {

    options.fileType = GC.Spread.Sheets.FileType.excel;

    for (const key in params["excelOptions"] || {}) { // copy all not, filtering to not limit
      options[key] = params["excelOptions"][key];
    }

    Utils.importInProgress += 1;
    Utils.spread.open(blob,
      function () {
        _vp_callback(params);
      },
      function (e) {
        params.error = e;
        _vp_callback(params);
      },
      options);
    return;
  }

  const excelIO = new GC.Spread.Excel.IO();
  excelIO.open(blob,
    function (json) {

      Utils.spread.suspendPaint();

      try {
        if (useRibbon) {
          Utils.spread.fromJSON(json);
          designer.refresh();
        }
        else if (useToolbar) {
          importJson(json);
        } else {
          Utils.spread.fromJSON(json);
        }
      } catch (e) {
        params.error = e;
        _vp_callback(params);
      }

      Utils.spread.resumePaint();

      _vp_callback(params);
    },
    function (e) {
      params.error = e;
      _vp_callback(params);
    },
    options);
});

Utils.addCommand('export-csv', function (params) {
  const doc = {};

  // Utils.exportInProgress += 1; // commented, not async callback for the moment
  if ('range' in params) {
    if (('ranges' in params.range) && (params.range.ranges.constructor === Array)) {
      const instance = Utils.getFirstRange(params.range.ranges);
      if (instance != null) {

        let rowDelimiter = "\r\n";
        if ('rowDelimiter' in params && typeof params.rowDelimiter === 'string') {
          rowDelimiter = params.rowDelimiter;
        }

        let columnDelimiter = ",";
        if ('columnDelimiter' in params && typeof params.columnDelimiter === 'string') {
          columnDelimiter = params.columnDelimiter;
        }

        doc.csv = instance.sheet.getCsv(
          instance.row,
          instance.column,
          instance.rowCount,
          instance.columnCount,
          rowDelimiter,
          columnDelimiter);
      }
    }
  }
  return doc;
});

Utils.addCommand('import-csv', function (params) {

  let instance = null;

  const csvOptions = params.csvOptions || {};

  if (('range' in csvOptions) && ('ranges' in csvOptions.range) && (csvOptions.range.ranges.constructor === Array)) {
    instance = Utils.getFirstRange(csvOptions.range.ranges);
  } else {
    instance = Utils.getFirstRange([{ sheetIndex: -1, row: 0, column: 0 }]);
  }

  let rowDelimiter = "\r\n";
  if ('rowDelimiter' in csvOptions && typeof csvOptions.rowDelimiter === 'string') {
    rowDelimiter = csvOptions.rowDelimiter;
  }

  let columnDelimiter = ",";
  if ('columnDelimiter' in csvOptions && typeof csvOptions.columnDelimiter === 'string') {
    columnDelimiter = csvOptions.columnDelimiter;
  }

  Utils.importInProgress += 1;
  instance.sheet.setCsv(
    instance.row,
    instance.column,
    csvOptions.csv,
    rowDelimiter,
    columnDelimiter);

  _vp_callback(params);

});


Utils.addCommand('export-pdf', function (params) {
  const sheetIndex = Utils.resolveSheetIndex(params.sheetIndex);

  let options = null;
  if (('pdfOptions' in params) && (typeof (params.pdfOptions) === 'object')) {
    options = params.pdfOptions;
  }

  Utils.exportInProgress += 1;

  if (params.fonts)
  {
    for (const font in params.fonts) {
      GC.Spread.Sheets.PDF.PDFFontsManager.registerFont(font, params.fonts[font]);
    }
  }

  Utils.spread.savePDF(function (blob) {
    const reader = new FileReader();
    reader.onloadend = function () {
      params.content = reader.result.substr(reader.result.indexOf(',') + 1);
      _vp_callback(params);
    };
    reader.readAsDataURL(blob);
  },
    function (e) {
      params.error = e;
      _vp_callback(params);
    },
    options,
    sheetIndex);
});

Utils.addCommand('register-pdf-fonts', function (params) {

  params.fonts.forEach(element => {
    if (element.font === null) {
      GC.Spread.Sheets.PDF.PDFFontsManager.registerFont(element.name);
    } else {
      GC.Spread.Sheets.PDF.PDFFontsManager.registerFont(element.name, element.font);
    }
  });

});

/*function parseFontString(fontString) {
  let elements = fontString.split(/\s+/).filter(el => el.trim() !== "");
  let obj = {
      family: "",
      variant: "",
      style: "",
      weight: "",
      size: ""
  };

  let parseSize = false;
  let parseName = false;

  for (let i = 0; i < elements.length; i++) {
      let element = elements[i];

      if (!parseSize) {
          if (["normal", "initial", "inherit"].includes(element)) {
              continue;
          } else if (element === "small-caps") {
              obj.variant = element;
          } else if (["oblique", "italic"].includes(element)) {
              obj.style = element;
          } else if (["lighter", "bold", "bolder", "100", "200", "300", "400", "500", "600", "700", "800", "900"].includes(element)) {
              obj.weight = element;
          } else {
              parseSize = true;
          }
      }

      if (parseName) {
          obj.family += element + " ";
      } else if (parseSize) {
          obj.size = element;
          parseName = true;
      }
  }

  obj.family = obj.family.trim();

  if (obj.family.length > 2) {
      if (obj.family.startsWith("\"") || obj.family.startsWith("'")) {
          obj.family = obj.family.substring(1);
      }
      if (obj.family.endsWith("\"") || obj.family.endsWith("'")) {
          obj.family = obj.family.substring(0, obj.family.length - 1);
      }
  }

  let hasComma = obj.family.indexOf(",");
  if (hasComma > 0) {
      obj.family = obj.family.substring(0, hasComma);
  }

  return obj;
}

function filterFonts(fontStrings) {
  const excludedFamilies = new Set(["Courier", "Times", "Helvetica", "Symbol", "ZapfDingbats"]);
  return fontStrings.map(parseFontString).filter(font => !excludedFamilies.has(font.family));
}*/

function _vp_getFonts(sheetIndex) {

  const json = Utils.spread.toJSON();
  const fonts = {};

  function getFontFromHeaderOrFooter(sheet, name) {
    if (name in sheet.printInfo) {
      const txt = sheet.printInfo[name];
      let i = 0;
      let bold = false;
      let italic = false;
      let font = '';

      for (i = 0; i < txt.length; i++) {
        if (txt[i] === '&') {
          if (i + 1 < txt.length) {
            i++;
            if (txt[i] === '"') {
              // font name
              for (++i; (txt[i] != '"') && (i < txt.length); i++) {
                font += txt[i];
              }
            } else if (txt[i] == 'I') {
              italic = true;
            } else if (txt[i] == 'B') {
              bold = true;
            }
          }
        }
      }
      if (font != '') {
        fonts[(bold ? 'bold ' : '') + (italic ? 'italic ' : '') + '20pt ' + font] = "";
      }
    }
  }

  for (const sheetName in json.sheets) {
    const sheet = json.sheets[sheetName];
    if ((sheetIndex == null) || (sheet.index == sheetIndex)) {
      if ('printInfo' in sheet) {
        getFontFromHeaderOrFooter(sheet, 'footerCenter');
        getFontFromHeaderOrFooter(sheet, 'footerLeft');
        getFontFromHeaderOrFooter(sheet, 'footerRight');
        getFontFromHeaderOrFooter(sheet, 'headerCenter');
        getFontFromHeaderOrFooter(sheet, 'headerLeft');
        getFontFromHeaderOrFooter(sheet, 'headerRight');
      }
      if (('data' in sheet) && ('dataTable' in sheet.data)) {
        const dataTable = sheet.data.dataTable;
        const liveSheet = Utils.spread.getSheet(sheet.index);
        for (const row in dataTable) {
          for (const column in dataTable[row]) {
            const liveCell = liveSheet.getCell(Number(row), Number(column));
            fonts[liveCell.font()] = "";
          }
        }
      }
    }
  }
  return fonts;
};

Utils.computePdfFonts = function (sheetIndex, callback) {

  const fonts = _vp_getFonts(sheetIndex);

  /*
  // this code allow to not call 4D,  but maybe js code is not sync with 4d code
  if(filterFonts(Object.keys(fonts)).length === 0) {
      callback();
    return;
  }
  */

  $4d._vp_computeFonts(fonts, function (toEmbed) {
    for (const font in toEmbed) {
      GC.Spread.Sheets.PDF.PDFFontsManager.registerFont(font, toEmbed[font]);
    }
    callback();
  });
};

// parse through all the cells of the document and add the formated values
// to allow to convert the document to SVG without messing with computing them outside SpreadJS
Utils.addFormatedText = function (json) {

  const formatterPool = {};
  let generalDateFormatter = null;
  let styleSheetPoolFormat = {};
  let cell = {};
  let row = "";
  let column = "";
  let sheet = null;
  let sheetIndex = 0;
  const longDatePattern = GC.Spread.Common.CultureManager.getCultureInfo().DateTimeFormat.defaultDatePattern;
  const shortDatePattern = GC.Spread.Common.CultureManager.getCultureInfo().DateTimeFormat.shortDatePattern;

  // _WordWrapHelper // SPREADJS_MIN
  const _WordWrapHelper = GC.Spread.Sheets.q || GC.Spread.Sheets._WordWrapHelper;
  const _getWrapInfo = _WordWrapHelper.un || _WordWrapHelper._getWrapInfo;
  const _SJSGetWordWrapInfo = _WordWrapHelper.Ht || _WordWrapHelper._getWordWrapInfo;
  const _getCtx = _WordWrapHelper.J || _WordWrapHelper._getCtx;

  const _getFontHeight = GC.Spread.Sheets.util.vt || GC.Spread.Sheets.util._getFontHeight;
  const _getFontObject = GC.Spread.Sheets.util._0 || GC.Spread.Sheets.util._getFontObject;
  const _measureTextWidth = GC.Spread.Sheets.util.Mt || GC.Spread.Sheets.util._measureTextWidth;
  const _setContextFont = GC.Spread.Sheets.util.bt || GC.Spread.Sheets.util._setContextFont;


  let wordWrap = null;
  let font = null;
  let textOrientation = null;
  let rowHeight = 20;
  let columnWidth = 60;
  const ctx = _getCtx();
  let cellPadding = null;
  let isVerticalText = null;
  let textIndent = null;
  let vAlign = null;

  function _getFormatInfo(format) {

    // use a pool for formatter to avoid to create a new formatter for the same format
    if (formatterPool[format] == undefined) {
      formatterPool[format] = new GC.Spread.Formatter.GeneralFormatter(format);
    }

    let formatter = formatterPool[format];

    let val;
    if ((typeof (cell.value) === 'string') && (cell.value.startsWith("/OADate(")) && (cell.value.endsWith(")/"))) {
      val = Utils.spread.getSheet(sheetIndex).getCell(row, column).value();
      if (format === 'General') {
        if (generalDateFormatter == null) {
          const culture = GC.Spread.Common.CultureManager.getCultureInfo();
          generalDateFormatter = new GC.Spread.Formatter.GeneralFormatter(culture.DateTimeFormat.shortDatePattern);
        }
        formatter = generalDateFormatter;
      }
    } else if (typeof (cell.value) === 'number') {
      val = Number(cell.value.toFixed(13));
    } else {
      val = cell.value;
    }

    const formatInfo = {};
    const formated = formatter.format(val, formatInfo);
    const result = {};

    if (typeof (formatInfo) == 'object') {
      if ('conditionalForeColor' in formatInfo) {
        result.color = formatInfo.conditionalForeColor;
      }
      if (('content' in formatInfo) && (formatInfo.content.some(element => {
        return element.type === 'fillingChar';
      }))) {
        result.content = formatInfo.content;
      } else {
        result.text = formated;
      }
    } else {
      result.text = formated;
    }
    return result;
  }

  function _getWordWrapInfo() {

    let text;

    if (('style' in cell) && ('formatInfo' in cell.style) && ('text' in cell.style.formatInfo)) {
      text = cell.style.formatInfo.text;
    } else {
      text = cell.value.toString();
    }
    rowHeight = 20;
    if (sheet.rows != null && sheet.rows[row] != null && 'size' in sheet.rows[row]) {
      rowHeight = sheet.rows[row].size;
    }

    if ('spans' in sheet) {
      for (const span in sheet.spans) {
        if (sheet.spans[span].row == row && sheet.spans[span].col == column) {
          for (let index = sheet.spans[span].row + 1; index <= sheet.spans[span].row + sheet.spans[span].rowCount - 1; ++index) {
            if (sheet.rows != null && sheet.rows[index] != null && 'size' in sheet.rows[index]) {
              rowHeight = rowHeight + sheet.rows[index].size;
            }
            else {
              rowHeight = rowHeight + 20;
            }
          }
        }
      }
    }

    columnWidth = 60;
    if (sheet.columns != null && sheet.columns[column] != null && 'size' in sheet.columns[column]) {
      columnWidth = sheet.columns[column].size;
    }

    if ('spans' in sheet) {
      for (const span in sheet.spans) {
        if (sheet.spans[span].row == row && sheet.spans[span].col == column) {
          for (let index = sheet.spans[span].col + 1; index <= sheet.spans[span].col + sheet.spans[span].colCount - 1; ++index) {
            if (sheet.columns != null && sheet.columns[index] != null && 'size' in sheet.columns[index]) {
              columnWidth = columnWidth + sheet.columns[index].size;
            }
            else {
              columnWidth = columnWidth + 60;
            }
          }
        }
      }
    }

    if (cellPadding != null) {
      const paddingArray = cellPadding.split(" ");
      let topPadding = 0;
      let bottomPadding = 0;
      let leftPadding = 0;
      let rightPadding = 0;

      if (paddingArray.length == 1) {
        topPadding = parseInt(cellPadding);
        bottomPadding = parseInt(cellPadding);
        leftPadding = parseInt(cellPadding);
        rightPadding = parseInt(cellPadding);
      }
      else {
        topPadding = parseInt(paddingArray[0]);
        bottomPadding = parseInt(paddingArray[2]);

        leftPadding = parseInt(paddingArray[3]);
        rightPadding = parseInt(paddingArray[1]);
      }

      rowHeight = rowHeight - topPadding - bottomPadding;
      columnWidth = columnWidth - leftPadding - rightPadding;
    }

    if (textIndent != null) {
      if (isVerticalText) {
        if (vAlign != 1) {
          rowHeight -= textIndent * 8;
        }
      }
      else {
        columnWidth -= textIndent * 8;
      }
    }

    let wordWrapWidth;

    if (font == null) {
      font = "11pt Calibri";
    }

    const fontObj = _getFontObject(font);

    const textHeight = _convertUnitToPx(fontObj.fontSize);

    const lineHeight = _getFontHeight(font);

    if (textOrientation != null && textOrientation != 0) {
      const textOrientationRadian = textOrientation * Math.PI / 180;

      const abstextOrientationRadian = Math.abs(textOrientationRadian);

      const lineSizeCosAdj = (textHeight / 2) * Math.cos(abstextOrientationRadian);

      const sintextOrientation = Math.sin(abstextOrientationRadian);

      // const costextOrientation = Math.cos(abstextOrientationRadian);

      //wordWrapWidth = _getRotateTextWordWrapWidth(row, column, sintextOrientation, costextOrientation, text, font, rowHeight);
      wordWrapWidth = (rowHeight - 4 - 2 * lineSizeCosAdj) / sintextOrientation;
    }
    else if (isVerticalText == true) {
      wordWrapWidth = rowHeight - 3;
    }
    else {
      wordWrapWidth = columnWidth - 3;
    }

    _setContextFont(ctx, font);

    if (wordWrapWidth <= isVerticalText ? text.length * lineHeight : _measureTextWidth(ctx, ctx.font, text)) {
      let lines;

      const richText = [{
        style: {
          font: font
        },
        text: text
      }];

      if (isVerticalText == true) {
        lines = _SJSGetWordWrapInfo(text, wordWrapWidth, font, richText, true, ctx);

        let i = 0;
        let j = 0;
        let w = 0;

        while (i < text.length) {

          if (w < lines.length && j == lines[w].text.length) {

            if (text[i] == ' ') {
              if (w + 1 < lines.length) {
                if (lines[w + 1].text != '' && lines[w + 1].text[0] != ' ') {
                  lines[w].text += ' ';
                }
                else {
                  i--;
                }
              }
            }
            else {
              i--;
            }
            w++;
            j = 0;
          }
          else {
            j++;
          }
          i++;
        }


      } else {
        lines = _getWrapInfo(text, wordWrapWidth, font, false, ctx);
      }

      const result = {};

      result.lines = [];

      result.lineHeight = lineHeight;

      let biggestLineWidth = 0;

      for (const line in lines) {
        result.lines[line] = { text: lines[line], width: _measureTextWidth(ctx, ctx.font, lines[line]) };
        if (result.lines[line].width > biggestLineWidth) {
          biggestLineWidth = result.lines[line].width;
        }
      }

      result.boxWidth = biggestLineWidth;

      if (cell.style === undefined) {
        cell.style = {};
      }

      cell.style.wordWrapInfo = result;
    }
  }

  function _handleStyleSheetFormatter(stylesheetName, lookAtSheetLevel) {
    let aFormatter = null;

    function __resolveStyleSheetByName(name) {

      function ___resolveStyleSheet(styleSheet) {
        styleSheet.some(style => {
          if (style.name === name) {
            if ('formatter' in style) {
              aFormatter = style.formatter;
            } else if ('parentName' in style) {
              aFormatter = __resolveStyleSheetByName(style.parentName);
            }
            return true;
          } else {
            return false;
          }
        });
      }

      if (lookAtSheetLevel && ('namedStyles' in sheet) && (sheet.namedStyles.constructor == Array)) {
        ___resolveStyleSheet(sheet.namedStyles);
      }

      if ((aFormatter == null) && ('namedStyles' in json) && (json.namedStyles.constructor == Array)) {
        lookAtSheetLevel = false;
        ___resolveStyleSheet(json.namedStyles);
      }
    }

    // use a pool of format per stylesheet to avoid to compute the format for each stylesheet
    if (stylesheetName in styleSheetPoolFormat) {
      aFormatter = styleSheetPoolFormat[stylesheetName];
    } else {
      __resolveStyleSheetByName(stylesheetName);
      styleSheetPoolFormat[stylesheetName] = aFormatter;
    }
    return aFormatter;
  }

  function _handleStyleSheet(stylesheetName, lookAtSheetLevel, key) {
    let aValue = null;

    function __resolveStyleSheetByName(name) {

      function ___resolveStyleSheet(styleSheet) {
        styleSheet.some(style => {
          if (style.name === name) {
            if (key in style) {
              aValue = style[key];
            } else if ('parentName' in style) {
              aValue = __resolveStyleSheetByName(style.parentName);
            }
            return true;
          } else {
            return false;
          }
        });
      }

      if (lookAtSheetLevel && ('namedStyles' in sheet) && (sheet.namedStyles.constructor == Array)) {
        ___resolveStyleSheet(sheet.namedStyles);
      }

      if ((aValue == null) && ('namedStyles' in json) && (json.namedStyles.constructor == Array)) {
        lookAtSheetLevel = false;
        ___resolveStyleSheet(json.namedStyles);
      }
    }


    __resolveStyleSheetByName(stylesheetName);

    return aValue;
  }

  function _getRowColumnFormatter(name, value) {
    let aFormatter = null;
    if (name in sheet.data) {
      if (sheet.data[name].constructor == Array) {
        if (value < sheet.data[name].length) {
          const aStyle = sheet.data[name][value];
          if (typeof aStyle === 'object') {
            if ('style' in aStyle) {
              if (typeof aStyle.style === 'string') {
                aFormatter = _handleStyleSheetFormatter(aStyle.style, true);
              } else if (typeof aStyle.style == 'object') {
                if ('formatter' in aStyle.style) {
                  aFormatter = aStyle.style.formatter;
                }
              }
            }
          }
        }
      }
    }
    return aFormatter;
  }

  function _getRowColumnPropertie(name, value, key) {
    let aPropertie = null;
    if (name in sheet.data) {
      if (sheet.data[name].constructor == Array) {
        if (value < sheet.data[name].length) {
          const aStyle = sheet.data[name][value];
          if (typeof aStyle === 'object') {
            if ('style' in aStyle) {
              if (typeof aStyle.style === 'string') {
                aPropertie = _handleStyleSheet(aStyle.style, true, key);
              } else if (typeof aStyle.style == 'object') {
                if (key in aStyle.style) {
                  aPropertie = aStyle.style[key];
                }
              }
            }
          }
        }
      }
    }
    return aPropertie;
  }

  function _getCellPropertie(cell, key) {
    let aPropertie = null;

    if (key in cell.style) {
      aPropertie = cell.style[key];
    } else if (('name' in cell.style) && (typeof cell.style.name === 'string') && (cell.style.name.length > 0)) {
      // stylesheet name can be in "name" attribute of the style object
      aPropertie = _handleStyleSheet(cell.style.name, true, key);
    } else if (('parentName' in cell.style) && (typeof cell.style.parentName === 'string') && (cell.style.parentName.length > 0)) {
      // stylesheet name can be also in "parentName" attribute of the style object
      aPropertie = _handleStyleSheet(cell.style.parentName, true, key);
    }

    return aPropertie;
  }

  function _getPriorityProp(cellProp, columnProp, rowProp, defaultProp) {
    let aPropertie = null;

    if ((cellProp != null) && (aPropertie == null)) {
      aPropertie = cellProp;
    }
    if ((columnProp != null) && (aPropertie == null)) {
      aPropertie = columnProp;
    }
    if ((rowProp != null) && (aPropertie == null)) {
      aPropertie = rowProp;
    }
    if ((defaultProp != null) && (aPropertie == null)) {
      aPropertie = defaultProp;
    }

    return aPropertie;
  }

  function _noFormatInfo() {
    return !(('style' in cell) && (typeof cell.style == 'object') && ('formatInfo' in cell.style));
  }

  function _createFormatInfo(aFormatter) {
    if (!('style' in cell)) {
      cell.style = {};
    }
    cell.style.formatInfo = _getFormatInfo(aFormatter);
  }

  function _convertUnitToPx(fontSize) {
    let converted;

    if (fontSize.includes('%')) {
      converted = parseFloat(fontSize) / 100 * 10;
    } else if (fontSize.includes('px')) {
      converted = parseFloat(fontSize);
    } else if (fontSize.includes('cm')) {
      converted = parseFloat(fontSize) / 2.54 * 72 * (4 / 3);
    } else if (fontSize.includes('mm')) {
      converted = parseFloat(fontSize) / 10 / 2.54 * 72 * (4 / 3);
    } else if (fontSize.includes('in')) {
      converted = parseFloat(fontSize) * 72 * (4 / 3);
    } else if (fontSize.includes('pt')) {
      converted = parseFloat(fontSize) * (4 / 3);
    } else if (fontSize.includes('pc')) {
      converted = parseFloat(fontSize) * 12 * (4 / 3);
    } else {
      converted = 14.6664;
    }

    return converted;
  }

  for (const sheetName in json.sheets) {
    sheet = json.sheets[sheetName];
    styleSheetPoolFormat = {};
    if (('data' in sheet) && ('dataTable' in sheet.data)) {

      let defaultFormatter = null;

      let defaultWordWrap = null;
      let defaultFont = null;
      let defaultTextOrientation = null;
      let defaultCellPadding = null;
      let defaultIsVerticalText = null;
      let defaultTextIndent = null;
      let defaultVAlign = null;

      if (('defaultDataNode' in sheet.data) && ('style' in sheet.data.defaultDataNode))
        if (typeof sheet.data.defaultDataNode.style == 'string') {
          defaultFormatter = _handleStyleSheetFormatter(sheet.data.defaultDataNode.style, false);

          defaultWordWrap = _handleStyleSheet(sheet.data.defaultDataNode.style, false, 'wordWrap');
          defaultFont = _handleStyleSheet(sheet.data.defaultDataNode.style, false, 'font');
          defaultTextOrientation = _handleStyleSheet(sheet.data.defaultDataNode.style, false, 'textOrientation');
          defaultIsVerticalText = _handleStyleSheet(sheet.data.defaultDataNode.style, false, 'isVerticalText');
          defaultTextIndent = _handleStyleSheet(sheet.data.defaultDataNode.style.false, 'textIndent');
          defaultVAlign = _handleStyleSheet(sheet.data.defaultDataNode.style.false, 'vAlign');
        } else if (typeof sheet.data.defaultDataNode.style == 'object') {
          if ('formatter' in sheet.data.defaultDataNode.style) {
            defaultFormatter = sheet.data.defaultDataNode.style.formatter;
          }

          if ('wordWrap' in sheet.data.defaultDataNode.style) {
            defaultWordWrap = sheet.data.defaultDataNode.style.wordWrap;
          }
          if ('font' in sheet.data.defaultDataNode.style) {
            defaultFont = sheet.data.defaultDataNode.style.font;
          }
          if ('textOrientation' in sheet.data.defaultDataNode.style) {
            defaultTextOrientation = sheet.data.defaultDataNode.style.textOrientation;
          }
          if ('cellPadding' in sheet.data.defaultDataNode.style) {
            defaultCellPadding = sheet.data.defaultCellPadding;
          }
          if ('isVerticalText' in sheet.data.defaultDataNode.style) {
            defaultIsVerticalText = sheet.data.defaultDataNode.isVerticalText;
          }
          if ('textIndent' in sheet.data.defaultDataNode.style) {
            defaultTextIndent = sheet.data.defaultDataNode.textIndent;
          }
          if ('vAlign' in sheet.data.defaultDataNode.style) {
            defaultVAlign = sheet.data.defaultDataNode.vAlign;
          }
        }

      const dataTable = sheet.data.dataTable;
      for (row in dataTable) {

        const rowFormatter = _getRowColumnFormatter('rowDataArray', row);

        const rowWordWrap = _getRowColumnPropertie('rowDataArray', row, 'wordWrap');
        const rowFont = _getRowColumnPropertie('rowDataArray', row, 'font');
        const rowTextOrientation = _getRowColumnPropertie('rowDataArray', row, 'textOrientation');
        const rowCellPadding = _getRowColumnPropertie('rowDataArray', row, 'cellPadding');
        const rowIsVerticalText = _getRowColumnPropertie('rowDataArray', row, 'isVerticalText');
        const rowTextIndent = _getRowColumnPropertie('rowDataArray', row, 'textIndent');
        const rowVAlign = _getRowColumnPropertie('rowDataArray', row, 'vAlign');

        for (column in dataTable[row]) {

          const columnFormatter = _getRowColumnFormatter('columnDataArray', column);

          const columnWordWrap = _getRowColumnPropertie('columnDataArray', column, 'wordWrap');
          const columnFont = _getRowColumnPropertie('columnDataArray', column, 'font');
          const columnTextOrientation = _getRowColumnPropertie('columnDataArray', column, 'textOrientation');
          const columnCellPadding = _getRowColumnPropertie('columnDataArray', column, 'cellPadding');
          const columnIsVerticalText = _getRowColumnPropertie('columnDataArray', column, 'isVerticalText');
          const columnTextIndent = _getRowColumnPropertie('columnDataArray', column, 'textIndent');
          const columnVAlign = _getRowColumnPropertie('columnDataArray', column, 'vAlign');

          cell = dataTable[row][column];
          if ('value' in cell) {

            let cellWordWrap = null;
            let cellFont = null;
            let cellTextOrientation = null;
            let cellCellPadding = null;
            let cellIsVerticalText = null;
            let cellTextIndent = null;
            let cellVAlign = null;

            wordWrap = null;
            font = null;
            textOrientation = null;
            cellPadding = null;
            isVerticalText = null;
            textIndent = null;
            vAlign = null;

            if ('style' in cell) {
              let formatter;
              if (typeof cell.style == 'object') {

                cellWordWrap = _getCellPropertie(cell, 'wordWrap');
                cellFont = _getCellPropertie(cell, 'font');
                cellTextOrientation = _getCellPropertie(cell, 'textOrientation');
                cellCellPadding = _getCellPropertie(cell, 'cellPadding');
                cellIsVerticalText = _getCellPropertie(cell, 'isVerticalText');
                cellTextIndent = _getCellPropertie(cell, 'textIndent');
                cellVAlign = _getCellPropertie(cell, 'vAlign');

                if ('formatter' in cell.style) {
                  cell.style.formatInfo = _getFormatInfo(cell.style.formatter);
                } else if (('autoFormatter' in cell.style)
                  && (typeof cell.style.autoFormatter == 'object')
                  && ('formatCached' in cell.style.autoFormatter)) {
                  cell.style.formatInfo = _getFormatInfo(cell.style.autoFormatter.formatCached);
                } else if (('name' in cell.style) && (typeof cell.style.name === 'string') && (cell.style.name.length > 0)) {
                  // stylesheet name can be in "name" attribute of the style object
                  formatter = _handleStyleSheetFormatter(cell.style.name, true);
                  if (formatter != null) {
                    cell.style.formatInfo = _getFormatInfo(formatter);
                  }
                } else if (('parentName' in cell.style) && (typeof cell.style.parentName === 'string') && (cell.style.parentName.length > 0)) {
                  // stylesheet name can be also in "parentName" attribute of the style object
                  formatter = _handleStyleSheetFormatter(cell.style.parentName, true);
                  if (formatter != null) {
                    cell.style.formatInfo = _getFormatInfo(formatter);
                  }
                }
              } else if (typeof cell.style == 'string') {
                // this is a very particular case where the style is not an object
                // but a string that contains the name of the stylesheet
                const styleName = cell.style;
                cell.style = { 'parentName': styleName };
                formatter = _handleStyleSheetFormatter(styleName, true);
                if (formatter != null) {
                  cell.style.formatInfo = _getFormatInfo(formatter);
                }

                cellWordWrap = _handleStyleSheet(styleName, true, 'wordWrap');
                cellFont = _handleStyleSheet(styleName, true, 'font');
                cellTextOrientation = _handleStyleSheet(styleName, true, 'textOrientation');
                cellCellPadding = _handleStyleSheet(styleName, true, 'cellPadding');
                cellIsVerticalText = _handleStyleSheet(styleName, true, 'isVerticalText');
                cellTextIndent = _handleStyleSheet(styleName, true, 'textIndent');
                cellVAlign = _handleStyleSheet(styleName, true, 'vAlign');
              }
            }


            // apply column formatter if any and if no previous formatting has been applied
            if ((columnFormatter != null) && _noFormatInfo()) {
              _createFormatInfo(columnFormatter);
            }

            // apply row formatter if any and if no previous formatting has been applied
            if ((rowFormatter != null) && _noFormatInfo()) {
              _createFormatInfo(rowFormatter);
            }

            // apply default formatter if any and if no previous formatting has been applied
            if ((defaultFormatter != null) && _noFormatInfo()) {
              _createFormatInfo(defaultFormatter);
            }

            // apply default date formatting
            if (_noFormatInfo()) {
              if ((typeof (cell.value) === 'string')) {
                if ((cell.value.startsWith("/OADate(")) && (cell.value.endsWith(")/"))) {
                    _createFormatInfo((cell.value.indexOf(".") > -1)? longDatePattern: shortDatePattern);
                }
              }
              else if (((typeof (cell.value) === 'number'))) {
                let fixed = Number(cell.value.toFixed(13)).toString();
                if (fixed != cell.value.toString()) {
                  if (!('style' in cell)) {
                    cell.style = {};
                  }
                  cell.style.formatInfo = { text: Number(cell.value.toFixed(13)).toString() };
                }
              }
            }

            wordWrap = _getPriorityProp(cellWordWrap, columnWordWrap, rowWordWrap, defaultWordWrap);
            font = _getPriorityProp(cellFont, columnFont, rowFont, defaultFont);
            textOrientation = _getPriorityProp(cellTextOrientation, columnTextOrientation, rowTextOrientation, defaultTextOrientation);
            cellPadding = _getPriorityProp(cellCellPadding, columnCellPadding, rowCellPadding, defaultCellPadding);
            isVerticalText = _getPriorityProp(cellIsVerticalText, columnIsVerticalText, rowIsVerticalText, defaultIsVerticalText);
            textIndent = _getPriorityProp(cellTextIndent, columnTextIndent, rowTextIndent, defaultTextIndent);
            vAlign = _getPriorityProp(cellVAlign, columnVAlign, rowVAlign, defaultVAlign);

            if ((wordWrap != null) && (wordWrap == true)) {
              _getWordWrapInfo();
            }

          }
        }
      }
    }
    sheetIndex++;
  }
};

// Convert runtime SpreadJS objects into plain JSON-safe values for export.
Utils._serializeJSONValue = function (value, depth = 0) {
  if (depth > 8) {
    return null;
  }

  if ((value == null) || (typeof value === 'string') || (typeof value === 'number') || (typeof value === 'boolean')) {
    return value;
  }

  if (Array.isArray(value)) {
    const result = [];

    value.forEach(element => {
      const serializedElement = Utils._serializeJSONValue(element, depth + 1);
      if (serializedElement !== undefined) {
        result.push(serializedElement);
      }
    });

    return result;
  }

  if (typeof value === 'object') {
    if ((typeof value.toJSON === 'function') && !Array.isArray(value)) {
      try {
        const jsonValue = value.toJSON();
        if (jsonValue !== value) {
          return Utils._serializeJSONValue(jsonValue, depth + 1);
        }
      } catch (error) {
      }
    }

    const result = {};

    Object.keys(value).forEach(key => {
      const serializedProperty = Utils._serializeJSONValue(value[key], depth + 1);
      if (serializedProperty !== undefined) {
        result[key] = serializedProperty;
      }
    });

    return (Object.keys(result).length > 0) ? result : null;
  }

  return undefined;
};

// Ensure the workbook JSON contains a writable dataTable for cell-level additions.
Utils._ensureSheetDataTable = function (sheet) {
  if ((sheet.data == null) || (typeof sheet.data !== 'object')) {
    sheet.data = {};
  }

  if ((sheet.data.dataTable == null) || (typeof sheet.data.dataTable !== 'object')) {
    sheet.data.dataTable = {};
  }

  return sheet.data.dataTable;
};

// Return the exported cell object, creating row and column entries on demand.
Utils._ensureCellObject = function (sheet, row, column) {
  const dataTable = Utils._ensureSheetDataTable(sheet);
  const rowKey = String(row);
  const columnKey = String(column);

  if ((dataTable[rowKey] == null) || (typeof dataTable[rowKey] !== 'object')) {
    dataTable[rowKey] = {};
  }

  if ((dataTable[rowKey][columnKey] == null) || (typeof dataTable[rowKey][columnKey] !== 'object')) {
    dataTable[rowKey][columnKey] = {};
  }

  return dataTable[rowKey][columnKey];
};

// Extract a numeric font size from a CSS-like font string.
Utils._extractFontSize = function (font) {
  if (typeof font !== 'string') {
    return null;
  }

  const fontMatch = font.match(/(\d+(?:\.\d+)?)(px|pt)/i);

  if (!fontMatch) {
    return null;
  }

  let fontSize = Number(fontMatch[1]);
  if (!Number.isFinite(fontSize)) {
    return null;
  }

  if ((fontMatch[2] != null) && (fontMatch[2].toLowerCase() === 'pt')) {
    fontSize = fontSize * (96 / 72);
  }

  return fontSize;
};

// Estimate the line height SpreadJS uses when positioning conditional icons.
Utils._getConditionalOverlayLineHeight = function (style, cellHeight) {
  if ((style != null) && (typeof style._lineHeight === 'number') && Number.isFinite(style._lineHeight) && (style._lineHeight > 0)) {
    return style._lineHeight;
  }

  if ((GC != null) && (GC.Spread != null) && (GC.Spread.Sheets != null) && (GC.Spread.Sheets._StyleHelper != null) && (typeof GC.Spread.Sheets._StyleHelper._scaleSplitFont === 'function')) {
    try {
      const fontInfo = GC.Spread.Sheets._StyleHelper._scaleSplitFont(style || {}, 1);

      if ((fontInfo != null) && (typeof fontInfo.lineHeight === 'number') && Number.isFinite(fontInfo.lineHeight) && (fontInfo.lineHeight > 0)) {
        return fontInfo.lineHeight;
      }

      if ((fontInfo != null) && (typeof fontInfo.fontSize === 'number') && Number.isFinite(fontInfo.fontSize) && (fontInfo.fontSize > 0)) {
        return fontInfo.fontSize * 1.2;
      }
    } catch (error) {
    }
  }

  const fontSize = Utils._extractFontSize(style && style.font);
  if ((fontSize != null) && (fontSize > 0)) {
    return fontSize * 1.2;
  }

  return Math.max(12, Math.min(Math.max(cellHeight - 4, 0), 16));
};

// Expand and clamp SpreadJS conditional-format ranges to concrete sheet bounds.
Utils._normalizeConditionalRange = function (sheet, range) {
  if ((sheet == null) || (range == null) || (typeof range !== 'object')) {
    return null;
  }

  const maxRow = sheet.getRowCount();
  const maxColumn = sheet.getColumnCount();
  let row = (typeof range.row === 'number') ? range.row : 0;
  let column = (typeof range.col === 'number') ? range.col : 0;
  let rowCount = (typeof range.rowCount === 'number') ? range.rowCount : 1;
  let columnCount = (typeof range.colCount === 'number') ? range.colCount : 1;

  if (row < 0) {
    row = 0;
    rowCount = maxRow;
  }

  if (column < 0) {
    column = 0;
    columnCount = maxColumn;
  }

  if (rowCount < 0) {
    rowCount = maxRow - row;
  }

  if (columnCount < 0) {
    columnCount = maxColumn - column;
  }

  rowCount = Math.max(0, Math.min(rowCount, maxRow - row));
  columnCount = Math.max(0, Math.min(columnCount, maxColumn - column));

  if ((rowCount === 0) || (columnCount === 0)) {
    return null;
  }

  return { row, col: column, rowCount, colCount: columnCount };
};

// Intersect two normalized ranges to reduce oversized rule scans.
Utils._intersectConditionalRanges = function (rangeA, rangeB) {
  if ((rangeA == null) || (rangeB == null)) {
    return rangeA;
  }

  const row = Math.max(rangeA.row, rangeB.row);
  const col = Math.max(rangeA.col, rangeB.col);
  const rowEnd = Math.min(rangeA.row + rangeA.rowCount, rangeB.row + rangeB.rowCount);
  const colEnd = Math.min(rangeA.col + rangeA.colCount, rangeB.col + rangeB.colCount);

  if ((rowEnd <= row) || (colEnd <= col)) {
    return null;
  }

  return { row, col, rowCount: rowEnd - row, colCount: colEnd - col };
};

// Keep exported SVG coordinates compact and stable.
Utils._roundConditionalVectorNumber = function (value) {
  if ((typeof value !== 'number') || !Number.isFinite(value)) {
    return 0;
  }

  return Math.round(value * 1000) / 1000;
};

// Multiply two 2D affine matrices used by the SVG recorder.
Utils._multiplyConditionalVectorMatrix = function (matrixA, matrixB) {
  return [
    (matrixA[0] * matrixB[0]) + (matrixA[2] * matrixB[1]),
    (matrixA[1] * matrixB[0]) + (matrixA[3] * matrixB[1]),
    (matrixA[0] * matrixB[2]) + (matrixA[2] * matrixB[3]),
    (matrixA[1] * matrixB[2]) + (matrixA[3] * matrixB[3]),
    (matrixA[0] * matrixB[4]) + (matrixA[2] * matrixB[5]) + matrixA[4],
    (matrixA[1] * matrixB[4]) + (matrixA[3] * matrixB[5]) + matrixA[5]
  ];
};

// Apply the current recorder transform to one point.
Utils._transformConditionalVectorPoint = function (matrix, x, y) {
  return {
    x: Utils._roundConditionalVectorNumber((matrix[0] * x) + (matrix[2] * y) + matrix[4]),
    y: Utils._roundConditionalVectorNumber((matrix[1] * x) + (matrix[3] * y) + matrix[5])
  };
};

// Snapshot the recorder drawing state for save/restore.
Utils._cloneConditionalVectorState = function (state) {
  return {
    transform: state.transform.slice(),
    fillStyle: state.fillStyle,
    strokeStyle: state.strokeStyle,
    lineWidth: state.lineWidth,
    clipPath: state.clipPath
  };
};

// Convert a plain attribute object into the exported SVG node format.
Utils._createConditionalVectorAttributes = function (attributes) {
  const result = [];

  Object.keys(attributes || {}).forEach(name => {
    const value = attributes[name];

    if ((value == null) || (value === '')) {
      return;
    }

    result.push({
      name,
      value: (typeof value === 'number') ? Utils._roundConditionalVectorNumber(value) : value
    });
  });

  return result;
};

// Build one exported SVG node with normalized attributes and children.
Utils._createConditionalVectorNode = function (tag, attributes, children) {
  return {
    tag,
    attrs: Utils._createConditionalVectorAttributes(attributes),
    children: Array.isArray(children) ? children : []
  };
};

// Convert a rectangle into a transformed SVG path.
Utils._createConditionalVectorPathFromRect = function (matrix, x, y, width, height) {
  const p1 = Utils._transformConditionalVectorPoint(matrix, x, y);
  const p2 = Utils._transformConditionalVectorPoint(matrix, x + width, y);
  const p3 = Utils._transformConditionalVectorPoint(matrix, x + width, y + height);
  const p4 = Utils._transformConditionalVectorPoint(matrix, x, y + height);

  return `M ${p1.x} ${p1.y} L ${p2.x} ${p2.y} L ${p3.x} ${p3.y} L ${p4.x} ${p4.y} Z`;
};

// Detect the common case where a transformed rect can stay a native SVG rect.
Utils._isConditionalVectorAxisAlignedMatrix = function (matrix) {
  return (matrix != null) &&
    (Math.abs(matrix[1]) < 0.0001) &&
    (Math.abs(matrix[2]) < 0.0001) &&
    (Math.abs(matrix[0] - 1) < 0.0001) &&
    (Math.abs(matrix[3] - 1) < 0.0001);
};

// Record the SpreadJS canvas conditional-format paint calls as SVG nodes.
Utils._createConditionalVectorRecorder = function (prefix) {
  const definitions = [];
  const elements = [];
  const gradients = [];
  const stack = [];
  let gradientId = 0;
  let clipId = 0;
  let state = {
    transform: [1, 0, 0, 1, 0, 0],
    fillStyle: '#000000',
    strokeStyle: '#000000',
    lineWidth: 1,
    clipPath: null
  };
  let path = [];
  let currentPoint = null;
  let subPathStart = null;

  const pointsEqual = function (pointA, pointB) {
    return (pointA != null) && (pointB != null) && (Math.abs(pointA.x - pointB.x) < 0.001) && (Math.abs(pointA.y - pointB.y) < 0.001);
  };

  const getPaintValue = function (paintStyle) {
    if ((paintStyle != null) && (typeof paintStyle === 'object') && (paintStyle.__kind === 'linearGradient')) {
      return `url(#${paintStyle.id})`;
    }

    if (typeof paintStyle === 'string') {
      return paintStyle;
    }

    return 'none';
  };

  const addShapeElement = function (tag, attributes) {
    const svgAttributes = { ...attributes };

    if (state.clipPath != null) {
      svgAttributes['clip-path'] = state.clipPath;
    }

    elements.push(Utils._createConditionalVectorNode(tag, svgAttributes, []));
  };

  const beginPath = function () {
    path = [];
    currentPoint = null;
    subPathStart = null;
  };

  const moveTo = function (x, y) {
    const point = Utils._transformConditionalVectorPoint(state.transform, x, y);

    path.push(`M ${point.x} ${point.y}`);
    currentPoint = point;
    subPathStart = point;
  };

  const lineTo = function (x, y) {
    const point = Utils._transformConditionalVectorPoint(state.transform, x, y);

    if (currentPoint == null) {
      moveTo(x, y);
      return;
    }

    path.push(`L ${point.x} ${point.y}`);
    currentPoint = point;
  };

  const closePath = function () {
    if (path.length === 0) {
      return;
    }

    path.push('Z');
    currentPoint = subPathStart;
  };

  const appendCurrentPath = function (attributes) {
    if (path.length === 0) {
      return;
    }

    addShapeElement('path', {
      ...attributes,
      d: path.join(' ')
    });
  };

  const recorder = {
    save() {
      stack.push(Utils._cloneConditionalVectorState(state));
    },

    restore() {
      if (stack.length > 0) {
        state = stack.pop();
      }
    },

    translate(x, y) {
      state.transform = Utils._multiplyConditionalVectorMatrix(state.transform, [1, 0, 0, 1, x, y]);
    },

    rotate(angle) {
      const cosAngle = Math.cos(angle);
      const sinAngle = Math.sin(angle);

      state.transform = Utils._multiplyConditionalVectorMatrix(state.transform, [cosAngle, sinAngle, -sinAngle, cosAngle, 0, 0]);
    },

    beginPath() {
      beginPath();
    },

    moveTo(x, y) {
      moveTo(x, y);
    },

    lineTo(x, y) {
      lineTo(x, y);
    },

    rect(x, y, width, height) {
      const rectPath = Utils._createConditionalVectorPathFromRect(state.transform, x, y, width, height);

      if (rectPath !== '') {
        path.push(rectPath);
        currentPoint = null;
        subPathStart = null;
      }
    },

    arc(x, y, radius, startAngle, endAngle, anticlockwise) {
      const normalizedRadius = Math.abs(radius);

      if (!(normalizedRadius > 0)) {
        return;
      }

      const startPoint = Utils._transformConditionalVectorPoint(state.transform, x + (normalizedRadius * Math.cos(startAngle)), y + (normalizedRadius * Math.sin(startAngle)));
      const endPoint = Utils._transformConditionalVectorPoint(state.transform, x + (normalizedRadius * Math.cos(endAngle)), y + (normalizedRadius * Math.sin(endAngle)));
      let deltaAngle;

      if (anticlockwise) {
        deltaAngle = startAngle - endAngle;
        while (deltaAngle < 0) {
          deltaAngle += Math.PI * 2;
        }
        deltaAngle = -deltaAngle;
      } else {
        deltaAngle = endAngle - startAngle;
        while (deltaAngle < 0) {
          deltaAngle += Math.PI * 2;
        }
      }

      const absoluteDeltaAngle = Math.abs(deltaAngle);

      if (currentPoint == null) {
        path.push(`M ${startPoint.x} ${startPoint.y}`);
        subPathStart = startPoint;
      } else if (!pointsEqual(currentPoint, startPoint)) {
        path.push(`L ${startPoint.x} ${startPoint.y}`);
      }

      if (absoluteDeltaAngle >= ((Math.PI * 2) - 0.0001)) {
        const midAngle = startAngle + (deltaAngle / 2);
        const midPoint = Utils._transformConditionalVectorPoint(state.transform, x + (normalizedRadius * Math.cos(midAngle)), y + (normalizedRadius * Math.sin(midAngle)));

        path.push(`A ${Utils._roundConditionalVectorNumber(normalizedRadius)} ${Utils._roundConditionalVectorNumber(normalizedRadius)} 0 1 ${deltaAngle >= 0 ? 1 : 0} ${midPoint.x} ${midPoint.y}`);
        path.push(`A ${Utils._roundConditionalVectorNumber(normalizedRadius)} ${Utils._roundConditionalVectorNumber(normalizedRadius)} 0 1 ${deltaAngle >= 0 ? 1 : 0} ${endPoint.x} ${endPoint.y}`);
      } else {
        path.push(`A ${Utils._roundConditionalVectorNumber(normalizedRadius)} ${Utils._roundConditionalVectorNumber(normalizedRadius)} 0 ${absoluteDeltaAngle > Math.PI ? 1 : 0} ${deltaAngle >= 0 ? 1 : 0} ${endPoint.x} ${endPoint.y}`);
      }

      currentPoint = endPoint;
    },

    closePath() {
      closePath();
    },

    clip() {
      if (path.length === 0) {
        return;
      }

      const clipPathName = `${prefix}_clip_${clipId++}`;
      definitions.push(Utils._createConditionalVectorNode('clipPath', { id: clipPathName }, [
        Utils._createConditionalVectorNode('path', { d: path.join(' ') }, [])
      ]));
      state.clipPath = `url(#${clipPathName})`;
    },

    fill() {
      appendCurrentPath({
        fill: getPaintValue(state.fillStyle),
        stroke: 'none'
      });
    },

    stroke() {
      appendCurrentPath({
        fill: 'none',
        stroke: getPaintValue(state.strokeStyle),
        'stroke-width': state.lineWidth
      });
    },

    fillRect(x, y, width, height) {
      if (!(width > 0) || !(height > 0)) {
        return;
      }

      if (Utils._isConditionalVectorAxisAlignedMatrix(state.transform)) {
        addShapeElement('rect', {
          x: x + state.transform[4],
          y: y + state.transform[5],
          width,
          height,
          fill: getPaintValue(state.fillStyle),
          stroke: 'none'
        });
      } else {
        addShapeElement('path', {
          d: Utils._createConditionalVectorPathFromRect(state.transform, x, y, width, height),
          fill: getPaintValue(state.fillStyle),
          stroke: 'none'
        });
      }
    },

    strokeRect(x, y, width, height) {
      if (!(width > 0) || !(height > 0)) {
        return;
      }

      if (Utils._isConditionalVectorAxisAlignedMatrix(state.transform)) {
        addShapeElement('rect', {
          x: x + state.transform[4],
          y: y + state.transform[5],
          width,
          height,
          fill: 'none',
          stroke: getPaintValue(state.strokeStyle),
          'stroke-width': state.lineWidth
        });
      } else {
        addShapeElement('path', {
          d: Utils._createConditionalVectorPathFromRect(state.transform, x, y, width, height),
          fill: 'none',
          stroke: getPaintValue(state.strokeStyle),
          'stroke-width': state.lineWidth
        });
      }
    },

    createLinearGradient(x0, y0, x1, y1) {
      const startPoint = Utils._transformConditionalVectorPoint(state.transform, x0, y0);
      const endPoint = Utils._transformConditionalVectorPoint(state.transform, x1, y1);
      const gradient = {
        __kind: 'linearGradient',
        id: `${prefix}_grad_${gradientId++}`,
        x1: startPoint.x,
        y1: startPoint.y,
        x2: endPoint.x,
        y2: endPoint.y,
        stops: []
      };

      gradient.addColorStop = function (offset, color) {
        gradient.stops.push({
          offset: Utils._roundConditionalVectorNumber(offset),
          color
        });
      };

      gradients.push(gradient);

      return gradient;
    },

    drawImage(imageObject, x, y, width, height) {
      const href = imageObject && imageObject.src;

      if ((typeof href !== 'string') || (href === '')) {
        return;
      }

      addShapeElement('image', {
        x: Utils._roundConditionalVectorNumber(x),
        y: Utils._roundConditionalVectorNumber(y),
        width: Utils._roundConditionalVectorNumber(width),
        height: Utils._roundConditionalVectorNumber(height),
        preserveAspectRatio: 'none',
        'xlink:href': href
      });
    },

    toVector() {
      const gradientDefinitions = gradients.map(gradient => Utils._createConditionalVectorNode('linearGradient', {
        id: gradient.id,
        gradientUnits: 'userSpaceOnUse',
        x1: gradient.x1,
        y1: gradient.y1,
        x2: gradient.x2,
        y2: gradient.y2
      }, gradient.stops.slice().sort((stopA, stopB) => {
        const offsetA = (stopA != null) && (typeof stopA.offset === 'number') ? stopA.offset : 0;
        const offsetB = (stopB != null) && (typeof stopB.offset === 'number') ? stopB.offset : 0;

        return offsetA - offsetB;
      }).map(stop => Utils._createConditionalVectorNode('stop', {
        offset: stop.offset,
        'stop-color': stop.color
      }, []))));

      return {
        defs: definitions.concat(gradientDefinitions),
        elements
      };
    }
  };

  Object.defineProperties(recorder, {
    fillStyle: {
      get() {
        return state.fillStyle;
      },
      set(value) {
        state.fillStyle = value;
      }
    },
    strokeStyle: {
      get() {
        return state.strokeStyle;
      },
      set(value) {
        state.strokeStyle = value;
      }
    },
    lineWidth: {
      get() {
        return state.lineWidth;
      },
      set(value) {
        state.lineWidth = value;
      }
    }
  });

  beginPath();

  return recorder;
};

// Collect the concrete cells touched by conditional-format rules on a sheet.
Utils._collectConditionalFormattingCells = function (sheet, conditionalFormats) {
  const cells = [];
  const visited = new Set();
  const rules = (conditionalFormats != null) && (typeof conditionalFormats.getRules === 'function') ? conditionalFormats.getRules() : null;

  if ((rules == null) || (rules.length === 0)) {
    return cells;
  }

  const UsedRangeType = GC.Spread.Sheets.UsedRangeType;
  const contentRange = sheet.getUsedRange(
    UsedRangeType.data |
    UsedRangeType.formula |
    UsedRangeType.style |
    UsedRangeType.rowStyle |
    UsedRangeType.colStyle |
    UsedRangeType.span |
    UsedRangeType.table |
    UsedRangeType.picture |
    UsedRangeType.sparkLine |
    UsedRangeType.dataValidation
  );
  const normalizedContentRange = Utils._normalizeConditionalRange(sheet, contentRange);

  rules.forEach(rule => {
    const ranges = (rule != null) && (typeof rule.ranges === 'function') ? rule.ranges() : null;

    if (!Array.isArray(ranges)) {
      return;
    }

    ranges.forEach(range => {
      let normalizedRange = Utils._normalizeConditionalRange(sheet, range);

      if (normalizedRange == null) {
        return;
      }

      if ((normalizedContentRange != null) && ((normalizedRange.rowCount * normalizedRange.colCount) > 50000)) {
        normalizedRange = Utils._intersectConditionalRanges(normalizedRange, normalizedContentRange);
      }

      if (normalizedRange == null) {
        return;
      }

      const rowEnd = normalizedRange.row + normalizedRange.rowCount;
      const colEnd = normalizedRange.col + normalizedRange.colCount;

      for (let row = normalizedRange.row; row < rowEnd; row++) {
        for (let column = normalizedRange.col; column < colEnd; column++) {
          const key = `${row}:${column}`;

          if (!visited.has(key)) {
            visited.add(key);
            cells.push({ row, column });
          }
        }
      }
    });
  });

  return cells;
};

// Render one cell's conditional graphics into an SVG-ready vector snapshot.
Utils._renderConditionalVector = function (sheet, row, column, value, style, conditionalFormats, sheetIndex) {
  const viewport = GC.Spread.Sheets.SheetArea.viewport;
  const width = Math.ceil(sheet.getColumnWidth(column, viewport));
  const height = Math.ceil(sheet.getRowHeight(row, viewport));

  if (!(width > 0) || !(height > 0)) {
    return null;
  }

  const recorder = Utils._createConditionalVectorRecorder(`vp_cf_${sheetIndex}_${row}_${column}`);
  const hideValue = conditionalFormats._paint(recorder, value, 0, 0, width, height, style || {}, {
    sheet,
    row,
    col: column,
    sheetArea: viewport,
    lineHeight: Utils._getConditionalOverlayLineHeight(style, height),
    imageLoader: sheet._getImageLoader()
  }) === true;
  const vector = recorder.toVector();

  if ((!Array.isArray(vector.elements) || (vector.elements.length === 0)) && (!Array.isArray(vector.defs) || (vector.defs.length === 0)) && !hideValue) {
    return null;
  }

  return {
    vector,
    hideValue
  };
};

// Add every cell from a normalized range into a deduplicated work list.
Utils._addCellsFromRange = function (cells, visited, sheet, range) {
  const normalizedRange = Utils._normalizeConditionalRange(sheet, range);

  if (normalizedRange == null) {
    return;
  }

  const rowEnd = normalizedRange.row + normalizedRange.rowCount;
  const colEnd = normalizedRange.col + normalizedRange.colCount;

  for (let row = normalizedRange.row; row < rowEnd; row++) {
    for (let column = normalizedRange.col; column < colEnd; column++) {
      const key = `${row}:${column}`;

      if (!visited.has(key)) {
        visited.add(key);
        cells.push({ row, column });
      }
    }
  }
};

// Collect cells whose effective style depends on table/theme composition.
Utils._collectCompositeStyleCells = function (sheet) {
  const cells = [];
  const visited = new Set();
  const tables = sheet && sheet.tables && (typeof sheet.tables.all === 'function') ? sheet.tables.all() : [];

  tables.forEach(table => {
    if ((table != null) && (typeof table.range === 'function')) {
      Utils._addCellsFromRange(cells, visited, sheet, table.range());
    }
  });

  return cells;
};

// store non-conditional composed styles explicitly for cases such as table themes that are not expanded in workbook JSON
// Export composed non-conditional styles that are not expanded in workbook JSON.
Utils.addCompositeStyles = function (json) {
  const viewport = GC.Spread.Sheets.SheetArea.viewport;
  let sheetIndex = 0;

  for (const sheetName in json.sheets) {
    const sheet = json.sheets[sheetName];
    const spreadSheet = Utils.spread.getSheet(sheetIndex);

    if ((spreadSheet != null) && (sheet != null) && (typeof sheet === 'object')) {
      const cells = Utils._collectCompositeStyleCells(spreadSheet);

      cells.forEach(({ row, column }) => {
        const compositeStyle = Utils._serializeJSONValue(spreadSheet.getCompositeStyle(row, column, viewport), 0);

        if ((compositeStyle != null) && (typeof compositeStyle === 'object')) {
          const cell = Utils._ensureCellObject(sheet, row, column);
          cell.compositeStyle = compositeStyle;
        }
      });
    }

    sheetIndex++;
  }
};

// Export per-cell conditional-format style and vector graphics snapshots.
Utils.addConditionalFormattingSnapshots = function (json) {
  const viewport = GC.Spread.Sheets.SheetArea.viewport;
  let sheetIndex = 0;

  for (const sheetName in json.sheets) {
    const sheet = json.sheets[sheetName];
    const spreadSheet = Utils.spread.getSheet(sheetIndex);
    const conditionalFormats = spreadSheet && spreadSheet.conditionalFormats;

    if ((spreadSheet != null) && (sheet != null) && (typeof sheet === 'object') && (conditionalFormats != null) && (typeof conditionalFormats.count === 'function') && (conditionalFormats.count() > 0)) {
      const cells = Utils._collectConditionalFormattingCells(spreadSheet, conditionalFormats);

      cells.forEach(({ row, column }) => {
        const conditionalStyle = conditionalFormats._applyFormats(null, row, column, viewport);
        const serializedConditionalStyle = Utils._serializeJSONValue(conditionalStyle, 0);
        const value = spreadSheet.getValue(row, column, viewport);
        const iconSetAndDataBar = conditionalFormats._getIconSetAndDataBar(spreadSheet, row, column, value, viewport);
        const hasVector = (iconSetAndDataBar != null) && ((iconSetAndDataBar.dataBar != null) || (iconSetAndDataBar.iconSet != null));
        const vectorSnapshot = hasVector ? Utils._renderConditionalVector(spreadSheet, row, column, value, spreadSheet.getActualStyle(row, column, viewport), conditionalFormats, sheetIndex) : null;
        const hasStyle = (serializedConditionalStyle != null) && (typeof serializedConditionalStyle === 'object');
        const hasConditionalVector = (vectorSnapshot != null) && (vectorSnapshot.vector != null) && (typeof vectorSnapshot.vector === 'object');
        const hideValue = (vectorSnapshot != null) && (vectorSnapshot.hideValue === true);

        if (!hasStyle && !hasConditionalVector && !hideValue) {
          return;
        }

        const cell = Utils._ensureCellObject(sheet, row, column);
        const conditionalFormat = {};

        if (hasStyle) {
          conditionalFormat.style = serializedConditionalStyle;
        }

        if (hasConditionalVector) {
          conditionalFormat.vector = vectorSnapshot.vector;
        }

        if (hideValue) {
          conditionalFormat.hideValue = true;
        }

        cell.conditionalFormat = conditionalFormat;
      });
    }

    sheetIndex++;
  }
};
