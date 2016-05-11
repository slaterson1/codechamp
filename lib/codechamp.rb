require "pry"
require "httparty"
require "json"
require "codechamp/github"

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
            @github = GitHub.new(oauth_token)
        end
        
        def contributor_stats
            org_name = prompt("Enter username: ",
                            /^[a-z0-9\-]{4,30}$/i)
            repo_name = prompt("Enter repository: ",
                            /^[a-z0-9\-]{4,30}$/i)
            

            @response = @github.get_contributions(org_name, repo_name)
            printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Commits"
            
            @response.each do |response|
            printf "%-20s %-20s %-20s%s\n", response[0], response[1]["a"], response[1]["d"], response[1]["c"]
        end    
        
        def sort
            puts "By what data would you like to sort?"
            puts "1. By username, alphabetically"
            puts "2. By additions"
            puts "3. By deletions"
            puts "4. By commmits"
            puts "5. New search"
            puts "6. Exit"
            choice = gets.chomp

            case choice.to_i
                when 1
                 printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Commits"
                    @response.sort_by {|x| x[0]}.each do |response|
                        printf "%-20s %-20s %-20s %s\n", response[0], response[1]['a'], response[1]['d'], response[1]['c'] 
                    end
                sort
                when 2
                    printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Commits"
                    @response.reverse! {|x| x[1]['a']}.each do |response|
                        printf "%-20s %-20s %-20s %s\n", response[0], response[1]['a'], response[1]['d'], response[1]['c']
                    end
                sort
                when 3
                    printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Commits"
                    @response.reverse! {|x| x[1]['d']}.each do |response|
                        printf "%-20s %-20s %-20s %s\n", response[0], response[1]['a'], response[1]['d'], response[1]['c']
                    end
                sort
                when 4
                    printf "%-20s %-20s %-20s%s\n", "Username","Additions","Deletions","Commits"
                    @response.reverse! {|x| x[1]['c']}.each do |response|
                        printf "%-20s %-20s %-20s %s\n", response[0], response[1]['a'], response[1]['d'], response[1]['c']
                    end
                sort
                when 5
                another_repo
                when 6
                exit
                end
            end
        end    

        def another_repo
            puts "Would you like to search another repo? Y/N?"
            choice = gets.chomp.upcase
                if choice == "Y"
                    codechamp = CodeChamp::App.new
                    codechamp.authorize_github
                    codechamp.contributor_stats
                    codechamp.sort
                    codechamp.another_repo
                else
                    exit
                end
            choice
        end
    end
end
codechamp = CodeChamp::App.new
codechamp.authorize_github
codechamp.contributor_stats
codechamp.sort