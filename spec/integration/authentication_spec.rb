require 'swagger_helper'

describe 'Authenticate' do
  let! (:user) { FactoryGirl.create(:user) }
  let(:claims_id) { JWT.decode(response_body['auth_token'], Rails.application.secrets.secret_key_base).first["user_id"] }
  let(:valid_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'password') }" } }
  let(:invalid_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'wrong_password') }" } }
  let(:valid_jwt) { JsonWebToken.encode(user_id: user.id) }
  let(:invalid_jwt) { JsonWebToken.encode(user_id: 99999999) }
  let(:valid_expired_jwt) { JsonWebToken.encode(user_id: user.id, 1.hour.ago) }
  let(:invalid_expired_jwt) { JsonWebToken.encode(user_id: 99999999, 1.hour.ago) }


	describe "Request new JWT" do
  	context "with valid params" do
    	before do
    		post "/authenticate.json", headers: valid_headers 			
    	end

    	it "returns valid JWT token" do
    		expect(response.status).to eq 200
    	
			 expect(claims_id).to eq(user.id)
    	end
		end

		context "with invalid params" do
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

  describe "Validate JWT" do
    context "with valid JWT" do 
      
    end

    context "with invalid JWT" do
    end
  end
end
