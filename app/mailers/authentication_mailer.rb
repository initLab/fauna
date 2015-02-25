class AuthenticationMailer < Devise::Mailer
  def mail(headers = {}, &block)
    headers[:gpg] = {sign: true}
    super headers, &block
  end
end
