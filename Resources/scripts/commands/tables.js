
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

(function () {

    const stripSizeArray = [
        "firstColumnStripSize",
        "firstRowStripSize",
        "secondColumnStripSize",
        "secondRowStripSize"
    ];

    const stripStyleArray = [
        "firstColumnStripStyle",
        "firstFooterCellStyle",
        "firstHeaderCellStyle",
        "firstRowStripStyle",
        "footerRowStyle",
        "headerRowStyle",
        "highlightFirstColumnStyle",
        "highlightLastColumnStyle",
        "lastFooterCellStyle",
        "lastHeaderCellStyle",
        "secondColumnStripStyle",
        "secondRowStripStyle",
        "wholeTableStyle"
    ];

    const styleAttributesArray = [
        "backColor",
        "foreColor",
        "font"
    ];

    const bordersArray = [
        "borderBottom",
        "borderTop",
        "borderLeft",
        "borderRight",
        "borderHorizontal",
        "borderVertical"
    ];

    function getTheme(gcTheme) {
        const theme = {};

        stripSizeArray.forEach(function (size) {

            if (gcTheme[size] != undefined) {
                theme[size] = gcTheme[size]();
            }
        });

        stripStyleArray.forEach(styleName => {

            const gcStyle = gcTheme[styleName]();

            if (gcStyle != undefined) {

                const style = {};

                styleAttributesArray.forEach(attributeName => {
                    if (gcStyle[attributeName] != undefined) {
                        style[attributeName] = gcStyle[attributeName];
                    }
                });

                if (gcStyle.textDecoration != undefined) {
                    style.textDecoration = gcStyle.textDecoration;
                }

                bordersArray.forEach(borderName => {
                    if (gcStyle[borderName] != undefined) {
                        const border = {};
                        if (gcStyle[borderName].color != undefined) {
                            border.color = gcStyle[borderName].color;
                        }
                        if (gcStyle[borderName].style != undefined) {
                            border.style = gcStyle[borderName].style;
                        }

                        style[borderName] = border;
                    }
                });

                theme[styleName] = style;
            }
        });

        return theme;
    }


    function buildTheme(theme) {

        tableTheme = new GC.Spread.Sheets.Tables.TableTheme();

        if (typeof theme === 'string') {

            const themeNames = [];

            [
                { name: 'dark', limit: 11 },
                { name: 'light', limit: 21 },
                { name: 'medium', limit: 28 },
                { name: 'professional', limit: 24 }
            ].forEach(element => {
                for (let i = 1; i <= element.limit; i++) {
                    themeNames.push(element.name + i);
                }
            });

            if (themeNames.includes(theme)) {
                tableTheme = GC.Spread.Sheets.Tables.TableThemes[theme];
            }

        } else {

            stripSizeArray.forEach(function (size) {

                if ((size in theme) && (typeof theme[size] === "number")) {
                    tableTheme[size](theme[size]);
                }
            });

            stripStyleArray.forEach(styleName => {

                if ((styleName in theme) && (typeof theme[styleName] === "object")) {

                    const style = theme[styleName];

                    const tableStyle = new GC.Spread.Sheets.Tables.TableStyle();

                    styleAttributesArray.forEach(attributeName => {
                        if ((attributeName in style) && (typeof style[attributeName] === "string")) {
                            tableStyle[attributeName] = style[attributeName];
                        }
                    });

                    if (("textDecoration" in style) && (typeof style.textDecoration === "number")) {
                        tableStyle.textDecoration = style.textDecoration;
                    }

                    bordersArray.forEach(borderName => {
                        if ((borderName in style) && (typeof style[borderName] === "object")) {
                            const border = new GC.Spread.Sheets.LineBorder;
                            if (("color" in style[borderName]) && (typeof style[borderName].color === "string")) {
                                border.color = style[borderName].color;
                            }
                            if (("style" in style[borderName]) && (typeof style[borderName].style === "number")) {
                                border.style = style[borderName].style;
                            }
                            tableStyle[borderName] = border;
                        }
                    });

                    tableTheme[styleName](tableStyle);
                }
            });
        }
        return tableTheme;
    }


    Utils.addCommand('create-table', function (params) {

        if (('ranges' in params) && (params.ranges.constructor === Array)) {

            const i = Utils.getFirstRange(params.ranges);

            const options = {};
            let columns = [];
            let setAllowAutoExpand = false;
            let minHeight = 1;
            let tableTheme = GC.Spread.Sheets.Tables.TableThemes.light18;
            let setBandColumns = false;
            let setBandRows = false;
            let setHighlightFirstColumn = false;
            let setHighlightLastColumn = false;

            if ((params.options != null) && (typeof params.options === 'object')) {

                if (('showHeader' in params.options) && (typeof params.options.showHeader === 'boolean')) {
                    options.showHeader = params.options.showHeader;
                }

                if (('showFooter' in params.options) && (typeof params.options.showFooter === 'boolean')) {
                    options.showFooter = params.options.showFooter;
                    if (options.showFooter) {
                        minHeight++;
                    }
                }

                if (('useFooterDropDownList' in params.options) && (typeof params.options.useFooterDropDownList === 'boolean')) {
                    options.useFooterDropDownList = params.options.useFooterDropDownList;
                }

                if (('showResizeHandle' in params.options) && (typeof params.options.showResizeHandle === 'boolean')) {
                    options.showResizeHandle = params.options.showResizeHandle;
                }

                if (('tableColumns' in params.options) && (params.options.tableColumns.constructor === Array)) {
                    columns = params.options.tableColumns;
                }

                if (('allowAutoExpand' in params.options) && (typeof params.options.allowAutoExpand === 'boolean')) {
                    setAllowAutoExpand = true;
                }

                if (('theme' in params.options)
                    && (
                        (typeof params.options.theme === 'object')
                        || (typeof params.options.theme === 'string')
                    )) {
                    tableTheme = buildTheme(params.options.theme);
                }

                if (('bandColumns' in params.options) && (typeof params.options.bandColumns === 'boolean')) {
                    setBandColumns = true;
                }

                if (('bandRows' in params.options) && (typeof params.options.bandRows === 'boolean')) {
                    setBandRows = true;
                }

                if (('highlightFirstColumn' in params.options) && (typeof params.options.highlightFirstColumn === 'boolean')) {
                    setHighlightFirstColumn = true;
                }

                if (('highlightLastColumn' in params.options) && (typeof params.options.highlightLastColumn === 'boolean')) {
                    setHighlightLastColumn = true;
                }

            }

            if ((params.source == null) || (typeof params.source === 'string')) {

                if (i.rowCount < minHeight) {
                    i.rowCount = minHeight;
                }
                var table = null;
                try {
                    table = i.sheet.tables.add(params.name, i.row, i.column, i.rowCount, i.columnCount, tableTheme, options);
                } catch (e) {
                    Utils.spread.resumeCalcService(true); // Case ID: CAS-59946-R8S4C1 (SJS-32502): resume not called if error occurs
                    throw e;
                }
                const tryToGetAutoCreatedColumn = Utils._tryToGetAutoCreatedColumn;
                if (table != null) {
                    if (columns.length > 0) {
                        const tableColumns = [];
                        let index = 0;
                        columns.forEach(column => {
                            let tableColumn = new GC.Spread.Sheets.Tables.TableColumn(index + 1);
                            if (tryToGetAutoCreatedColumn) {
                                tableColumn = table.getColumn(tableColumn.name()) || tableColumn;
                            }
                            if (typeof (column) === 'object') {
                                if (('formatter' in column) && (typeof column.formatter === 'string')) {
                                    tableColumn.formatter(Utils.adjustFormat(column.formatter));
                                }
                                if (('dataField' in column) && (typeof column.dataField === 'string')) {
                                    tableColumn.dataField(column.dataField);
                                }
                                if (('name' in column) && (typeof column.name === 'string')) {
                                    table.setColumnName(index, column.name + index.toString()); // force rename propagation
                                    table.setColumnName(index, column.name);
                                    tableColumn.name(column.name + index.toString());
                                    tableColumn.name(column.name);
                                }
                            }
                            tableColumns.push(tableColumn);
                            index += 1;
                        });
                        table.autoGenerateColumns(false);
                        table.bindColumns(tableColumns);
                        index = 0;
                        columns.forEach(column => {
                            table.setColumnName(index, column.name + index.toString()); // force rename propagation
                            table.setColumnName(index, column.name);
                            index += 1;
                        });
                    }
                    if ((params.source == null) || (typeof params.source === 'string')) {
                        table.bindingPath(params.source);
                    }
                    if (setAllowAutoExpand) {
                        table.allowAutoExpand(params.options.allowAutoExpand);
                    }
                    if (setBandRows) {
                        table.bandRows(params.options.bandRows);
                    }
                    if (setBandColumns) {
                        table.bandColumns(params.options.bandColumns);
                    }
                    if (setHighlightFirstColumn) {
                        table.highlightFirstColumn(params.options.highlightFirstColumn);
                    }
                    if (setHighlightLastColumn) {
                        table.highlightLastColumn(params.options.highlightLastColumn);
                    }
                }
            }
        }
    });


    Utils.addCommand('remove-table', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                sheet.tables.remove(table, params.options);
            }
        }
    });


    Utils.addCommand('get-tables', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);
        const ret = { collection: [] };

        if (sheet != null) {
            const arr = sheet.tables.all();
            for (let i = 0; i < arr.length; i++) {
                ret.collection.push(arr[i].name());
            }
        }
        return ret;
    });


    Utils.addCommand('insert-table-rows', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                table.insertRows(params.row, params.count, params.isInsertAfter);
            }
        }
    });


    Utils.addCommand('insert-table-columns', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                table.insertColumns(params.column, params.count, params.isInsertAfter);
            }
        }
    });



    Utils.addCommand('remove-table-rows', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                table.deleteRows(params.row, params.count);
            }
        }
    });


    Utils.addCommand('remove-table-columns', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                 table.deleteColumns(params.column, params.count);
             }
        }
    });

    Utils.addCommand('resize-table', function (params) {

        if (('ranges' in params) && (params.ranges.constructor === Array)) {

            const i = Utils.getFirstRange(params.ranges);

            const table = i.sheet.tables.findByName(params.name);
            if (table != null) {
                i.sheet.tables.resize(table, new GC.Spread.Sheets.Range(i.row, i.column, i.rowCount, i.columnCount));
            }
        }
    });

    Utils.addCommand('get-table-range', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);
        const result = { row: 0, column: 0, rowCount: 0, columnCount: 0 };

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                let r = {};
                if (params.onlyData) {
                    r = table.dataRange();
                } else {
                    r = table.range();
                }
                result.row = r.row;
                result.column = r.col;
                result.rowCount = r.rowCount;
                result.columnCount = r.colCount;
            }
        }
        return result;
    });


    Utils.addCommand('find-table', function (params) {
        const ret = { table: '' };

        if (('ranges' in params) && (params.ranges.constructor === Array)) {

            const i = Utils.getFirstRange(params.ranges);

            const table = i.sheet.tables.find(i.row, i.column);
            if (table != null) {
                ret.table = table.name();
            }
        }
        return ret;
    });


    Utils.addCommand('set-table-column-attributes', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                const index = params.index;
                const attributes = params.attributes;
                if (typeof (attributes) === 'object') {
                    if (('name' in attributes) && (typeof attributes.name === 'string')) {
                        table.setColumnName(index, attributes.name);
                    }
                    if (('footerText' in attributes) && (typeof attributes.footerText === 'string')) {
                        table.setColumnValue(index, attributes.footerText);
                    }
                    if (('footerFormula' in attributes) && (typeof attributes.footerFormula === 'string')) {
                        table.setColumnFormula(index, attributes.footerFormula);
                    }
                    if (('dataField' in attributes) && (typeof attributes.dataField === 'string')) {
                        table.setColumnDataField(index, attributes.dataField);
                        table.bindingPath(table.bindingPath());
                        sheet.repaint();
                    }
                    if (('formula' in attributes) && (typeof attributes.formula === 'string')) {
                        table.setColumnDataFormula(index, attributes.formula);
                    }
                    if (('filterButtonVisible' in attributes) && (typeof attributes.filterButtonVisible === 'boolean')) {
                        table.filterButtonVisible(index, attributes.filterButtonVisible);
                    }
                }
            }
        }
    });


    Utils.addCommand('get-table-column-attributes', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);
        let attributes = null;

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                const index = params.index;
                const range = table.range();
                if ((index >= 0) && (index < range.colCount)) {
                    attributes = {
                        name: table.getColumnName(index),
                        footerText: table.getColumnValue(index),
                        footerFormula: table.getColumnFormula(index),
                        dataField: table.getColumnDataField(index),
                        filterButtonVisible: table.filterButtonVisible(index)
                    };
                }
            }
        }
        return attributes;
    });


    Utils.addCommand('get-table-column-index', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);
        const ret = { index: -1 };

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                ret.index = table.getColumnIndexInTable(params.column);
            }
        }
        return ret;
    });

    Utils.addCommand('get-table-dirty-rows', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);
        const ret = { dirtyRows: null };

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {
                ret.dirtyRows = table.getDirtyRows();
                if (params.reset) {
                    table.clearPendingChanges();
                }
            }
        }
        return ret;

    });

    Utils.addCommand('set-table-theme', function (params) {

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {

                if (('bandColumns' in params.theme) && (typeof params.theme.bandColumns === 'boolean')) {
                    table.bandColumns(params.theme.bandColumns);
                }

                if (('bandRows' in params.theme) && (typeof params.theme.bandRows === 'boolean')) {
                    table.bandRows(params.theme.bandRows);
                }

                if (('highlightFirstColumn' in params.theme) && (typeof params.theme.highlightFirstColumn === 'boolean')) {
                    table.highlightFirstColumn(params.theme.highlightFirstColumn);
                }

                if (('highlightLastColumn' in params.theme) && (typeof params.theme.highlightLastColumn === 'boolean')) {
                    table.highlightLastColumn(params.theme.highlightLastColumn);
                }

                if (('theme' in params.theme)
                    && (
                        (typeof params.theme.theme === 'object')
                        || (typeof params.theme.theme === 'string')
                    )) {
                    const tableTheme = buildTheme(params.theme.theme);
                    table.style(tableTheme);
                }
            }
        }

    });

    Utils.addCommand('get-table-theme', function (params) {

        let ret = null;

        const sheet = Utils.resolveSheet(params.sheet);

        if (sheet != null) {
            const table = sheet.tables.findByName(params.name);
            if (table != null) {

                ret = {
                    bandColumns: table.bandColumns(),
                    bandRows: table.bandRows(),
                    highlightLastColumn: table.highlightLastColumn(),
                    highlightFirstColumn: table.highlightFirstColumn(),
                    theme: getTheme(table.style())
                };
            }
        }

        return ret;

    });


})();
