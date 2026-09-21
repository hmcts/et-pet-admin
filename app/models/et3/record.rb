module Et3
  class Record < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: { writing: :et3 }
  end
end