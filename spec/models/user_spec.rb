# -*- coding: utf-8 -*-
require 'rails_helper'

describe User do
  it 'lets Devise handle email and password validations' do
    expect(build(:user)).to be_a Devise::Models::Validatable
  end

  it 'lets Devise handle email confirmations' do
    expect(build(:user)).to be_a Devise::Models::Confirmable
  end

  it 'lets Devise handle account locking' do
    expect(build(:user)).to be_a Devise::Models::Lockable
  end

  describe 'name' do
    it 'must be present' do
      expect(build(:user, name: nil)).to have_error_on :name
    end
  end

  describe '::find_for_database_authentication' do
    let(:user) { create :user }

    it 'returns the user whose email is passed' do
      expect(User.find_for_database_authentication login: user.email).to eq user
    end

    it 'returns the user whose username is passed' do
      expect(User.find_for_database_authentication login: user.username).to eq user
    end

    it 'returns nil when the passed login does not exist' do
      expect(User.find_for_database_authentication login: "randomuser").to be_nil
    end

    it 'returns the user despite her login having heading/tralining whitespace' do
      expect(User.find_for_database_authentication login: " #{user.email}").to eq user
      expect(User.find_for_database_authentication login: " #{user.username}").to eq user
    end

    it 'returns the user despite of case differences in her login' do
      expect(User.find_for_database_authentication login: " #{user.email.upcase}").to eq user
      expect(User.find_for_database_authentication login: " #{user.username.upcase}").to eq user
    end

    context 'when there are users with no username' do
      let(:legacy_users) { build_list :user, 5, username: nil }

      before do
        legacy_users.each { |user| user.save(validate: false) }
        create_list :user, 5
      end

      it 'returns the legacy user when passed her email' do
        expect(User.find_for_database_authentication login: legacy_users.first.email).to eq legacy_users.first
      end

      it 'returns nil when the login is nil' do
        expect(User.find_for_database_authentication login: nil).to be_nil
      end

      it 'returns nil when the login is omitted' do
        expect(User.find_for_database_authentication({})).to be_nil
      end

      it 'returns nil when the login is blank' do
        expect(User.find_for_database_authentication({login: ''})).to be_nil
      end
    end
  end

  describe 'username' do
    it 'must be present' do
      expect(build(:user, username: nil)).to have_error_on :username
    end

    it 'must be at least one character' do
      expect(build(:user, username: '')).to have_error_on :username
    end

    it 'must be unique' do
      existing_user = create :user

      expect(build(:user, username: existing_user.username)).to have_error_on :username
    end

    it 'must only contain letters, numbers, _ and -' do
      invalid_usernames = %w(ji*r3f пешо +vlado)

      invalid_usernames.each do |username|
        expect(build(:user, username: username)).to have_error_on :username
      end
    end

    it 'can never be an email' do
      expect(build(:user, username: 'foo@bar')).to have_error_on :username
      expect(build(:user, username: 'foo@bar.com')).to have_error_on :username
    end
  end

  describe '#destroy' do
    let(:user) { create :user }

    before do
      create :network_device, owner: user
      create :phone_number, owner: user
    end

    it 'destroys dependent NetworkDevices' do
      network_device = user.network_devices.first
      user.destroy
      expect { NetworkDevice.find network_device.id }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'destroys dependent PhoneNumbers' do
      phone_number = user.phone_numbers.first
      user.destroy
      expect { PhoneNumber.find phone_number.id }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'url' do
    let(:valid_urls) { %w(http://foo.bar https://foo.bar)}
    let(:invalid_urls) { %w(javascript:alert(foo.bar) mailto:)}

    it 'can be nil' do
      expect(build(:user, url: nil)).to_not have_error_on :url
      expect(build(:user, url: '')).to_not have_error_on :url
    end

    it 'can be an HTTP URL' do
      expect(build(:user, url: 'http://example.com')).to_not have_error_on :url
    end

    it 'can be an HTTPS URL' do
      expect(build(:user, url: 'https://example.com')).to_not have_error_on :url
    end

    it 'cannot be anything but an HTTP(S) URL' do
      expect(build(:user, url: 'javascript:alert(foo)')).to have_error_on :url
      expect(build(:user, url: 'example.com')).to have_error_on :url
      expect(build(:user, url: 'foobar')).to have_error_on :url
    end
  end

  describe 'twitter handle' do
    let(:valid_handles) { %w(f F 1 _ foo fOO FOO f_oo f00) }
    let(:invalid_handles) { %w(- абв abcdefghijklmnopqrst) }

    it 'is stored without a starting @' do
      expect(build(:user, twitter: '@foobar').twitter).to eq 'foobar'
    end

    it 'can be nil' do
      expect(build(:user, twitter: nil)).to_not have_error_on :twitter
    end

    it 'can be a valid handle' do
      valid_handles.each do |handle|
        expect(build(:user, twitter: handle)).to_not have_error_on :twitter
      end
    end

    it 'cannot be an invalid handle' do
      invalid_handles.each do |handle|
        expect(build(:user, twitter: handle)).to have_error_on :twitter
      end
    end
  end

  describe 'github username' do
    it 'can be nil' do
      expect(build(:user, github: nil)).to_not have_error_on :github
    end

    it 'can only contain alphanumeric characters or dashes' do
      expect(build(:user, github: '!foobar')).to have_error_on :github
      expect(build(:user, github: 'foobar')).to_not have_error_on :github
      expect(build(:user, github: 'foobar-')).to_not have_error_on :github
      expect(build(:user, github: 'foobar123')).to_not have_error_on :github
    end

    it 'cannot begin with a dash' do
      expect(build(:user, github: '-foobar')).to have_error_on :github
    end

    it 'cannot be longer than 39 characters' do
      expect(build(:user, github: 'a' * 40)).to have_error_on :github
      expect(build(:user, github: 'a' * 39)).to_not have_error_on :github
    end
  end

  describe 'jabber account' do
    it 'can be nil' do
      expect(build(:user, jabber: nil)).to_not have_error_on :jabber
    end

    it 'must contain exactly one @' do
      expect(build(:user, jabber: 'foo@bar.com')).to_not have_error_on :jabber
      expect(build(:user, jabber: 'foobar.com')).to have_error_on :jabber
      expect(build(:user, jabber: 'foo@@bar.com')).to have_error_on :jabber
    end
  end

  describe 'GPG key fingerprint' do
    it 'can be nil' do
      expect(build(:user, gpg_fingerprint: nil)).to_not have_error_on :gpg_fingerprint
    end

    it 'must contain 40 hex case insensitive digits separated with any number of spaces' do
      expect(build(:user, gpg_fingerprint: 'a' * 40)).to_not have_error_on :gpg_fingerprint
      expect(build(:user, gpg_fingerprint: 'A' * 40)).to_not have_error_on :gpg_fingerprint
      expect(build(:user, gpg_fingerprint: 'aaaa aaaa aaaa aaaa aaaa  aaaa aaaa aaaa aaaa aaaa')).to_not have_error_on :gpg_fingerprint
      expect(build(:user, gpg_fingerprint: 'AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA')).to_not have_error_on :gpg_fingerprint

      expect(build(:user, gpg_fingerprint: 'z' * 40)).to have_error_on :gpg_fingerprint
      expect(build(:user, gpg_fingerprint: 'a' * 39)).to have_error_on :gpg_fingerprint
    end

    it 'stores the gpg fingerprint upcased and properly delimited with spaces' do
      expect(create(:user, gpg_fingerprint: 'a' * 40).gpg_fingerprint).to eq 'AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA AAAA'
    end
  end

  describe '#pin' do
    it 'should return the pin' do
      expect(build(:user, pin: 123456).pin).to eq 123456
    end
  end

  describe '#pin=' do
    it 'should not set the value of encrypted_pin whenever pin is blank or nil' do
      user = build :user, encrypted_pin: '$2a$10$eiD5w/oMitEM1kXoFmxWQOFlLCNZTAwV/IZOGo8UMIROvg0W4iXRy'
      expect {user.pin = ''}.to_not change(user, :encrypted_pin)
      expect {user.pin = nil}.to_not change(user, :encrypted_pin)
    end

    it 'should set the value of encrypted_pin to a BCrypt::Password encrypted version of pin' do
      user = build :user

      expect(BCrypt::Password).to receive(:create).and_return(BCrypt::Password.new '$2a$10$eiD5w/oMitEM1kXoFmxWQOFlLCNZTAwV/IZOGo8UMIROvg0W4iXRy')

      expect {user.pin = '123456'}.to change(user, :encrypted_pin)
      expect(user.encrypted_pin).to eq '$2a$10$eiD5w/oMitEM1kXoFmxWQOFlLCNZTAwV/IZOGo8UMIROvg0W4iXRy'
    end
  end

  describe 'pin' do
    it 'can be nil' do
      expect(build(:user, pin: nil)).to_not have_error_on :pin
    end

    it 'must be a 6-digit number when it\'s not nil' do
      expect(build(:user, pin: 123456)).to_not have_error_on :pin
      expect(build(:user, pin: 123)).to have_error_on :pin
      expect(build(:user, pin: 1234567)).to have_error_on :pin
      expect(build(:user, pin: 'abcdef')).to have_error_on :pin
    end

    it 'must check if confirmation matches' do
      expect(build(:user, pin: 123456, pin_confirmation: 123456)).to_not have_error_on :pin_confirmation
      expect(build(:user, pin: 123456, pin_confirmation: 12345)).to have_error_on :pin_confirmation
    end
  end

  describe '#email_md5' do
    it 'returns an md5 sum of the email' do
      user = build :user, email: 'foo@example.com'
      expect(user.email_md5).to eq 'b48def645758b95537d4424c84d1a9ff'
    end
  end

  describe '#to_s' do
    it 'returns the user id, email and name' do
      user = build(:user)
      expect(user.to_s).to eq "User(id: #{user.id}, email: #{user.email}, name: #{user.name})"
    end
  end
end
