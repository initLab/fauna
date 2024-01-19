class AuthenticationMailer < Devise::Mailer
  def mail(headers = {}, &block)
    super(headers.merge(gpg: {sign: true}), &block)
  end
end
