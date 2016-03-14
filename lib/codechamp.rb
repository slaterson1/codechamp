require "pry"
require "httparty"
require "./github"
# require "/codechamp/version"
module CodeChamp
    class App
        def initialize
      @results = []
        end
        def prompt(message, regex)
            puts message
            choice = gets.chomp
        until choice =~ regex
            puts "Incorrect input. Try again."
            puts message
            choice = gets.chomp
        end
        choice
        end
        def authorize_github
            oauth_token = prompt("Enter your OAuth Token: ", 
                            /[a-z0-9]{4,50}/)
            # token = oauth_token
            @github = Github.new(oauth_token)
            # binding.pry
        end
        def contributor_stats
        result = []
            org_name = prompt("Enter username: ",
                            /^[a-z0-9\-]{4,30}$/i)
            repo_name = prompt("Enter repository: ",
                            /^[a-z0-9\-]{4,30}$/i)
            all_contributions = @github.get_contributions(org_name, repo_name)
        user_name = all_contributions["author"]["login"]
        puts "#{user_name}" #testing to see if im on the right track

        # user1 = all_contributions.first
        # user1_name = user1["author"]["login"]
        # @results.push(user1_name)
        # weeks = user1["weeks"]
        # stats = @github.get_data(weeks)
        # stats.delete("w")
        # @results.push(stats)
        # puts = "#{@results}"
        end
    end
end
codechamp = CodeChamp::App.new
codechamp.authorize_github
codechamp.contributor_stats