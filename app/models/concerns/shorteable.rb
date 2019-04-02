module Shorteable
  extend ActiveSupport::Concern

  def create_short_id!
    if self.respond_to?("short_id") && self.id.is_a?(Integer)
      self.short_id = short_encode(self.id)
      return self.save
    end
    logger.fatal "The model `#{self.class}` does not respond to the field `short_id`"
    false
  end

  private

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