module Trello
  class List < BasicData
    def finished?
      self.name == "Staged" || self.name == "Live"
    end
  end
end
