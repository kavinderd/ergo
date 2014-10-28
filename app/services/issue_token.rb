class IssueToken

  def to_user(user)
    return user.token if user.token  
    token = generate_token
    ApiKey.create!(user: user, token: token).token
  end

  private

  def existing_token
    user.token
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

end
