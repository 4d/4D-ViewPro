
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

    // ═══════════════════════════════════════════════════════════════
    // 4D REST Adapter — isolated for future $4d._vp_xxx replacement
    // Only used in DataClass mode
    // ═══════════════════════════════════════════════════════════════

    const _4DRestAdapter = {

        read: function (dataClassName, params) {
            let url = 'http://localhost:8080/rest/' + dataClassName + '?$asArray=true';

            if (params.top != null) {
                url += '&$top=' + params.top;
            }
            if (params.skip != null) {
                url += '&$skip=' + params.skip;
            }
            if (params.orderby) {
                url += '&$orderby=' + params.orderby;
            }
            if (params.filter) {
                url += '&$filter=' + params.filter;
            }

            return fetch(url, {
                credentials: 'include',
                headers: { 'Accept': 'application/json' }
            }).then(function (response) {
                return response.json();
            }).then(function (json) {
                var data = Array.isArray(json)
                    ? json
                    : json.__ENTITIES || json.rows || json.data || json.result || [];
                return {
                    data: data,
                    totalCount: json.__COUNT != null ? json.__COUNT : data.length
                };
            });
        },

        create: function (dataClassName, entity) {
            return fetch('/rest/' + dataClassName, {
                method: 'POST',
                credentials: 'include',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(entity)
            }).then(function (response) {
                return response.json();
            });
        },

        update: function (dataClassName, entity) {
            var key = entity.__KEY || entity.ID;
            return fetch('/rest/' + dataClassName + '(' + key + ')', {
                method: 'PATCH',
                credentials: 'include',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(entity)
            }).then(function (response) {
                return response.json();
            });
        },

        destroy: function (dataClassName, entity) {
            var key = entity.__KEY || entity.ID;
            return fetch('/rest/' + dataClassName + '(' + key + ')', {
                method: 'DELETE',
                credentials: 'include'
            });
        }
    };

    // ── Future bridge adapter prototype (uncomment when $4d._vp_xxx are available) ──
    //
    // const _4DBridgeAdapter = {
    //     read: function (dataClassName, params) {
    //         return new Promise(function (resolve, reject) {
    //             $4d._vp_dataSourceRead(dataClassName, params, function (result, err) {
    //                 if (err) reject(err);
    //                 else resolve({ data: result.__ENTITIES, totalCount: result.__COUNT });
    //             });
    //         });
    //     },
    //     create: function (dataClassName, entity) {
    //         return new Promise(function (resolve, reject) {
    //             $4d._vp_dataSourceCreate(dataClassName, entity, function (result, err) {
    //                 if (err) reject(err);
    //                 else resolve(result);
    //             });
    //         });
    //     },
    //     update: function (dataClassName, entity) {
    //         return new Promise(function (resolve, reject) {
    //             $4d._vp_dataSourceUpdate(dataClassName, entity.__KEY || entity.ID, entity, function (result, err) {
    //                 if (err) reject(err);
    //                 else resolve(result);
    //             });
    //         });
    //     },
    //     destroy: function (dataClassName, entity) {
    //         return new Promise(function (resolve, reject) {
    //             $4d._vp_dataSourceDelete(dataClassName, entity.__KEY || entity.ID, function (result, err) {
    //                 if (err) reject(err);
    //                 else resolve(result);
    //             });
    //         });
    //     }
    // };

    // ═══════════════════════════════════════════════════════════════
    // Type mapping: 4D ORDA attribute types → SpreadJS column types
    // ═══════════════════════════════════════════════════════════════

    function mapFieldType(fourDType) {
        if (!fourDType) {
            return 'string';
        }
        var lower = String(fourDType).toLowerCase();

        if (lower === 'number' || lower === 'long' || lower === 'long64'
            || lower === 'float' || lower === 'real' || lower === 'integer'
            || lower === 'byte' || lower === 'word') {
            return 'number';
        }
        if (lower === 'date') {
            return 'date';
        }
        if (lower === 'bool' || lower === 'boolean') {
            return 'boolean';
        }
        return 'string';
    }

    // ═══════════════════════════════════════════════════════════════
    // Schema builder from 4D ORDA attributes (passed from 4D side)
    // ═══════════════════════════════════════════════════════════════

    function buildSchemaFromAttributes(attributes) {
        var columns = {};

        if (Array.isArray(attributes)) {
            attributes.forEach(function (attr) {
                if (attr && attr.name) {
                    columns[attr.name] = {
                        dataType: mapFieldType(attr.type)
                    };
                }
            });
        }

        return { columns: columns };
    }

    // ═══════════════════════════════════════════════════════════════
    // Custom mode: normalize user-provided remote config into
    // SpreadJS DataManager remote functions
    // ═══════════════════════════════════════════════════════════════

    function buildCustomRemoteHandler(operationConfig, defaultMethod) {
        if (typeof operationConfig === 'function') {
            return operationConfig;
        }

        var url, method, headers;

        if (typeof operationConfig === 'string') {
            url = operationConfig;
            method = defaultMethod;
            headers = {};
        } else if (typeof operationConfig === 'object' && operationConfig !== null) {
            url = operationConfig.url;
            method = operationConfig.method || defaultMethod;
            headers = operationConfig.headers || {};
        }

        if (!url) {
            return null;
        }

        return function (args) {
            var fetchOptions = {
                method: method,
                headers: Object.assign({ 'Accept': 'application/json' }, headers)
            };

            if (method !== 'GET' && method !== 'DELETE' && args && args.item) {
                fetchOptions.headers['Content-Type'] = 'application/json';
                fetchOptions.body = JSON.stringify(args.item);
            }

            return fetch(url, fetchOptions).then(function (response) {
                if (method === 'DELETE') {
                    return {};
                }
                return response.json();
            });
        };
    }

    function buildCustomRemote(remoteOptions, readOnly, permissions) {
        var remote = {};

        if (remoteOptions.read) {
            remote.read = buildCustomRemoteHandler(remoteOptions.read, 'GET');
        }

        if (!readOnly) {
            if (permissions.allowCreate && remoteOptions.create) {
                remote.create = buildCustomRemoteHandler(remoteOptions.create, 'POST');
            }
            if (permissions.allowUpdate && remoteOptions.update) {
                remote.update = buildCustomRemoteHandler(remoteOptions.update, 'PATCH');
            }
            if (permissions.allowDelete && (remoteOptions.destroy || remoteOptions['delete'])) {
                remote.destroy = buildCustomRemoteHandler(
                    remoteOptions.destroy || remoteOptions['delete'], 'DELETE'
                );
            }
        }

        return remote;
    }

    // ═══════════════════════════════════════════════════════════════
    // Relationship resolution — deferred pattern for DataClass mode
    // ═══════════════════════════════════════════════════════════════

    var _pendingRelations = {};

    function registerRelation(dataManager, rel) {
        var sourceTable = dataManager.tables[rel.sourceTableName];
        var targetTable = dataManager.tables[rel.targetTableName];

        if (sourceTable && targetTable) {
            dataManager.addRelationship(
                sourceTable, rel.sourceField, rel.sourceRelName,
                targetTable, rel.targetField, rel.targetRelName
            );
        } else {
            var missingName = !sourceTable ? rel.sourceTableName : rel.targetTableName;
            if (!_pendingRelations[missingName]) {
                _pendingRelations[missingName] = [];
            }
            _pendingRelations[missingName].push(rel);
        }
    }

    function resolvePendingRelations(dataManager, tableName) {
        var pending = _pendingRelations[tableName];
        if (!pending) {
            return;
        }
        delete _pendingRelations[tableName];

        pending.forEach(function (rel) {
            registerRelation(dataManager, rel);
        });
    }

    // ═══════════════════════════════════════════════════════════════
    // Commands
    // ═══════════════════════════════════════════════════════════════

    Utils.addCommand('add-data-source', function (params) {

        var dataManager = Utils.spread.dataManager();
        var tableName = params.name;
        var options = params.options || {};

        var readOnly = (typeof options.readOnly === 'boolean') ? options.readOnly : false;
        var permissions = {
            allowCreate: readOnly ? false : (typeof options.allowCreate === 'boolean' ? options.allowCreate : true),
            allowUpdate: readOnly ? false : (typeof options.allowUpdate === 'boolean' ? options.allowUpdate : true),
            allowDelete: readOnly ? false : (typeof options.allowDelete === 'boolean' ? options.allowDelete : true)
        };
        var pageSize = (typeof options.pageSize === 'number') ? options.pageSize : 100;
        var tableOptions = {};

        if (params.mode === 'dataclass') {

            var dataClassName = params.dataClassName;

            tableOptions.schema = buildSchemaFromAttributes(params.attributes);
            tableOptions.primaryKey = '__KEY';

            tableOptions.remote = {
                read: function (args) {
                    var readParams = {
                        top: args.pageSize || pageSize,
                        skip: args.skip || 0
                    };
                    if (args.sort && args.sort.length) {
                        readParams.orderby = args.sort
                            .map(function (s) { return s.field + ' ' + (s.ascending === false ? 'desc' : 'asc'); })
                            .join(',');
                    }
                    if (args.filter) {
                        readParams.filter = args.filter;
                    }
                    return _4DRestAdapter.read(dataClassName, readParams);
                }
            };

            if (permissions.allowCreate) {
                tableOptions.remote.create = function (args) {
                    return _4DRestAdapter.create(dataClassName, args.item);
                };
            }
            if (permissions.allowUpdate) {
                tableOptions.remote.update = function (args) {
                    return _4DRestAdapter.update(dataClassName, args.item);
                };
            }
            if (permissions.allowDelete) {
                tableOptions.remote.destroy = function (args) {
                    return _4DRestAdapter.destroy(dataClassName, args.item);
                };
            }

        } else if (params.mode === 'data') {

            tableOptions.data = params.data;
            if (params.schema) {
                tableOptions.schema = params.schema;
            }

        } else {

            if (params.remote) {
                tableOptions.remote = buildCustomRemote(params.remote, readOnly, permissions);
            }
            if (params.schema) {
                tableOptions.schema = params.schema;
            }
        }

        if (typeof options.autoSync === 'boolean' && options.autoSync === false) {
            tableOptions.batch = true;
        }

        if (params.primaryKey) {
            tableOptions.primaryKey = tableOptions.primaryKey || params.primaryKey;
        }

        if (params.relationships) {
            tableOptions.relationships = params.relationships;
        }

        dataManager.addTable(tableName, tableOptions);

        if (params.relations) {
            params.relations.forEach(function (rel) {
                if (rel.kind === 'relatedEntity') {
                    registerRelation(dataManager, {
                        sourceTableName: rel.relatedDataClass,
                        sourceField: '__KEY',
                        sourceRelName: rel.inverseName || tableName,
                        targetTableName: tableName,
                        targetField: rel.name,
                        targetRelName: rel.name
                    });
                }
            });
        }

        resolvePendingRelations(dataManager, tableName);
    });


    Utils.addCommand('remove-data-source', function (params) {

        var dataManager = Utils.spread.dataManager();

        if (dataManager && dataManager.tables && dataManager.tables[params.name]) {
            dataManager.removeTable(params.name);
        }
    });


    Utils.addCommand('create-table-sheet', function (params) {

        var spread = Utils.spread;
        var dataManager = spread.dataManager();
        var table = dataManager.tables[params.source];

        if (!table) {
            return;
        }

        var sheetName = params.sheetName || params.name;
        var viewName = params.name;
        var sheetTab = spread.addSheetTab(spread.getSheetCount(), sheetName, GC.Spread.Sheets.SheetType.tableSheet);

        if (sheetTab) {
            var columns = params.columns || [];
            var viewOptions = {};
            if (params.defaultColumnWidth != null) {
                viewOptions.defaultColumnWidth = params.defaultColumnWidth;
            }
            var hasViewOptions = Object.keys(viewOptions).length > 0;
            var view = hasViewOptions
                ? table.addView(viewName, columns, columns.length === 0, viewOptions)
                : table.addView(viewName, columns);

            sheetTab._vpDataSource = params.source;
            sheetTab._vpViewName = viewName;

            view.fetch().then(function () {
                sheetTab.setDataView(view);
            });
        }
    });


    Utils.addCommand('remove-table-sheet', function (params) {

        var spread = Utils.spread;
        var sheetName = params.sheetName || params.name;

        for (var i = spread.getSheetCount() - 1; i >= 0; i--) {
            var sheetTab = spread.sheets[i];
            if (sheetTab && sheetTab.name() === sheetName) {
                var source = sheetTab._vpDataSource;
                var viewName = sheetTab._vpViewName;

                spread.removeSheet(i);

                if (source && viewName) {
                    var dataManager = spread.dataManager();
                    var table = dataManager && dataManager.tables[source];
                    if (table && table.views[viewName]) {
                        table.removeView(viewName);
                    }
                }
                break;
            }
        }
    });

})();
