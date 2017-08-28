class Api::ApplicationController < ActionController::Base

	TOKEN = "3c494b31d8cdbca39a966b1de972993e"

  before_action :cors_preflight_check
	#before_filter :check_token
  #skip_before_filter :verify_authenticity_token

  after_action :cors_set_access_control_headers

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
    check_token
  end

	def options
	  headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
	  headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
	  headers['Access-Control-Max-Age'] = '1000'
	  headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
	  head :ok
	end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, X-API-Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end

  end

	def check_token
		unless request.headers["X-API-Token"].eql?(TOKEN)
			respond_to do |format|
				format.json do
	        self.status = :unauthorized
	        self.response_body = { error: 'Access denied' }.to_json
	      end
	    end
		end
	end
end