class AuthenticationController < ApplicationController

	def ft_auth
    redirect_to "https://api.intra.42.fr/oauth/authorize?client_id=#{ENV['API_42_UID']}&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauthentication42api%2Fcallback&response_type=code", allow_other_host: true
  end

	def authenticate
		return redirect_to action: "ft_auth" if params.key?(:error)
    client = OAuth2::Client.new(ENV['API_42_UID'], ENV['API_42_SECRET'], site: "https://api.intra.42.fr")
    token = client.client_credentials.get_token
    begin
      token.post('/oauth/token', {body: {
        grant_type: "authorization_code",
        client_id: ENV['API_42_UID'],
        client_secret: ENV['API_42_SECRET'],
        code: params[:code],
        redirect_uri: "http://localhost:3000/authentication42api/callback"
      }})
    rescue
      redirect_to action: "ft_auth"
    end
	end

	def authentication_callback
    client = OAuth2::Client.new(ENV['API_42_UID'], ENV['API_42_SECRET'], site: "https://api.intra.42.fr")
    client.auth_code.authorize_url(:redirect_uri => "http://localhost:3000/authentication42api/callback")
    token = client.auth_code.get_token(params[:code], :redirect_uri => "http://localhost:3000/authentication42api/callback")
    begin
      response = token.get("/v2/me")
      puts "Response: (should be 200): #{response.status.to_s}"
      @user = User.find_or_create_by(login: response.parsed["login"]) do |user|
        user.email = response.parsed["email"]
        user.campus = Campus.find_by_name(response.parsed["campus"].first["name"])
      end
      if @user.persisted?
        sign_in @user, event: :authentication
      else
        session["devise.access_code"] = params[:code]
        return redirect_to new_user_session_path
      end
    rescue
      puts "something went wrong with API connection... :("
    end
		redirect_to root_path
	end
end
