class EncryptPassword
  def self.encrypt
    @user = User.all
    @user.each do | user |
      user.password = Digest::MD5.hexdigest(user.password)
      user.confirm_password = Digest::MD5.hexdigest(user.confirm_password)
      user.save
    end
  end
end
