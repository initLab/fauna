require 'rails_helper'
require 'socket'

describe Lights::StatusManager do
  describe '::notify_controller!' do
    it 'sends a ping to the controller socket' do
      socket = instance_double('Socket')
      expect(socket).to receive(:send).and_return 12
      expect(Socket).to receive(:open).with(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0).and_yield socket

      Lights::StatusManager.notify_controller!
    end
  end

  describe '::forced_on?' do
    include FakeFS::SpecHelpers

    before do
      Dir.mkdir File.join('', 'tmp')
    end

    context 'when the force on trigger file is present' do
      it 'is true' do
        File.open(Lights::StatusManager::TRIGGER, 'w') { |file| file.write '{P}~~~ kroci' }
        expect(Lights::StatusManager.forced_on?).to be_truthy
      end
    end

    context 'when the force on trigger file is not present' do
      it 'is false' do
        expect(Lights::StatusManager.forced_on?).to be_falsy
      end
    end
  end

  describe '::auto!' do
    include FakeFS::SpecHelpers

    before do
      Dir.mkdir File.join('', 'tmp')
      File.open(Lights::StatusManager::TRIGGER, 'w') { |file| file.write '{P}~~~ kroci' }
      allow(Lights::StatusManager).to receive(:notify_controller!).and_return true
    end

    it 'pings the controller that there is a state change' do
      expect(Lights::StatusManager).to receive(:notify_controller!).and_return true

      Lights::StatusManager.auto!
    end

    it 'deletes the trigger file' do
      expect(File.exist? Lights::StatusManager::TRIGGER).to be_truthy

      Lights::StatusManager.auto!

      expect(File.exist? Lights::StatusManager::TRIGGER).to be_falsy
    end

    it 'returns true' do
      expect(Lights::StatusManager.auto!).to be_truthy
    end
  end

  describe '::force_on!' do
    include FakeFS::SpecHelpers

    before do
      Dir.mkdir File.join('', 'tmp')
      allow(Lights::StatusManager).to receive(:notify_controller!).and_return true
    end

    it 'pings the controller that there is a state change' do
      expect(Lights::StatusManager).to receive(:notify_controller!).and_return true
      Lights::StatusManager.force_on!
    end

    it 'creates the trigger file' do
      expect(File.exist? Lights::StatusManager::TRIGGER).to be_falsy

      Lights::StatusManager.force_on!

      expect(File.exist? Lights::StatusManager::TRIGGER).to be_truthy
    end

    it 'returns true' do
      expect(Lights::StatusManager.force_on!).to be_truthy
    end
  end

  describe '::status' do
    it 'is :on when the SNMP response is 1' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(Lights::StatusManager::STATUS_OID).and_return(SNMP::Integer.new(1))
      allow(SNMP::Manager).to receive(:open).with(host: Lights::StatusManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(Lights::StatusManager.status).to eq :on
    end

    it 'is :off when the SNMP response is 0' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(Lights::StatusManager::STATUS_OID).and_return(SNMP::Integer.new(0))
      allow(SNMP::Manager).to receive(:open).with(host: Lights::StatusManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(Lights::StatusManager.status).to eq :off
    end

    it 'is :unknown when the SNMP response is not 1 or 0' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(Lights::StatusManager::STATUS_OID).and_return(nil)
      allow(SNMP::Manager).to receive(:open).with(host: Lights::StatusManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(Lights::StatusManager.status).to eq :unknown
    end

    context 'when an exception arises while querying the controller' do
      before do
        snmp_manager = instance_double('SNMP::Manager')
        allow(snmp_manager).to receive(:get_value).with(Lights::StatusManager::STATUS_OID).and_raise(SNMP::RequestTimeout)
        allow(SNMP::Manager).to receive(:open).with(host: Lights::StatusManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)
      end

      it 'is :unknown' do
        expect(Lights::StatusManager.status).to eq :unknown
      end

      it 'logs a warning' do
        expect(Rails.logger).to receive(:warn).with("Error retreiving lights status: SNMP::RequestTimeout")
        Lights::StatusManager.status
      end
    end
  end
end
