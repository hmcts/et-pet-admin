module Et1
  class Record < ActiveRecord::Base
    self.abstract_class = true

    connects_to database: { writing: :et1 }
  end
end