// temporary fix to avoid on central european time a wrong computation of time with historical dates
// because timezoneOffset uses seconds for dates around 1900. Using this algorithm returns
// a decimal timezoneOffset that has more precision than the generic getDateTimeOffset that returns only minutes
(function () {
    const _getTimezoneOffset = Date.prototype.getTimezoneOffset;

    Date.prototype.getTimezoneOffset = function () {
        const year = this.getFullYear();
        const month = this.getMonth();
        const day = this.getDate();
        if ((year < 1911) || ((year == 1911) && ((month < 2)) || ((month == 2) && (day < 11)))) {
            const utcDate = new Date(Date.UTC(year, month, day));
            const localDate = new Date(year, month, day);
            return (localDate.getTime() - utcDate.getTime()) / 60000;
        } else {
            return _getTimezoneOffset.apply(this);
        }
    };
})();