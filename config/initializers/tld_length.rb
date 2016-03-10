module Loomio
  if ENV['CANONICAL_HOST']
    TLD_LENGTH = ENV['CANONICAL_HOST'].count('.')
  else
    TLD_LENGTH = 0
  end
end
