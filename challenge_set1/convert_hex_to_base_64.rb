require 'pry'

# https://en.wikipedia.org/wiki/Hexadecimal
HEX_TO_BASE_10 = {
  "A" => 10, "B" => 11, "C" => 12, "D" => 13, "E" => 14, "F" => 15
}

# https://en.wikipedia.org/wiki/Base64
BASE_10_TO_64 = {
  0 => 'A', 16 => 'Q', 32 => 'g', 48 => 'w',
  1 => 'B', 17 => 'R', 33 => 'h', 49 => 'x',
  2 => 'C', 18 => 'S', 34 => 'i', 50 => 'y',
  3 => 'D', 19 => 'T', 35 => 'j', 51 => 'z',
  4 => 'E', 20 => 'U', 36 => 'k', 52 => '0',
  5 => 'F', 21 => 'V', 37 => 'l', 53 => '1',
  6 => 'G', 22 => 'W', 38 => 'm', 54 => '2',
  7 => 'H', 23 => 'X', 39 => 'n', 55 => '3',
  8 => 'I', 24 => 'Y', 40 => 'o', 56 => '4',
  9 => 'J', 25 => 'Z', 41 => 'p', 57 => '5',
  10 => 'K', 26 => 'a', 42 => 'q', 58 => '6',
  11 => 'L', 27 => 'b', 43 => 'r', 59 => '7',
  12 => 'M', 28 => 'c', 44 => 's', 60 => '8',
  13 => 'N', 29 => 'd', 45 => 't', 61 => '9',
  14 => 'O', 30 => 'e', 46 => 'u', 62 => "+",
  15 => 'P', 31 => 'f', 47 => 'v', 63 => '/'
}

def convert_base_16_to_base_10(num)
  if HEX_TO_BASE_10.include? num.upcase
    return HEX_TO_BASE_10[num.upcase]
  else
    return num.to_i
  end
end

def convert_base_16_string_to_int(string_that_is_actually_a_number_in_base_16)
  digit_array = string_that_is_actually_a_number_in_base_16.split("").map { |n| convert_base_16_to_base_10(n) }
  digit_array.reverse.each.with_index.inject(0) { |total, (digit, decimal_place)| total += (digit * 16**decimal_place ) }
end

def convert_int_to_base_64_string(input_int)
  digits = Math.log(input_int, 64).ceil
  result = ""
  for decimal_place in 1..digits
    m = 64**decimal_place
    piece = input_int % m
    digit = piece / 64**(decimal_place - 1)
    result = BASE_10_TO_64[digit] + result
    input_int -= digit * 64**(decimal_place - 1)
  end
  return result
end

def solve_problem_1
  n = convert_base_16_string_to_int("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
  puts convert_int_to_base_64_string(n)
end

# solve_problem_1 # I'm killing your brain like a poisonous mushroom
