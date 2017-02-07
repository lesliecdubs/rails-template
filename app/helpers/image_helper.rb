# frozen_string_literal: true
module ImageHelper
  def image_set_tag(sizes = ['350x198', '530x300', '1024x580', '1280x725', '1600x906'], image = 1, options = {})
    srcset = build_srcset(sizes, image).join(', ')
    # source = "http://fillmurray.com/" + sizes.last.gsub('x', '/')
    # source = "https://source.unsplash.com/" + sizes.last.gsub('x', '/') + "/?nature"
    source = "https://unsplash.it/" + sizes.last.tr('x', '/') + '?image=' + image.to_s
    # image_tag(source, options.merge(srcset: srcset))
    image_tag(source, options.merge(srcset: srcset))
  end

  def local_image_tag(src, type, sizes = ['1024', '1400'], options = {})
    source = "#{src}.#{type}"
    srcset = sizes.map do |size|
      image_path("#{src}-#{size}.#{type}") + " #{size}w"
    end.join(', ')
    image_tag(source, options.merge(srcset: srcset))
  end

  private
  def build_srcset(sizes, image)
    sizes.map do |size|
      width, height = size.split('x')
      # "https://source.unsplash.com/#{width}x#{height}/?nature"
      "https://unsplash.it/#{width}x#{height}?image=#{image} #{width}w"
    end
  end

  # TODO: uncomment once images are local
  # def image_set_tag(obj, image_size = nil, options = {})
  #   srcset = build_srcset(obj).map { |src, size| "#{path_to_image(src)} #{size}" }.join(', ')
  #   image_size = "_#{image_size}" if image_size.present?
  #   source = "#{obj.image.remote_url}".gsub('.jpg', "#{image_size}.jpg")
  #   image_tag(source, options.merge(srcset: srcset))
  # end
  #
  # private
  # def build_srcset(obj)
  #   klass = obj.class
  #   klass::IMAGE_SIZES.map do |size, width|
  #     [obj.send("image_#{size}").remote_url, "#{width}w"]
  #   end.to_h
  # end

  def shrine_image_set_tag(image, options = {} )
    if image.is_a? Hash
      srcset  = build_shrine_srcset(image).join(', ')
      src_url = image[:mx].present? ? image[:mx].url : image[:original].url
      image_tag(src_url, srcset: srcset, **options)
    else
      image_tag(image.url, options) if image.present?
    end
  end

  def build_shrine_srcset(image)
    widths = { xl: 1280, lg: 1024, md: 768, sm: 530, xs: 350 }
    image.reject { |key| [:original, :mx].include?(key) }.map do |size, uploader|
      width = uploader.data['metadata']['width'] || widths[size]
      "#{uploader.url} #{width}w"
    end
  end
end
