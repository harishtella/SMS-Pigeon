require 'net/http'

class Kannel 
  
  @domain = "localhost" 
  @port = "13013"
  @user = "foo"
  @pw = "bar"
  class << self; attr_accessor :domain end
  class << self; attr_accessor :port end
  class << self; attr_accessor :user end
  class << self; attr_accessor :pw end

  def self.send_sms(to_phone_num, msg)
    status = Net::HTTP.get(URI.parse(build_sms_push_url(to_phone_num, msg))) 

    # log for when rails calls kannel to send
    #f =File.open("kannel_class.log", "a")
    #f.puts(Time.now)
    #f.puts("to: " + to_phone_num) 
    #f.puts("msg: " + msg)
    #f.puts(status)
    #f.puts("\n\n")
    #f.close

  end

  def self.build_sms_push_url(to_phone_num, msg)
    "http://" + @domain + ":" + @port + 
    "/cgi-bin/sendsms?username=" + @user + "&password=" +
    @pw + "&to=" + URI.escape(to_phone_num) + "&text=" + CGI::escape(msg) 
  end
end
