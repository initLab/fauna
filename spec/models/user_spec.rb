# -*- coding: utf-8 -*-
require 'rails_helper'

describe User do
  it 'lets Devise handle email and password validations' do
    expect(build(:user)).to be_a Devise::Models::Validatable
  end

  it 'lets Devise handle email confirmations' do
    expect(build(:user)).to be_a Devise::Models::Confirmable
  end

  describe 'name' do
    it 'must be present' do
      expect(build(:user, name: nil)).to have_error_on :name
    end
  end

  describe '::find_for_database_authentication' do
    let(:user) { create :user }

    it 'returns the user whose email is passed' do
      expect(User.find_for_database_authentication login: user.email).not_to be_nil
    end

    it 'returns the user whose username is passed' do
      expect(User.find_for_database_authentication login: user.username).not_to be_nil
    end

    it 'returns nil when the passed login does not exist' do
      expect(User.find_for_database_authentication login: "randomuser").to be_nil
    end

    context 'when there are users with no username' do
      let(:legacy_users) { build_list :user, 5, username: nil }

      before do
        legacy_users.each { |user| user.save(validate: false) }
        create_list :user, 5
      end

      it 'returns the legacy user when passed her email' do
        expect(User.find_for_database_authentication login: legacy_users.first.email).not_to be_nil
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
    end

    it 'destroys dependent Computers' do
      network_device = user.network_devices.first
      user.destroy
      expect { NetworkDevice.find network_device.id }.to raise_error ActiveRecord::RecordNotFound
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

  describe '#email_md5' do
    it 'returns an md5 sum of the email' do
      user = build :user, email: 'foo@example.com'
      expect(user.email_md5).to eq 'b48def645758b95537d4424c84d1a9ff'
    end
  end
end
