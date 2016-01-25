require_relative 'single_byte_xor_cipher'

def given_ciphertexts
  ciphertexts_dir = File.expand_path("../given_data/327_60-character_ciphertexts.txt", __FILE__)
  return File.read(ciphertexts_dir).split("\n")
end

def detect_single_character_xor(ciphertext, cutoff, english_plaintext_scorer)
  r = find_single_byte_xor_cipher_for_hex_ciphertext(ciphertext, english_plaintext_scorer)
  r[:has_single_character_xor] = r[:winning_score] >= cutoff
  return r
end

def filter_for_single_character_xor(array_of_ciphertexts, cutoff)
  results = []
  english_plaintext_scorer = EnglishPlaintextScorer.new
  array_of_ciphertexts.each_with_index do |ciphertext, row_number|
    x = detect_single_character_xor(ciphertext, cutoff, english_plaintext_scorer)
    x[:row_number] = row_number
    results << x if x[:has_single_character_xor]
  end
  return results
end

def solve_problem_4
  a = filter_for_single_character_xor(given_ciphertexts, 0.8)
  a.each do |data|
    data.each do |key, val|
      puts "#{key}: #{val}"
    end
    puts "\n"
  end
end

# solve_problem_4 # Now that the party is jumping
