require 'rails_helper'

describe Lights::PolicyManager::Dummy do
  describe '#status' do
    it 'returns :on' do
      expect(subject.status).to eq :on
    end
  end

  describe '#policy=' do
    context 'when a valid policy is passed' do
      it 'applies the given policy' do
        expect { subject.policy = :always_on }.to change(subject, :policy).from(:auto).to(:always_on)
        expect { subject.policy = :auto }.to change(subject, :policy).from(:always_on).to(:auto)
      end
    end

    context 'when an invalid policy is passed' do
      it 'raises an ArgumentError' do
        expect { subject.policy = :foobar }.to raise_error ArgumentError
      end
    end
  end

  describe '#policy' do
    context 'when the current policy is auto' do
      it 'returns :auto' do
        subject.policy = :auto
        expect(subject.policy).to eq :auto
      end
    end

    context 'when the current policy is always on' do
      it 'returns :always_on' do
        subject.policy = :always_on

        expect(subject.policy).to eq :always_on
      end
    end
  end
end
