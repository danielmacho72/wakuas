# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Auth Server API' do

  path '/authenticate.json' do

    post 'Authenticates returning JWT' do
      tags 'Auth'
      consumes 'application/json'

      response '200', 'jwt found' do
        #run_test!
      end

      response '401', 'invalid credentials' do
        run_test!
      end
    end
  end
end