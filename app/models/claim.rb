class Claim < ActiveRecord::Base
  has_one :submission
  has_many :services

  enum status: {
    unprocessed: 0,
    pending: 1,
    paid: 2,
    rejected: 3
  }

end
