module CodeChamp
  class Github
    include HTTParty
    base_uri "https://api.github.com"
    @username = nil

    def initialize(oauth)
      @headers = {
        "Authorization" => "token #{oauth}",
        "User-Agent"    => "HTTParty"
      }
    end

    def get_contributions(org, repo)
      results = []
      Github.get("/repos/#{org}/#{repo}/stats/contributors", headers: @headers)
    end
      
    def get_data(weeks)
      contrib_type = "a"
      contrib_num = 1

      relevant = weeks.select {|h|h.key?(contrib_type) && h[contrib_type]==contrib_num}
      return nil if relevant.empty?  
      relevant.each_with_object({}) {|h,g| g.merge!(h) {|k,gv,hv| k == contrib_type ? gv : # is enumerator appropriate?
                      (gv.to_i + hv.to_i).to_s}}
    end
  end
end