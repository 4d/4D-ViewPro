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
	/**
	 * AREANAME
	 */
	function AreaNameFunction() {
		this.name = 'AREANAME';
		this.minArgs = 0;
		this.maxArgs = 0;
	}

	AreaNameFunction.prototype = new CustomFunction();

	AreaNameFunction.prototype.evaluate = function (params) {
		return Utils.areaName;
	};

	const areaName = new AreaNameFunction();

	Utils.defineGlobalCustomFunction(areaName.name, areaName, 'custom-command');

	/**
	 * COLUMNLETTER
	 */
	function ColumnLetterFunction() {
		this.name = 'COLUMNLETTER';
		this.minArgs = 0;
		this.maxArgs = 1;
	}

	ColumnLetterFunction.prototype = new CustomFunction();

	ColumnLetterFunction.prototype.evaluateWithContext = function (context, params) {
		let column;

		if (params.length) {
			const range = params[0];

			column = range.getColumn();
		} else {
			column = context.column;
		}

		return Utils.indexToLetters(column + 1);
	};

	const ColumnLetter = new ColumnLetterFunction();

	ColumnLetter.isContextSensitive = ColumnLetter.acceptsReference = function () {
		return true;
	};

	Utils.defineGlobalCustomFunction(ColumnLetter.name, ColumnLetter, 'custom-command');

	/**
	 * FINDCELL
	 */
	function FindCellFunction() {
		this.name = 'FINDCELL';
		this.minArgs = 2;
		this.maxArgs = 2;
	}

	FindCellFunction.prototype = new CustomFunction();

	FindCellFunction.prototype.evaluateWithContext = function (context, params) {
		const cell = params[0];
		const range = params[1];

		const value = Utils.currentSheet.getCell(cell.getRow(), cell.getColumn()).value();
		const arrayRowCount = range.getRowCount(0);
		const arrayColumnCount = range.getColumnCount(0);
		const cellCount = arrayColumnCount * arrayRowCount;
		const offsetRow = range.getRow();
		const offsetCol = range.getColumn();

		for (let i = 0; i < cellCount; ++i) {
			const r = Math.floor(i / arrayColumnCount);
			const c = i % arrayColumnCount;
			const cellValue = range.getValue(0, r, c);

			if (cellValue === value) { // TODO: handle types equality
				return range.create([{ row: offsetRow + r, col: offsetCol + c, rowCount: 1, colCount: 1 }]);
			}
		}

		return Utils.errors.notAny;
	};

	const FindCell = new FindCellFunction();

	FindCell.isContextSensitive = FindCell.acceptsReference = FindCell.returnReference = function () {
		return true;
	};

	Utils.defineGlobalCustomFunction(FindCell.name, FindCell, 'custom-command');
})();