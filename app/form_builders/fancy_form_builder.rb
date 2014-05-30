class FancyFormBuilder < ActionView::Helpers::FormBuilder
  (field_helpers - [:label, :check_box, :radio_button, :fields_for, :hidden_field]).each do |selector|
    define_method(selector) do |name, *args|
      options = args.extract_options!
      options[:placeholder] ||= @object.class.human_attribute_name(name)
      options[:class] = [options[:class], 'form-control'].join(' ')
      if @object.errors[name]
        options[:data] ||= {}
        options[:data][:error] = @object.errors[name].to_json
      end
      args << options
      super(name, *args)
    end
  end

  def check_box(name, *args)
    options = args.extract_options!
    options[:label] ||= @object.class.human_attribute_name(name)
    args << options
    label name, class: 'checkbox' do
      "#{super(name, *args)} #{options[:label]}".html_safe
    end
  end
end
