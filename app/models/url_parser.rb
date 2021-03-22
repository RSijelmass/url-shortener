class UrlParser
  def is_valid_url?(potential_url)
    valid = potential_url.match(/\A#{URI::regexp}\z/)
    !!valid
  end

  def create_shorthand
    SecureRandom.alphanumeric
  end
end
