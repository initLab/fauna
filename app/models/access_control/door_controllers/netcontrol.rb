class AccessControl::DoorControllers::Netcontrol
  PATH = "/iochange.cgi".freeze
  TIMEOUT = 5 # seconds

  def initialize(host:, port: 80, username: "admin", password: "password", actions: {})
    @host, @port, @username, @password = host, port, username, password

    @actions = actions.transform_values do |settings|
      settings => {port: netcontrol_port, value:}

      URI::HTTP.build(
        host: @host,
        port: @port,
        path: PATH,
        query: URI.encode_www_form(
          "ref" => "re-io",
          netcontrol_port => value
        )
      ).freeze
    end
  end

  def call(action)
    request = Net::HTTP::Get.new(@actions.fetch(action))
    request.basic_auth @username, @password

    Net::HTTP.start(@host, @port, read_timeout: TIMEOUT, open_timeout: TIMEOUT, write_timeout: TIMEOUT) do |http|
      http.request(request).tap do |response|
        raise unless response.is_a?(Net::HTTPSuccess)
      end
    end
  end
end
