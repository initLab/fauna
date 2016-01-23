require 'rails_helper'

describe LightsManager do
  describe '::forced_on?' do
    include FakeFS::SpecHelpers

    before do
      Dir.mkdir File.join('', 'tmp')
    end

    context 'when the force on trigger file is present' do
      it 'is true' do
        File.open(LightsManager::TRIGGER, 'w') { |file| file.write '{P}~~~ kroci' }
        expect(LightsManager.forced_on?).to be_truthy
      end
    end

    context 'when the force on trigger file is not present' do
      it 'is false' do
        expect(LightsManager.forced_on?).to be_falsy
      end
    end
  end

  describe '::toggle_force_on' do
    include FakeFS::SpecHelpers

    before do
      Dir.mkdir File.join('', 'tmp')
    end

    context 'when the force on trigger file is present' do
      it 'deletes it' do
        File.open(LightsManager::TRIGGER, 'w') { |file| file.write '{P}~~~ kroci' }
        expect(File.exist? LightsManager::TRIGGER).to be_truthy

        LightsManager.toggle_force_on

        expect(File.exist? LightsManager::TRIGGER).to be_falsy
      end
    end

    context 'when the force on trigger file is not present' do
      it 'creates it' do
        expect(File.exist? LightsManager::TRIGGER).to be_falsy

        LightsManager.toggle_force_on

        expect(File.exist? LightsManager::TRIGGER).to be_truthy
      end
    end
  end

  describe '::status' do
    it 'is :on when the SNMP response is 1' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(LightsManager::STATUS_OID).and_return(SNMP::Integer.new(1))
      allow(SNMP::Manager).to receive(:open).with(host: LightsManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(LightsManager.status).to eq :on
    end

    it 'is :off when the SNMP response is 0' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(LightsManager::STATUS_OID).and_return(SNMP::Integer.new(0))
      allow(SNMP::Manager).to receive(:open).with(host: LightsManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(LightsManager.status).to eq :off
    end

    it 'is :unknown when the SNMP response is not 1 or 0' do
      snmp_manager = instance_double('SNMP::Manager')
      allow(snmp_manager).to receive(:get_value).with(LightsManager::STATUS_OID).and_return(nil)
      allow(SNMP::Manager).to receive(:open).with(host: LightsManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

      expect(LightsManager.status).to eq :unknown
    end

    context 'when an exception arises while querying the controller' do
      before do
        snmp_manager = instance_double('SNMP::Manager')
        allow(snmp_manager).to receive(:get_value).with(LightsManager::STATUS_OID).and_raise(SNMP::RequestTimeout)
        allow(SNMP::Manager).to receive(:open).with(host: LightsManager::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)
      end

      it 'is :unknown' do
        expect(LightsManager.status).to eq :unknown
      end

      it 'logs a warning' do
        expect(Rails.logger).to receive(:warn).with("Error retreiving lights status: SNMP::RequestTimeout")
        LightsManager.status
      end
    end
  end
end
