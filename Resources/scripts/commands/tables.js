
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

Utils.addCommand('create-table', function (params) {

    if (('ranges' in params) && (params.ranges.constructor === Array)) {

        let i = Utils.getFirstRange(params.ranges);

        let options = {};
        let columns = [];
        let setAllowAutoExpand = false;

        if ((params.options != null) && (typeof params.options === 'object')) {

            if (('showHeader' in params.options) && (typeof params.options.showHeader === 'boolean')) {
                options.showHeader = params.options.showHeader;
            }

            if (('showFooter' in params.options) && (typeof params.options.showFooter === 'boolean')) {
                options.showFooter = params.options.showFooter;
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
        }

        let tableTheme = GC.Spread.Sheets.Tables.TableThemes.light18;

        if ((params.source == null) || (typeof params.source === 'string')) {
            if ((columns.length > 0) && (i.rowCount == 1)) {
                i.rowCount = 2;
            }

            let table = i.sheet.tables.add(params.name, i.row, i.column, i.rowCount, i.columnCount, tableTheme, options);

            if (table != null) {
                if (columns.length > 0) {
                    let tableColumns = [];
                    columns.forEach(element => {
                        let tableColumn = new GC.Spread.Sheets.Tables.TableColumn();
                        if (typeof (element) === 'object') {
                            if (('formatter' in element) && (typeof element.formatter === 'string')) {
                                tableColumn.formatter(Utils.adjustFormat(element.formatter));
                            }
                            if (('dataField' in element) && (typeof element.dataField === 'string')) {
                                tableColumn.dataField(element.dataField);
                            }
                            if (('name' in element) && (typeof element.name === 'string')) {
                                tableColumn.name(element.name);
                            }
                        }
                        tableColumns.push(tableColumn);
                    });
                    table.autoGenerateColumns(false);
                    table.bindColumns(tableColumns);
                }
                if ((params.source == null) || (typeof params.source === 'string')) {
                    table.bindingPath(params.source);
                }
                if (setAllowAutoExpand) {
                    table.allowAutoExpand(params.options.allowAutoExpand);
                }
            }
        }
    }
});


Utils.addCommand('remove-table', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            sheet.tables.remove(table, params.options);
        }
    }
});


Utils.addCommand('get-tables', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);
    let ret = { collection: [] };

    if (sheet != null) {
        let arr = sheet.tables.all();
        for (let i = 0; i < arr.length; i++) {
            ret.collection.push(arr[i].name());
        }
    }
    return ret;
});


Utils.addCommand('insert-table-rows', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            table.insertRows(params.row, params.count, params.isInsertAfter);
        }
    }
});


Utils.addCommand('insert-table-columns', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            table.insertColumns(params.column, params.count, params.isInsertAfter);
        }
    }
});



Utils.addCommand('remove-table-rows', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            table.deleteRows(params.row, params.count);
        }
    }
});


Utils.addCommand('remove-table-columns', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            table.deleteColumns(params.column, params.count);
        }
    }
});

Utils.addCommand('resize-table', function (params) {

    if (('ranges' in params) && (params.ranges.constructor === Array)) {

        let i = Utils.getFirstRange(params.ranges);

        let table = i.sheet.tables.findByName(params.name);
        if (table != null) {
            i.sheet.tables.resize(table, new GC.Spread.Sheets.Range(i.row, i.column, i.rowCount, i.columnCount));
        }
    }
});

Utils.addCommand('get-table-range', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);
    let result = { row: 0, column: 0, rowCount: 0, columnCount: 0 };

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            let r = {};
            if (params.onlyData) {
                r = table.range();
            } else {
                r = table.dataRange();
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
    let ret = { table: '' };

    if (('ranges' in params) && (params.ranges.constructor === Array)) {

        let i = Utils.getFirstRange(params.ranges);

        let table = i.sheet.tables.find(i.row, i.column);
        if (table != null) {
            ret.table = table.name();
        }
    }
    return ret;
});


Utils.addCommand('set-table-column-attributes', function (params) {

    let sheet = Utils.resolveSheet(params.sheet);

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            let index = params.index;
            let attributes = params.attributes;
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

    let sheet = Utils.resolveSheet(params.sheet);
    let attributes = null;

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            let index = params.index;
            let range = table.range();
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

    let sheet = Utils.resolveSheet(params.sheet);
    let ret = { index: -1 };

    if (sheet != null) {
        let table = sheet.tables.findByName(params.name);
        if (table != null) {
            ret.index = table.getColumnIndexInTable(params.column);
        }
    }
    return ret;
});

