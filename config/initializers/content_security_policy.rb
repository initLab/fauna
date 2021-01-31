# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |policy|
  policy.base_uri        :self
  policy.default_src     :none
  policy.connect_src     :self, 'wss://spitfire.initlab.org:8083/'
  policy.font_src        :self
  policy.img_src         :self, :data, :https, 'http://stats.initlab.org/' # TODO: Remove this once all gravatars are cached locally in the app
  policy.object_src      :none
  policy.script_src      :self, :unsafe_eval, 'https://unpkg.com/' # TODO: Remove this once all use of js.erb templaces is removed
  policy.style_src       :self
  policy.manifest_src    :self

  # Specify URI for violation reports
  # policy.report_uri "/csp-violation-report-endpoint"
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
