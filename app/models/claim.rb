class Claim < ActiveRecord::Base
  has_one  :submission
  has_many :services
  accepts_nested_attributes_for :services, allow_destroy: true

  enum status: {
    created: 0,
    in_process: 1,
    processed: 2
  }

end
