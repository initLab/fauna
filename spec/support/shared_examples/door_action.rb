shared_examples 'door action' do
  let(:factory_name) { subject.model_name.singular.to_sym }

  it_behaves_like 'loggable'

  describe 'execution_succeeded' do
    it 'is true when the execution of the action succeeded' do
      allow(backend).to receive(subject.backend_method).and_return(true)
      expect{ subject.save }.to change(subject, :execution_succeeded).from(nil).to(true)
    end

    it 'is false when the execution of the action did not succeed' do
      allow(backend).to receive(subject.backend_method).and_return(false)
      expect{ subject.save }.to change(subject, :execution_succeeded).from(nil).to(false)
    end

    it 'is nil when the action has not been executed' do
      expect(subject.execution_succeeded).to be nil
    end
  end

  describe 'creation' do
    it "calls the appropriate method of the status manager after saving" do
      expect(backend).to receive(subject.backend_method)
      create factory_name
    end
  end
end
