class User < ActiveRecord::Base
  before_create :ensure_has_api_key

  private
    def ensure_has_api_key
      unless self.api_key.present?
        self.api_key = generate_api_key
      end
    end

    def generate_api_key
      loop do
        key = SecureRandom.hex(16)
        break key unless User.exists?(api_key: key) 
      end
    end
end
