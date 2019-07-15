class Regex
  def valid_email? 
    str =  ARGV[0]
    if str.match(/^\D.*@(gmail|yahoo|rediff).(com|in|net)/)
      puts "Valid"
    else
      puts "Not valid"
    end
  end
end


r = Regex.new.valid_email?
