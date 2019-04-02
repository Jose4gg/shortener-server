module Shorteable

  class Error < StandardError
  end

  extend ActiveSupport::Concern

  def short_id
    id_field = self.class.short_field?
    if self.respond_to?(id_field) && self.send(id_field).is_a?(Integer)
      return self.class.short_encode(self.send(id_field))
    end
    raise Shorteable::Error.new "This object does not have a valid 'short_field'"
  end

  class_methods do
    def find_by_short_id(id)
      self.find_by(self.short_field? => self.short_decode(id))
    end

    def short_field?
      "id"
    end

    def short_alphabet
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
    end
  
    def short_encode(i)
      return short_alphabet[0] if i == 0
      s = ''
      base = short_alphabet.length
      while i > 0
        s << short_alphabet[i.modulo(base)]
        i /= base
      end
      s.reverse
    end
    
    def short_decode(s)
      i = 0
      base = short_alphabet.length
      s.each_char { |c| i = i * base + short_alphabet.index(c) }
      i
    end
  end

end