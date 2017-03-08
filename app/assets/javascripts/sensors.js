Highcharts.setOptions({
    credits: false,
    global: {
        useUTC: false
    }
});

(function() {
    var units = {
        'Temperature': ['°C', 1],
        'Humidity': ['%', 1]
    };

    var maxMissingPeriod = 75000; // 75 sec

    function makeChartParams(chart) {
        var unit = units[chart.type];

        return {
            chart: {
                height: 250,
                backgroundColor: 'transparent'
            },
            title: {
                text: chart.name
            },
            xAxis: {
                type: 'datetime'
            },
            yAxis: {
                title: {
                    text: chart.type + ' (' + unit[0] + ')'
                },
                tickInterval: 0.1,
                plotLines: [{
                    color: '#aaa',
                    width: 2,
                    value: 0
                }]
            },
            tooltip: {
                valueDecimals: unit[1],
                valueSuffix: unit[0],
                xDateFormat: '%A, %b %e, %H:%M:%S'
            },
            legend: {
                enabled: false
            },
            series: chart.series
        };
    }

    function requestsDone(elements) {
        var charts = {};
        var responses = Array.prototype.slice.call(arguments, 1);

        $.each(responses, function () {
            var response = this[0];
            //var textStatus = this[1];
            //var jqXHR = this[2];

            var i;
            for (i = 1; i <= 10; ++i) {
                if (!('field' + i in response.channel)) {
                    continue;
                }

                var fieldName = response.channel['field' + i];
                var typePos = fieldName.indexOf(':');
                var chartType, location;

                if (typePos > -1) {
                    chartType = fieldName.substr(0, typePos);
                    location = fieldName.substr(typePos + 1);
                }
                else {
                    chartType = fieldName;
                    location = '[unknown]';
                }

                if (!(chartType in charts)) {
                    charts[chartType] = {};
                }

                var data = [];
                var lastTs = 0;

                $.each(response.feeds, function () {
                    var value = this['field' + i];

                    if (typeof value !== 'string' || !value.length) {
                        return;
                    }

                    var ts = Date.parse(this.created_at);

                    if (lastTs === 0) {
                        lastTs = ts;
                    }

                    var nextTsLimit = lastTs + maxMissingPeriod;

                    if (ts > nextTsLimit) {
                        data.push([nextTsLimit, null]);
                    }

                    value = parseFloat(value);

                    lastTs = ts;

                    data.push([ts, value]);
                });

                var name = (response.channel.description || response.channel.name) + ': ' + location;

                if (!data.length) {
                    console.warn('skipped field "' + name + '" in "' + chartType + '" - no data');
                    continue;
                }

                charts[chartType][response.channel.id] = {
                    type: chartType,
                    name: name,
                    series: [{
                        name: chartType,
                        data: data
                    }]
                };
            }
        });

        elements.each(function() {
            var $this = $(this);

            var type = $this.data('chart-type');
            var chanId = $this.data('thingspeak-channel-id');

            if (!(type in charts) || !(chanId in charts[type])) {
                return;
            }

            var chart = charts[type][chanId];

            $this.highcharts(makeChartParams(chart));
        });
    }

    $(document).on({
        'turbolinks:load': function() {
            var elements = $('[data-chart-type][data-thingspeak-channel-id]');

            if (elements.length === 0) {
                return;
            }

            var channelIds = elements.map(function () {
                return $(this).data('thingspeak-channel-id');
            }).get().filter(function (value, index, self) {
                return self.indexOf(value) === index;
            });

            var requests = [];

            $.each(channelIds, function (index, chanId) {
                requests.push($.getJSON(
                    'https://api.thingspeak.com/channels/' +
                    chanId +
                    '/feed.json?days=1&results=120'
                ));
            });

            $.when.apply($, requests).done(function () {
                var args = Array.prototype.slice.call(arguments);

                if (requests.length === 1) {
                    args = [args];
                }

                args.unshift(elements);
                requestsDone.apply(window, args);
            });
        },
        'turbolinks:before-cache': function() {
            $('[data-highcharts-chart]').each(function() {
                var $this = $(this);
                $this.highcharts().destroy();
            });
        }
    });
})();
