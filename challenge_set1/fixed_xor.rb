require_relative 'convert_hex_to_base_64.rb'

def nieve_xor(i, j)
  if i == j
    return "0"
  else
    return "1"
  end
end

def xor_binary_strings(x, y)
  result = ""
  x = x.split("").reverse
  y = y.split("").reverse
  endpoint = [x.count, y.count].max
  for n in 1..endpoint
    k = n - 1
    result = nieve_xor(x[k] || "0", y[k] || "0") + result
  end
  return result
end

def solve_problem_2
  a = convert_base_16_string_to_int("1c0111001f010100061a024b53535009181c").to_s(2)
  b = convert_base_16_string_to_int("686974207468652062756c6c277320657965").to_s(2)
  c = xor_binary_strings(a, b)
  puts [c.to_i(2).to_s(16)].pack("H*")
end

# solve_problem_2 # the kid don't play
