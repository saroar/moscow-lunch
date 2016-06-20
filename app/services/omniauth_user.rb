class OmniauthUser
  attr_reader :auth, :organization

  def initialize(auth, organization)
    @auth = auth
    @organization = organization
  end

  def find_or_create
    if omniauth_user
      omniauth_user
    elsif registered_user
      registered_user
    else
      create_omniauth_user
    end
  end

  private

  def omniauth_user
    User.where(provider: auth.provider, uid: auth.uid).first
  end

  def registered_user
    User.where(email: auth.info.email).first
  end

  def create_omniauth_user
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
