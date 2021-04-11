$(function() {
    const units = {
        'Temperature': ['°C', 1],
        'Humidity': ['%', 1]
    };

    const template = $('<div />').addClass('panel panel-primary').append(
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

    const elements = $('[data-label-type][data-mqtt-topic]');

    if (elements.length === 0) {
        return;
    }

    const topics = elements.map(function () {
        return $(this).data('mqtt-topic');
    }).get().filter(function (value, index, self) {
        return self.indexOf(value) === index;
    });

    const mqttClient = mqtt.connect('wss://spitfire.initlab.org:8083/mqtt');

    mqttClient.on('connect', function () {
        topics.forEach(function (topic) {
            mqttClient.subscribe(topic);
        });
    });

    mqttClient.on('message', function(topic, data, message) {
        // Xiaomi BLE devices send data rarely (10 min), unlike the Espurna-based devices,
        // which can send data every 6 secs. It would be a better idea to just show the retained
        // measurements on page load, instead of waiting for a fresh one.
        //
        // if (message.retain) {
        //     return;
        // }

        const element = $('[data-mqtt-topic="' + topic + '"]');

        if (element.length === 0) {
            return;
        }

        const type = element.data('label-type');
        const label = element.data('label');
        const unit = units[type];
        const value = data ? (parseFloat(data.toString()).toFixed(unit[1]) + unit[0]) : 'No data';
        const box = template.clone().find('.placeholder-value').text(value).end()
            .find('.placeholder-description').text(label).end();
        element.empty().append(box);
    });
});
