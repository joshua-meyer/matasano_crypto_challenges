require_relative 'fixed_xor'

def generate_all_possible_binary_numbers_of_a_given_length(num_of_digits)
  result = [""]
  num_of_digits.times do
    new_result = []
    result.each do |old_result|
      ["0", "1"].each do |option|
        new_result << old_result + option
      end
    end
    result = new_result
  end
  return result
end

def decode_binary_array(input_array, cipher)
  result = []
  input_array.each do |binary_letter|
    decoded_binary = xor_binary_strings(binary_letter, cipher)
    result << [decoded_binary.to_i(2).to_s(16)].pack("H*")
  end
  return result.join("")
end

class EnglishPlaintextScorer

  UNWANTED_CHARACTERS = [
    "\?", "\"", "\'", "\.", ",", "\!", "\$", "\@", "\#", "\%", "\^", "\&", "\*", "\(", "\)", "\-", "\_", "\=", "\+",
    "\{", "\}", "\[", "\]", "\;", "\:", "\<", "\>", "\/", "\\", "\~", "\`"
  ]

  def initialize
    dict = Hash.new
    File.read("/usr/share/dict/words").split("\n").each do |word|
      dict[word.upcase] = true
    end
    @english_dict = dict
  end

  def score_english_plaintext(plain_text)
    clean_text = UNWANTED_CHARACTERS.inject(plain_text) { |text, char| text.delete(char) }
    words = clean_text.split(" ")
    total = words.count.to_f
    score = 0
    words.each do |word|
      score += 1 if @english_dict[word.upcase]
    end
    return score.to_f / total
  end

end

def find_single_byte_xor_cipher_for_hex_ciphertext(given_hex_ciphertext, eps = EnglishPlaintextScorer.new)
  given_hex = given_hex_ciphertext.chars.each_slice(2).map(&:join)
  given_binary = given_hex.map { |h| h.to_i(16).to_s(2) }
  results = Hash.new
  generate_all_possible_binary_numbers_of_a_given_length(8).each do |possible_cipher|
    result_sentance = decode_binary_array(given_binary, possible_cipher)
    results[eps.score_english_plaintext(result_sentance)] = possible_cipher
  end

  winning_score = results.keys.max
  return {
    winning_score: winning_score,
    winning_cipher: results[winning_score],
    decoded_sentance: decode_binary_array(given_binary, results[winning_score])
  }
end

def solve_problem_3
  a = find_single_byte_xor_cipher_for_hex_ciphertext("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
  puts a[:decoded_sentance]
end

# solve_problem_3 # Cooking MC's like a pound of bacon
