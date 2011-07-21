require 'net/http'

class AdminController < ApplicationController

  def index
  end

  def all_msg_log
    @time_string = '%b %e'

    @s_date = unless params[:s_date].nil? then params[:s_date]  
    else Time.zone.now.to_date.strftime(@time_string) end
   
    @e_date = unless params[:e_date].nil? then params[:e_date]  
    else Time.zone.now.to_date.strftime(@time_string) end 
  
    @s = DateTime.parse(@s_date.to_s + " 00:00:00 CDT")
    @e = DateTime.parse(@e_date.to_s + " 23:59:59 CDT")
    @msgs = SMS.find(:all,  
    :order => "id DESC", :conditions => 
    { :created_at_lte => @e.utc, 
    :created_at_gte => @s.utc } )

    @msgs_in_size = @msgs.find_all{|m| m.incoming}.size
    @msgs_out_size = @msgs.find_all{|m| not m.incoming}.size

  end

  def server_status
    flash.discard
    kannel_status_url = "http://localhost:13000/status.html?password=XXX"
    begin 
      status = Net::HTTP.get(URI.parse(kannel_status_url)) 
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts "ERROR: could not call status url"
      flash[:error] = "Could not fetch status."
      redirect_to(:action => 'index')
    else 
      render :inline => status, :cache => false
    end
  end

  def modem_log
    flash.discard
    begin
      render :inline =>  File.read('/var/log/kannel/smsc.log'),
      :content_type => "text/plain"
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts "ERROR: could not read modem log"
      flash[:error] = "Could not read modem log."
      redirect_to(:action => 'index')
    end 
  end

  def server_log
    flash.discard
    begin
      render :inline =>  File.read('/var/www/txtmsg/shared/log/production.log'),
      :content_type => "text/plain"
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts "ERROR: could not read server log"
      flash[:error] = "Could not read server log."
      redirect_to(:action => 'index')
    end 
  end



  def restart_server
    kannel_restart_url = "http://localhost:13000/restart?password=XXX"
    begin 
      status = Net::HTTP.get(URI.parse(kannel_restart_url)) 
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts "ERROR: could not call restart url"
      flash[:error] = "Could not send restart command."
      redirect_to(:action => 'index')
    else 
      flash[:notice] = status + " Check SMS server status to see " +
      "if server is back up."
      redirect_to(:action => 'index')
    end
  end

  def modem_number
      begin  
        @current_number = Modem.read_current_number
      rescue Exception => e
        @current_number = "???"
        flash.now[:error] = "Error retrieving current phone number. Trying to set new
        number will not work."
        puts "\n"
        puts e.inspect
        puts "ERROR: couldn't open kannel.conf"
      end

      @new_number = params["number"] 
  end

  def change_modem_number
    number = params["number"]  
    number_regex = /1(\d){10,10}$/
    if (number_regex.match(number)) 
      begin
        Modem.set_new_number(number) 
      rescue Exception => e
        flash[:error] = "Error setting new phone number."
        puts "\n"
        puts e.inspect
        puts "ERROR: couldn't write kannel.conf"
        redirect_to(:action => 'index')
      else
        flash[:notice] = "The new number has been set. " +
        "Please restart the SMS Server."
        redirect_to(:action => 'index')
      end
    else
      flash[:error] = "The new number is not in the correct format, please try
      again."
      redirect_to(:action => "modem_number", :number => number)
    end
    
  end

end
