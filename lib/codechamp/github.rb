require "codechamp/version"

module Codechamp
	class Github
		include HTTParty
		base_uri "https://api.github.com"

		def initialize
      	@headers = {
        "Authorization" => "token #{ENV["OAUTH_TOKEN_GH"]}",
        "User-Agent"    => "HTTParty"
      	}
    end

    def list_contributions(username, repo)
      Github.get("repos/#{username}/#{repo}/stats/contributors", headers: @headers)
    end
  end
end