require 'rails_helper'

describe Door::StatusManager::Dummy do
  describe '#status' do
    it 'returns {"door" => "closed", "latch" => "locked"}' do
      expect(subject.status).to eq({"door" => "closed", "latch" => "locked"})
    end
  end

  describe '#unlock!' do
    it 'returns true' do
      expect(subject.unlock!).to be true
    end
  end

  describe '#lock!' do
    it 'returns true' do
      expect(subject.lock!).to be true
    end
  end

  describe '#open!' do
    it 'returns true' do
      expect(subject.open!).to be true
    end
  end
end
