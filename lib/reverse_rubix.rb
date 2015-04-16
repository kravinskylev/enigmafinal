require_relative 'final_key.rb'
require 'pry'

class Decrypt
  attr_reader :decrypted,
              :final_decrypted,
              :final_key

  CHARACTER_MAP = ("a".."z").to_a + ("0".."9").to_a + [" ", ".", ","]

  def initialize
    key = FinalKey.new
#    @final_key ||= key.combine_keys
    @decrypted = []
  end

  def slice_message(message)
    message.chars.each_slice(4).to_a
  end

  def new_index(letter, index)
    (CHARACTER_MAP.index(letter).to_i - @final_key[index].to_i) % 39
  end

  def decrypt(message, final_key)
    @final_key = final_key
    slice_message(message).each do |sub_array|
      sub_array.each_with_index do |letter, index|
        @decrypted << CHARACTER_MAP[new_index(letter, index)]
      end
    end
    @final_decrypted = @decrypted.join
  end
end

