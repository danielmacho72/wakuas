module ControllerMacros
  def login(user = nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]

    if(user.is_a?(User) && !user.is_admin)
      @current_user = (user ? user : Factory(:user))
      #@current_organization = @current_user.try(:organizations).try(:first)
    elsif(user.is_a?(User) && user.is_admin)
      @current_user = (user ? user : Factory(:admin))
    end

    sign_in @current_user
  end
end