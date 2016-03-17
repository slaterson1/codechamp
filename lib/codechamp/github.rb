module CodeChamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(oauth)
      @headers = {
        "Authorization" => "token #{oauth_token}",
        "User-Agent"    => "HTTParty"
      }
      @result = {}
    end

    def get_contributions(org, repo)
      contributions = Github.get("/repos/#{org}/#{repo}/stats/contributors", headers: @headers)
    
      contributions.each do |user|
        user_name = user['author']['login']
        totals = Hash.new(0)

        user['weeks'].each do |week|
          week.each do |key, value|
            totals[key] += value.to_i
        end
      end
      results = {user_name => totals}
    end
    @result
  end
end