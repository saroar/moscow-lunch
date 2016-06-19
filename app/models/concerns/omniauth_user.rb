class OmniauthUser
  def self.find_or_create(auth, organization)
    if omniauth_user(auth, organization)
      omniauth_user(auth, organization)
    elsif registered_user(auth, organization)
      registered_user(auth, organization)
    else
      create_ominauth_user(auth, organization)
    end
  end

  private

  def self.omniauth_user(auth, organization)
    User.where(provider: auth.provider, uid: auth.uid).first
  end

  def self.registered_user(auth, organization)
    User.where(email: auth.info.email).first
  end

  def self.create_ominauth_user(auth, organization)
    User.create(
       provider: auth.provider,
       uid: auth.uid,
       name: auth.info.name,
       email: auth.info.email,
       password: Devise.friendly_token[0, 20],
       organization: organization
   )
  end
end
