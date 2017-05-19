vowels = {}

("a".."z").each.with_index(1) do |char, index|
  vowels[char] = index if char =~ /[aeiouy]/
end