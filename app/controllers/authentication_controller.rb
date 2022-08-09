class AuthenticationController < ApplicationController

	def ft_auth
    redirect_to "https://api.intra.42.fr/oauth/authorize?client_id=#{ENV['API_42_UID']}&redirect_uri=#{ENV['API_42_AFTER_AUTH_REDIRECT']}&response_type=code", allow_other_host: true
  end

	def authenticate
    return redirect_to action: "ft_auth" if params.key?(:error)

    redirect_to action: "ft_auth"
	end

	def authentication_callback
    notice = ""
    begin
      client = OAuth2::Client.new(ENV['API_42_UID'], ENV['API_42_SECRET'], site: "https://api.intra.42.fr")
      client.auth_code.authorize_url(:redirect_uri => ENV['API_42_REDIRECT'])
      token = client.auth_code.get_token(params[:code], :redirect_uri => ENV['API_42_REDIRECT'])
      response = token.get("/v2/me")
      puts "Response: (should be 200): #{response.status.to_s}"
      c = Campus.find_by_name(response.parsed["campus"].first["name"])
      @user = User.find_or_create_by(login: response.parsed["login"]) do |user|
        user.email = response.parsed["email"]
        user.campus = c
      end
      if !c.nil?
        @user.update(campus: c)
      end
      if @user.persisted?
        sign_in @user, event: :authentication
      else
        session["devise.access_code"] = params[:code]
        return redirect_to new_user_session_path
      end
    rescue
      notice = "something went wrong with API connection... :("
    end
		redirect_to root_path, notice: notice
	end
end

