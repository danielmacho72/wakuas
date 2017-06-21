class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  clear_respond_to if request.format == 'json'
end