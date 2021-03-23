class UrlParser
  SHORTHAND_LIMIT = 5
  def self.is_valid_url?(potential_url)
    valid = potential_url && potential_url.match(/\A#{URI::regexp}\z/)
    !!valid
  end

  def self.create_shorthand
    SecureRandom.alphanumeric[0...SHORTHAND_LIMIT]
  end
end
