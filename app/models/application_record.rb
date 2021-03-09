class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum date: { "10/23(土)": 0, "10/24(日)": 1, "10/23(土),10/24(日)":2 }
end
