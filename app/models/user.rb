class User < ActiveRecord::Base
  validates_presence_of :group_id, :name, :email, :login_key, :key_expire_at
  validates_format_of  :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of  :login_key, with: /\A[A-Za-z0-9]{8}\Z/

  belongs_to :group
  def generate_login_key
    self.login_key=Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{Rails.application.secrets[:secret_key_base]}")[0..7]
    self.key_expire_at = Time.now+5.days
    save
  end
end
