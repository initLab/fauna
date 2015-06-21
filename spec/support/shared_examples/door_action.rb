shared_examples 'door action' do
  it_behaves_like 'loggable'

  describe 'execution_succeeded' do
    it 'is true when the execution of the action succeeded' do
      allow(backend).to receive(:open!).and_return(true)
      expect{ subject.save }.to change(subject, :execution_succeeded).from(nil).to(true)
    end

    it 'is false when the execution of the action did not succeed' do
      allow(backend).to receive(:open!).and_return(false)
      expect{ subject.save }.to change(subject, :execution_succeeded).from(nil).to(false)
    end

    it 'is nil when the action has not been executed' do
      expect(subject.execution_succeeded).to be nil
    end
  end
end
