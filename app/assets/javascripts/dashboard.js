(function() {
    var units = {
        'Temperature': ['°C', 1],
        'Humidity': ['%', 1]
    };

    var template = $('<div />').addClass('panel panel-primary').append(
        $('<div />').addClass('panel-heading').append(
            $('<div />').addClass('row').append(
                $('<div />').addClass('col-xs-3').append(
                    $('<i />').addClass('fa fa-thermometer-half fa-5x')
                ),
                $('<div />').addClass('col-xs-9 text-right').append(
                    $('<div />').addClass('huge placeholder-value'),
                    $('<div />').addClass('placeholder-description')
                )
            )
        )
    );

    function requestsDone(elements) {
        var values = {};
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

                var fieldKey = 'field' + i;
                var fieldName = response.channel[fieldKey];
                var typePos = fieldName.indexOf(':');
                var dataType, location;

                if (typePos > -1) {
                    dataType = fieldName.substr(0, typePos);
                    location = fieldName.substr(typePos + 1);
                }
                else {
                    dataType = fieldName;
                    location = '[unknown]';
                }

                if (!(dataType in values)) {
                    values[dataType] = {};
                }

                //var name = (response.channel.description || response.channel.name) + ': ' + location;
                var name = location;

                values[dataType][response.channel.id] = {
                    type: dataType,
                    name: name,
                    value: response.feeds.length ? parseFloat(response.feeds[0][fieldKey]) : null
                };
            }
        });

        elements.each(function() {
            var $this = $(this);

            var type = $this.data('label-type');
            var chanId = $this.data('thingspeak-channel-id');

            if (!(type in values) || !(chanId in values[type])) {
                return;
            }

            var data = values[type][chanId];
            var unit = units[data.type];
            var value = data.value ? (data.value.toFixed(unit[1]) + unit[0]) : 'No data';
            var box = template.clone().find('.placeholder-value').text(value).end()
                .find('.placeholder-description').text(data.name).end();
            $this.replaceWith(box);
        });
    }

    $(document).on({
        'turbolinks:load': function() {
            var elements = $('[data-label-type][data-thingspeak-channel-id]');

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
                    '/feed.json?days=1&results=1'
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
        }
    });
})();
