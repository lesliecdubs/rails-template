# frozen_string_literal: true
module Admin::ApplicationHelper
  def flash_class(level)
    case level
      when 'success' then 'alert alert-success'
      when 'notice'  then 'alert alert-info'
      when 'alert'   then 'alert alert-danger'
      when 'error'   then 'alert alert-danger'
    end
  end

  def obj_name(obj)
    obj.class.name.underscore
  end

  def edit_link(obj, path = nil)
    path = path.nil? ? send("edit_admin_#{obj_name(obj)}_path",
      obj.id) : build_path(obj, path, 'edit_')

    link_to 'Edit', path, class: 'btn btn-sm btn-primary', title: 'Edit'
  end

  def delete_link(obj, path = nil)
    name = obj_name(obj).titleize
    path = path.nil? ? send("admin_#{obj_name(obj)}_path",
      obj.id) : build_path(obj, path)

    link_to 'Delete', path, method: :delete,
      data: { confirm: "Are you sure you want to delete this #{name.downcase}?" },
      class: 'btn btn-sm btn-danger', title: 'Delete'
  end

  def publish_unpublish_link(obj, path = nil)
    if obj.status?
      path = path.nil? ? send("unpublish_admin_#{obj_name(obj)}_path", obj.id) : build_path(obj, path, 'unpublish_')
      link_to 'Unpublish', path, class: 'btn btn-sm btn-danger', title: 'Unpublish'
    else
      path = path.nil? ? send("publish_admin_#{obj_name(obj)}_path", obj.id) : build_path(obj, path, 'publish_')
      link_to 'Publish', path, class: 'btn btn-sm btn-info', title: 'Publish'
    end
  end

  def build_path(obj, path, prefix = "")
    send("#{prefix}#{path}", obj.id)
  end

  def true_false_icon(state, _color='primary')
    label, icon = state ?
      ["label-primary", 'glyphicon-ok'] : ['label-default', 'glyphicon-remove']

    content_tag(:span, class: "label #{label}") do
      content_tag(:i, '', class: "glyphicon #{icon}")
    end
  end

  def list_errors(errors = [])
    content_tag(:ol) do
      errors.each do |error|
        concat content_tag(:li, error)
      end
    end
  end

  def preview_image(url)
    if url.present?
      image_tag(url, style: 'width: 75%;')
    else
      content_tag(:p) do
        concat content_tag(:small, 'No image uploaded')
      end
    end
  end
end
