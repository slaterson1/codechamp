require "pry"

module CodeChamp
  class GitHub
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(oauth_token)
      @headers = {
        "Authorization" => "token #{oauth_token}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_contributions(org, repo)
      response = GitHub.get("/repos/#{org}/#{repo}/stats/contributors", headers: @headers)
      totals = []
      response.each do |user|
        result = Hash.new(0)
        user_name = user["author"]["login"]
      user["weeks"].each do |week|
          week.each do |type, contributions|
          result[type] += contributions.to_i
        end
    end
      user_info = [user_name, result]
      totals.push(user_info)
    end
      totals
    end
  end
end