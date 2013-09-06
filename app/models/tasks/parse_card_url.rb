class Tasks::ParseCardUrl


  def self.get_id(url)
    url.split('/')[4]
  end

end

