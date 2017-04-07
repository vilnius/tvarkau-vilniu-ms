# -*- coding: binary -*-

# very simplified version of https://github.com/minad/mimemagic
# based on v0.2.1
#
# only for image type detection
class MimeMagic
  MAGIC = [
    ['image/jpeg', [[0, "\377\330\377"], [0, "\377\330"]]],
    ['image/png', [[0, "\211PNG"]]],
  ].freeze

  attr_reader :type, :mediatype, :subtype

  def initialize(type)
    @type = type
    @mediatype, @subtype = type.split('/', 2)
  end

  def image?
    mediatype == 'image'
  end

  def self.by_magic(io)
    mime =
      if io.respond_to?(:seek) && io.respond_to?(:read)
        io.binmode
        io.set_encoding(Encoding::BINARY) if io.respond_to?(:set_encoding)
        MAGIC.find { |_, matches| magic_match_io(io, matches) }
      else
        str = io.respond_to?(:read) ? io.read : io.to_s
        str = str.force_encoding(Encoding::BINARY) if str.respond_to? :force_encoding
        MAGIC.find { |_, matches| magic_match_str(str, matches) }
      end
    mime && new(mime[0])
  end

  def to_s
    type
  end

  def self.magic_match_io(io, matches)
    matches.any? do |offset, value, children|
      match =
        if Range === offset
          io.seek(offset.begin)
          x = io.read(offset.end - offset.begin + value.bytesize)
          x && x.include?(value)
        else
          io.seek(offset)
          io.read(value.bytesize) == value
        end
      match && (!children || magic_match_io(io, children))
    end
  end

  def self.magic_match_str(str, matches)
    matches.any? do |offset, value, children|
      match =
        if Range === offset
          x = str[offset.begin, offset.end - offset.begin + value.bytesize]
          x && x.include?(value)
        else
          str[offset, value.bytesize] == value
        end
      match && (!children || magic_match_str(str, children))
    end
  end

  private_class_method :magic_match_io, :magic_match_str
end
