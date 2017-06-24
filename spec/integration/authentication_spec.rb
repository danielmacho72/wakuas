require 'swagger_helper'


describe 'Autheticate' do
  	let! (:user) { FactoryGirl.create(:user) }
  	let(:claims_id) { JWT.decode(response_body['auth_token'], Rails.application.secrets.secret_key_base).first["user_id"] }
  	let(:valid_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'password') }" } }
  	let(:invalid_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'wrong_password') }" } }
	
	describe "POST" do
  		context "with valid params" do
    		before do
    			post "/authenticate.json", headers: valid_headers 			
    		end

    		it "returns valid JWT token" do
    		  expect(response.status).to eq 200
    	
			  expect(claims_id).to eq(user.id)
    		end
		end

		describe "with invalid params" do
    		before do
      			post "/authenticate.json", headers: invalid_headers
    		end

    		it "returns invalid JWT token" do
    		  expect(response.status).to eq 401
    		  
    		  jwt_token = response_body["auth_token"]
    		  
			  expect(jwt_token).to eq(nil)
    		end
		end

		def response_body
    		JSON.parse(response.body)
  		end
  	end
end
