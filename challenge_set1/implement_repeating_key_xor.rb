require_relative 'detect_single_character_xor'

PLAINTEXT_MESSAGE = <<-PLAINTEXT
Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal
PLAINTEXT

CORRECT_ANSWER = <<-CIPHER_HEX
0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f
CIPHER_HEX

def map_hex_to_array_of_binary(hex_string)
  hex_array = hex_string.chars.each_slice(2).map(&:join)
  return hex_array.map { |h| h.to_i(16).to_s(2) }
end

def map_plaintext_string_to_array_of_binary(plaintext_string)
  plain_hex = plaintext_string.unpack("H*").first
  return map_hex_to_array_of_binary(plain_hex)
end

def map_binary_array_to_hex_array(binary_array)
  binary_array.map do |byte_string|
    hex_string = byte_string.to_i(2).to_s(16)
    hex_string = "0" + hex_string if hex_string.length == 1
    next hex_string
  end
end

def encrypt_with_repeating_key_xor(plaintext, repeating_key)
  plain_binary_array = map_plaintext_string_to_array_of_binary(plaintext)
  repeating_keys = map_plaintext_string_to_array_of_binary(repeating_key)
  number_of_repeating_keys = repeating_keys.count
  cipher_binary = []
  plain_binary_array.each_with_index do |plain_binary, i|
    binary_key_location = i % number_of_repeating_keys
    binary_key = repeating_keys[binary_key_location]
    # binding.pry if i > 40
    cipher_binary << xor_binary_strings(plain_binary, binary_key)
  end
  return map_binary_array_to_hex_array(cipher_binary).join("")
end

def solve_problem_5
  my_answer = encrypt_with_repeating_key_xor(PLAINTEXT_MESSAGE.chomp, "ICE")
  correct_answer = CORRECT_ANSWER.chomp
  puts my_answer.to_i(16) == correct_answer.to_i(16)
  unless my_answer.to_i(16) == correct_answer.to_i(16)
    my_hex_array = my_answer.chars.each_slice(2).map(&:join)
    correct_hex_array = correct_answer.chars.each_slice(2).map(&:join)
    binding.pry
    for n in 0..([my_hex_array.count, correct_hex_array.count].max)
      my_hex_character = my_hex_array[n]
      correct_hex_character = correct_hex_array[n]
      unless my_hex_character == correct_hex_character
        puts "#{n}: #{my_hex_character} != #{correct_hex_character}"
      end
    end
  end
end

# solve_problem_5
