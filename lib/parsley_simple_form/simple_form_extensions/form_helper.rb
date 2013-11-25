module ParsleySimpleForm
  module SimpleFormExtensions

    module FormHelper
      include SimpleForm::ActionViewExtensions::FormHelper

      def parsley_simple_for(resource, *args, &block)
        options = args.extract_options!
        simple_form_for(resource, *(args << options.merge(builder: ParsleySimpleForm::SimpleFormAdapt, html: {:"parsley-validate" => true})), &block)
      end
    end

  end
end