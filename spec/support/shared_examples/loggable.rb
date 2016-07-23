shared_examples 'loggable' do
  it 'creates an associated log entry when created' do
    model = create subject.model_name.singular.to_sym
    expect(model.log_entry).to be_a LogEntry
    expect(model.log_entry.loggable).to eq model
  end
end
