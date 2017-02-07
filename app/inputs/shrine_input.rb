# frozen_string_literal: true
class ShrineInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options)
    template.content_tag(:div, class: 'form-group') do
      if input_html_options[:url].present?
        template.concat file_input_download(input_html_options.extract!(:url))
      else
        template.concat @builder.hidden_field(attribute_name, value: object.send("cached_#{attribute_name}_data"))
        template.concat @builder.file_field(attribute_name, input_html_options)
      end
    end
  end

  def file_input_download(options = {})
    url = options[:url]
    template.content_tag(:div, class: 'input-group') do
      template.concat @builder.hidden_field(attribute_name, value: object.send("cached_#{attribute_name}_data"))
      template.concat @builder.file_field(attribute_name, input_html_options)
      template.concat span_download(url)
    end
  end

  def span_download(url)
    template.content_tag(:a, class: 'input-group-addon', target: '_blank', href: url) do
      template.concat icon_download
    end
  end

  def icon_download
    template.content_tag(:span) do
      template.concat "<i class='glyphicon glyphicon-download-alt'></i>".html_safe
    end
  end
end
