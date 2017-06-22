# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Auth Server API' do

  path '/authenticate.json' do

    post 'Authenticates returning JWT' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :email, in: :path, type: :string
      parameter name: :password, in: :path, type: :string

      response '200', 'jwt found' do
        let(:email) { 'email@domain.com' }
        let(:password) { 'password' }

        run_test!
      end

      response '401', 'invalid request' do
        let(:email) { 'email@domain.com' }
        let(:password) { 'password' }

        run_test!
      end
    end
  end
end