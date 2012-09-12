desc "This task is called by the Heroku scheduler add-on"

task :get_matchups, [:season] => :environment do |t, args|
  require 'nokogiri'
  require 'open-uri'

  args.with_defaults(season: Date.today.strftime("%Y"))

  i = 1
  while i < 18 do
    url = "http://www.nfl.com/schedules/2012/REG#{i}"
    doc = Nokogiri::HTML(open(url))
    doc.css(".schedules-list-matchup").each do |matchup|
      Matchup.create! do |m|
        m.season_id = args.season
        m.week_id = i
        nfl_game_id = matchup.at_css(".schedules-list-content")["data-gameid"]
        m.nfl_game_id = nfl_game_id
        time = matchup.at_css(".time").text
        m.game_time = "#{nfl_game_id[0..7]} #{time}"
        m.away_team_name = matchup.at_css(".team-name.away").text
        m.away_team_logo_url = matchup.at_css(".away img").first[1]
        m.team_score_away = matchup.at_css(".team-score.away").text if matchup.at_css(".team-score.away")
        m.home_team_name = matchup.at_css(".team-name.home").text
        m.home_team_logo_url = matchup.at_css(".home img").first[1]
        m.team_score_home = matchup.at_css(".team-score.home").text if matchup.at_css(".team-score.home")
      end
    end
    i += 1
  end
end