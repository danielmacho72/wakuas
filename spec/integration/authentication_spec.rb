require 'swagger_helper'

describe 'Authenticate' do
  let! (:user) { FactoryGirl.create(:user) }
  let(:claims_id) { JWT.decode(response_body['auth_token'], Rails.application.secrets.secret_key_base).first["user_id"] }
  let(:valid_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'password') }" } }
  let(:invalid_password_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'wrong_password') }" } }
  let(:invalid_user_headers) { { "HTTP_AUTHORIZATION": "#{ActionController::HttpAuthentication::Basic.encode_credentials("wrong_user", 'wrong_password') }" } }
  let(:empty_basic_headers) { { "HTTP_AUTHORIZATION": "" } }
  let(:valid_jwt) { { "HTTP_AUTHORIZATION": JsonWebToken.encode(user_id: user.id) } }
  let(:invalid_jwt) { { "HTTP_AUTHORIZATION": JsonWebToken.encode(user_id: 99999999) } }
  let(:valid_expired_jwt) { { "HTTP_AUTHORIZATION": JsonWebToken.encode( { user_id: user.id } , 1.hour.ago) } }
  let(:invalid_expired_jwt) { { "HTTP_AUTHORIZATION": JsonWebToken.encode( { user_id: 999999999 } , 1.hour.ago) } }


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

		context "with wrong password in headers" do
    	before do
      	post "/authenticate.json", headers: invalid_password_headers
    	end

    	it "returns invalid JWT token" do
    	  expect(response.status).to eq 401
    		  
    		jwt_token = response_body["auth_token"]
    		  
			  expect(jwt_token).to eq(nil)
    	end
		end

    context "with wrong user in headers" do
      before do
        post "/authenticate.json", headers: invalid_user_headers
      end

      it "returns invalid JWT token" do
        expect(response.status).to eq 401
          
        jwt_token = response_body["auth_token"]
          
        expect(jwt_token).to eq(nil)
      end
    end

    context "with empty basic auth headers" do
      before do
        post "/authenticate.json", headers: empty_basic_headers
      end

      it "returns invalid JWT token" do
        expect(response.status).to eq 401
        expect(response_body).to eq(nil)
      end
    end

    context "with no basic auth headers" do
      before do
        post "/authenticate.json"
      end

      it "returns invalid JWT token" do
        expect(response.status).to eq 401          
        expect(response_body).to eq(nil)
      end
    end
  end

  describe "Validate JWT" do
    context "with valid JWT" do 
      before do
        get "/validate.json", headers: valid_jwt
      end

      it "properly validates JWT token" do
        expect(response.status).to eq 200
        expect(assigns(:current_user)).to eq(user)

        token_is_valid = response_body["token_is_valid"]  
        expect(token_is_valid).to eq(true)
      end
    end

    context "with invalid JWT" do
      before do
        get "/validate.json", headers: invalid_jwt
      end

      it "properly rejects JWT token" do
        expect(response.status).to eq 401
        expect(assigns(:current_user)).to eq(nil)
      end
    end

    context "with valid but expired JWT" do
      before do
        get "/validate.json", headers: valid_expired_jwt
      end

      it "properly rejects JWT token" do
        expect(response.status).to eq 401
        expect(assigns(:current_user)).to eq(nil)
      end 
    end

    context "with invalid and expired JWT" do
      before do
        get "/validate.json", headers: invalid_expired_jwt
      end

      it "properly rejects JWT token" do
        expect(response.status).to eq 401
        expect(assigns(:current_user)).to eq(nil)
      end 
    end
  end

  def response_body
    JSON.parse(response.body) rescue nil
  end
end
