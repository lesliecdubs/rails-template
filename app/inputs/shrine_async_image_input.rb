# frozen_string_literal: true
class ShrineAsyncImageInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options)
    input_html_options[:class].push('js-async-image')

    template.content_tag(:div, class: 'input-group') do
      template.concat span_refresh
      template.concat @builder.hidden_field(attribute_name, value: object.cached_image_data)
      template.concat @builder.file_field('async_image', input_html_options)
    end
  end

  def span_refresh
    template.content_tag(:span, class: 'input-group-addon loading ') do
      template.concat icon_refresh
    end
  end

  def icon_refresh
    "<i class='glyphicon glyphicon-refresh'></i>".html_safe
  end
end
