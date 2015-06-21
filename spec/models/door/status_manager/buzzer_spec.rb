require 'rails_helper'

describe Door::StatusManager::Buzzer do
  describe '#status' do
    it 'raises a NotImplementedError' do
      expect { subject.status }.to raise_error NotImplementedError
    end
  end

  describe '#unlock!' do
    it 'raises a NotImplementedError' do
      expect { subject.status }.to raise_error NotImplementedError
    end
  end

  describe '#lock!' do
    it 'raises a NotImplementedError' do
      expect { subject.status }.to raise_error NotImplementedError
    end
  end

  describe '#open!' do
    it 'shells out to openr1' do
      expect(Kernel).to receive(:system).with('openr1')
      subject.open!
    end
  end
end
