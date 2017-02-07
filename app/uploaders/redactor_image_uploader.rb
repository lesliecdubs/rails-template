# frozen_string_literal: true
class RedactorImageUploader < Shrine
  plugin :processing

  process(:store) do |io, _context|
    image = MiniMagick::Image.new(io.download.path, io.download)

    image.strip
    image.interlace('Plane')
    image.quality('85%')
    image.format('png')

    tempfile = image.instance_variable_get("@tempfile")
    tempfile.open if tempfile.is_a?(Tempfile) #for aws
    tempfile

    #TODO convert to sourceset
  end
end
