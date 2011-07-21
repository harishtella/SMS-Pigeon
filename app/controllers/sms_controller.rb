require 'jcode'

class SMSController < ApplicationController

  def process_main
    @phone = params[:phone]
    @text = params[:text]

    begin  
      new_sms = SMS.new 
      new_sms.text = @text
      new_sms.users = [User.for(@phone)]
      new_sms.incoming = true
      new_sms.save

      keyword = @text.split(" ")[0].strip 
      keyword.downcase!

      result =  
      # this branch usually wont get called because the split above
      # will cause an exception
      if @text.empty?
        "Your text message did not go through, " + 
        "please try again or call us at (XXX) XXX-XXXX"
      elsif black_listed?(@phone, @text)
        ""
      elsif apt_avail_sms?(keyword)
        process_apt_avail(@phone, @text, keyword)
      elsif list_sms?(keyword)
        process_list(@phone, @text, keyword)
      else 
        "We do not recognize your keyword, please confirm and try again " + 
        "or call (XXX) XXX-XXXX"
      end
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts e.backtrace.to_a[0..20].join("\n")
      result = "Your text message did not go through, " + 
        "please try again or call us at (XXX) XXX-XXXX"
    end

    render :text => proc {|response, output|
      output.write("")
      #output.write(result)
    }
    unless result.empty?
      begin 
        Kannel.send_sms(@phone, result)    
        ret_sms = SMS.new 
        ret_sms.text = result
        ret_sms.users = [User.for(@phone)]
        ret_sms.incoming = false
        ret_sms.save
      rescue Exception => e
        puts "\n"
        puts e.inspect
        puts "ERROR: couldn't connect to kannel"
      end
    end
  end


  #blocks out all non standard U.S. phone numbers
  def black_listed?(phone, text)
    number_regex = /\+1(\d){10,10}$/
    if number_regex.match(phone).nil? 
      true 
    end
  end

  def apt_avail_sms?(keyword)
    special_keywords = ["c", "p"]

    keyword_is_special = special_keywords.map {
      |x| x.eql? keyword }.inject{ |x,y| x | y }

    if keyword_is_special then return true end 

    keyword_db_entry = Keyword.first(:conditions => {:value => keyword})
    if keyword_db_entry.nil? 
      return false
    elsif keyword_db_entry.owner_type.eql? "Apartment"
      return true
    else 
      return false
    end
  end

  def process_apt_avail(phone, text, keyword)

    special_keywords = ["c", "p"]
    keyword_is_special = special_keywords.map {
      |x| x.eql? keyword }.inject{ |x,y| x | y }
    if keyword_is_special
      process_apt_special(phone,text, keyword)
    else 
      process_apt_normal(phone,text, keyword)
    end
  end

  def process_apt_special(phone, text, keyword)
    current_user = User.for(phone) 
    apt = current_user.last_apt_queried

    if apt.nil? 
      return "Please text in a keyword before requesting pictures (p) " +
      "or a callback (c)."
    end

    if apt.pcb_disabled 
      return "Sorry pictures and call back requests are unavailable for this " + 
      "property."
    end

    if (keyword.eql? "p")
      if apt.pics.nil? 
        "Sorry, no pictures are available."
      else
        return apt.pics.map{|x| x.full_url}.inject{|x,y| x + "\n" + y}
      end
    end

    if (keyword.eql? "c")
      
      possible_pending_callback = ApartmentCallback.first(:conditions => 
      {:apartment_id => apt, :user_id => current_user, :completed => false})

      unless possible_pending_callback 
        message = text.split(" ",2)[1] #get everything after keyword
    
        ac = ApartmentCallback.new
        ac.apartment = apt
        ac.user = current_user
        if message.nil?
          ac.message = "--"
        else
          ac.message = message
          end
        ac.save
      end

      "Thanks for contacting us, we will call you back" +
      " from (XXX) XXX-XXXX as soon as possible."
    end
  end

  def process_apt_normal(phone, text, keyword)
    keyword_db_entry = Keyword.first(:conditions => {:value => keyword})
    apt = keyword_db_entry.owner

    current_user = User.for(phone) 
    current_user.last_apt_queried = apt
    current_user.save 
    
    apt_q = ApartmentQuery.new
    apt_q.apartment = apt
    apt_q.user = current_user
    apt_q.save

    apt_status = apt.current_status.to_s
    unless apt.pcb_disabled 
      apt_status += "\n" + "txt \"p\" for pics, " + "\"c\" for call back."
    end

    return apt_status
  end

  def list_sms?(keyword)
    keyword_db_entry = Keyword.first(:conditions => {:value => keyword})
    if keyword_db_entry.nil? 
      return false
    elsif keyword_db_entry.owner_type.eql? "List"
      return true
    else 
      return false
    end
  end

  def process_list(phone, text, keyword)
    keyword_db_entry = Keyword.first(:conditions => {:value => keyword})
    list = keyword_db_entry.owner

    current_user = User.for(phone) 
    list.subscribers << current_user 
    list.save
    return "You have been added to the subscription \"" +
    list.name + "\""
  end
end

