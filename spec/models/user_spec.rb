# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  it 'checks if the name is present' do
    build(:user, name: nil).should have(1).error_on :name
  end

  describe '#destroy' do
    let(:user) { create :user }

    before do
      create :phone, owner: user
      create :computer, owner: user
    end

    it 'destroys dependent Computers' do
      computer = user.computers.first
      user.destroy
      expect { Computer.find computer.id }.to raise_error ActiveRecord::RecordNotFound
    end

    it 'destroys dependent Phones' do
      phone = user.phones.first
      user.destroy
      expect { Phone.find phone.id }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe 'url' do
    let(:valid_urls) { %w(http://foo.bar https://foo.bar)}
    let(:invalid_urls) { %w(javascript:alert(foo.bar) mailto:)}

    it 'can be nil' do
      build(:user, url: nil).should have(:no).errors_on :url
      build(:user, url: '').should have(:no).errors_on :url
    end

    it 'can be an HTTP URL' do
      build(:user, url: 'http://example.com').should have(:no).errors_on :url
    end

    it 'can be an HTTPS URL' do
      build(:user, url: 'https://example.com').should have(:no).errors_on :url
    end

    it 'cannot be anything but an HTTP(S) URL' do
      build(:user, url: 'javascript:alert(foo)').should have(1).errors_on :url
      build(:user, url: 'example.com').should have(1).errors_on :url
      build(:user, url: 'foobar').should have(1).errors_on :url
    end
  end

  describe 'twitter handle' do
    let(:valid_handles) { %w(f F 1 _ foo fOO FOO f_oo f00) }
    let(:invalid_handles) { %w(- абв abcdefghijklmnopqrst) }

    it 'is stored without a starting @' do
      build(:user, twitter: '@foobar').twitter.should eq 'foobar'
    end

    it 'can be nil' do
      build(:user, twitter: nil).should have(:no).errors_on :twitter
    end

    it 'can be a valid handle' do
      valid_handles.each do |handle|
        build(:user, twitter: handle).should have(:no).errors_on :twitter
      end
    end

    it 'cannot be an invalid handle' do
      invalid_handles.each do |handle|
        build(:user, twitter: handle).should have(1).errors_on :twitter
      end
    end
  end
end
