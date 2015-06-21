require 'rails_helper'

describe Door::StatusManager::InitLab do
  describe '#status' do
    it 'calls the Pesho#status method' do
      expect_any_instance_of(Door::StatusManager::Pesho).to receive(:status)
      subject.status
    end
  end

  describe '#unlock!' do
    it 'calls the Pesho#unlock! method' do
      expect_any_instance_of(Door::StatusManager::Pesho).to receive(:unlock!)
      subject.unlock!
    end
  end

  describe '#lock!' do
    it 'calls the Pesho#lock! method' do
      expect_any_instance_of(Door::StatusManager::Pesho).to receive(:lock!)
      subject.lock!
    end
  end

  describe '#open!' do
    it 'calls the Buzzer#open! method' do
      expect_any_instance_of(Door::StatusManager::Buzzer).to receive(:open!)
      subject.open!
    end
  end
end
