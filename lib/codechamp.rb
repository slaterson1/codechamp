require "pry"
require "httparty"
require "codechamp/github"
# require "/codechamp/version"
module CodeChamp
    class App
        def initialize
        @response = []
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
            org_name = prompt("Enter username: ",
                            /^[a-z0-9\-]{4,30}$/i)
            repo_name = prompt("Enter repository: ",
                            /^[a-z0-9\-]{4,30}$/i)
            

            # @response = @github.get_contributions(org_name, repo_name)
        
        end

        def return_stats
            printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Changes"
            printf "%-20s %-20s %-20s %s\n", user_name,result["a"],result["d"],result["c"]
        end
    end
end
codechamp = CodeChamp::App.new
codechamp.authorize_github
codechamp.contributor_stats