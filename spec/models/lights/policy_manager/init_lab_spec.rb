require 'rails_helper'

describe Lights::PolicyManager::InitLab do
  describe '#policy=' do
    context 'when a valid policy is passed' do
      it 'applies the given policy' do
        expect { subject.policy = :always_on }.to change(subject, :policy).from(:auto).to(:always_on)
        expect { subject.policy = :auto }.to change(subject, :policy).from(:always_on).to(:auto)
      end

      it 'notifies the controller' do
        socket = instance_double('Socket')
        expect(socket).to receive(:send).and_return 12
        expect(Socket).to receive(:open).with(Socket::AF_UNIX, Socket::SOCK_DGRAM, 0).and_yield socket

        subject.policy = :always_on
      end

      after :each do
        if File.exist? Lights::PolicyManager::InitLab::TRIGGER
          File.delete Lights::PolicyManager::InitLab::TRIGGER
        end
      end
    end

    context 'when an invalid policy is passed' do
      it 'raises an ArgumentError' do
        expect { subject.policy = :foobar }.to raise_error ArgumentError
      end
    end
  end

  describe '#lights_status' do
    context 'when the lights are on' do
      it 'returns :on' do
        snmp_manager = instance_double('SNMP::Manager')
        allow(snmp_manager).to receive(:get_value).with(Lights::PolicyManager::InitLab::STATUS_OID).and_return(SNMP::Integer.new(1))
        allow(SNMP::Manager).to receive(:open).with(host: Lights::PolicyManager::InitLab::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

        expect(subject.status).to eq :on
      end
    end

    context 'when the lights are off' do
      it 'returns :off' do
        snmp_manager = instance_double('SNMP::Manager')
        allow(snmp_manager).to receive(:get_value).with(Lights::PolicyManager::InitLab::STATUS_OID).and_return(SNMP::Integer.new(0))
        allow(SNMP::Manager).to receive(:open).with(host: Lights::PolicyManager::InitLab::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)

        expect(subject.status).to eq :off
      end
    end

    context 'when an exception arises while querying the controller' do
      before do
        snmp_manager = instance_double('SNMP::Manager')
        allow(snmp_manager).to receive(:get_value).with(Lights::PolicyManager::InitLab::STATUS_OID).and_raise(SNMP::RequestTimeout)
        allow(SNMP::Manager).to receive(:open).with(host: Lights::PolicyManager::InitLab::LIGHTS_CONTROLLER_IP).and_yield(snmp_manager)
      end

      it 'raises Lights::PolicyManager::Error' do
        expect { subject.status }.to raise_error Lights::PolicyManager::Error
      end
    end
  end

  describe '#policy' do

    # TODO: Fix the use of fakefs
    # before do
    #   Dir.mkdir File.join('', 'tmp')
    # end

    context 'when the current policy is auto' do
      it 'returns :auto' do
        expect(subject.policy).to eq :auto
      end
    end

    context 'when the current policy is always on' do
      before :each do
        File.open(Lights::PolicyManager::InitLab::TRIGGER, 'w') do |file|
          file.write '{P}~~~ kroci'
        end
      end

      it 'returns :always_on' do
        expect(subject.policy).to eq :always_on
      end

      after :each do
        File.delete Lights::PolicyManager::InitLab::TRIGGER
      end
    end
  end
end
