require "pry"

module CodeChamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(oauth)
      @headers = {
        "Authorization" => "token #{oauth_token}",
        "User-Agent"    => "HTTParty"
      }
      end
      @result = {}
    end

    def get_contributions(org, repo)
      response = Github.get("/repos/#{owner}/#{repo}/stats/contributors", headers: @headers)
        response.each do |user|
          user_name = user["author"]["login"]
          result = Hash.new(0)

        user["weeks"].each do |hash|
            hash.each do |key, value|
            result[key] += value.to_i
          end
        end
    end
  end
end