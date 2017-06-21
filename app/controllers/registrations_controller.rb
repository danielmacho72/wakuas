class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
	
  def new
	super
  end

  def create
	clear_respond_to if request.format == 'json' 
  end
end