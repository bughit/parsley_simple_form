module ParsleySimpleForm
  class SimpleFormAdapt < SimpleForm::FormBuilder

    def input(attribute_name, options = {}, &block)
      options[:input_html] ||= {}
      parsley_validations = validations_for(attribute_name)

      options[:input_html].merge!(parsley_validations)
      super
    end

    private

    def validations_for(attribute_name)
      object_class.validators_on(attribute_name).each_with_object({}) do |validate, attributes|
        next unless klass = validate_constantize(validate.kind)

        attributes.merge! klass.new(object, validate, attribute_name).attribute_validate
      end
    end

    def validate_constantize(validate_kind)
      ('parsley_simple_form/validators/' + validate_kind.to_s).camelize.constantize rescue false
    end

    def object_class
      object.class
    end
  end
end