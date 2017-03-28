class SessionsController < ApplicationController
  def create
    render text: request.env['omniauth.auth'].to_yamlgi
  end
end
