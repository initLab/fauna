$(function() {
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

    var elements = $('[data-label-type][data-mqtt-topic]');

    if (elements.length === 0) {
        return;
    }

    var topics = elements.map(function () {
        return $(this).data('mqtt-topic');
    }).get().filter(function (value, index, self) {
        return self.indexOf(value) === index;
    });

    var mqttClient = mqtt.connect('wss://spitfire.initlab.org:8083/mqtt');

    mqttClient.on('connect', function () {
        topics.forEach(function (topic) {
            mqttClient.subscribe(topic);
        });
    });

    mqttClient.on('message', function(topic, data) {
        console.log(topic, data.toString());

        var element = $('[data-mqtt-topic="' + topic + '"]');

        if (element.length === 0) {
            return;
        }

        var type = element.data('label-type');
        var label = element.data('label');
        var unit = units[type];
        var value = data ? (parseFloat(data.toString()).toFixed(unit[1]) + unit[0]) : 'No data';
        var box = template.clone().find('.placeholder-value').text(value).end()
            .find('.placeholder-description').text(label).end();
        element.empty().append(box);
    });
});
