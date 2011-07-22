require 'enumerator'

class ApartmentsController < ApplicationController
  def msg_recent_people
    @apartment = Apartment.find(params[:apt])
    @s = params[:s]
    @e = params[:e]
    @new_message = params[:message]

    @rp = @apartment.find_int_peeps(@s, @e)  

    numbers = Array.new 
    @rp.each do |p|
      numbers << p.number 
    end
    numbers_chunked = Array.new 
    numbers.each_slice(5) do |c|
      numbers_chunked << c
    end

    begin
      numbers_chunked.each do |nc|  
        numbers_string = nc.join(" ")
        Kannel.send_sms(numbers_string, @new_message)
        new_sms = SMS.new 
        new_sms.text = @new_message
        new_sms.users = @rp
        new_sms.incoming = false
        new_sms.save
      end
    rescue Exception => e
      puts "\n"
      puts e.inspect
      puts "ERROR: couldn't connect to kannel"
      flash[:error] = "Message could not be sent. " +
      "Could not connect to sms server."
    else 
      flash[:notice] = "Message was sent sucessfully."
    end

    redirect_to(@apartment)
  end


  def recent_people
    @apartment = Apartment.find(params[:id])
   
    @time_string = '%b %e'

    @s_date = unless params[:s_date].nil? then params[:s_date]  
    else 1.week.ago.to_date.strftime(@time_string) end
   
    @e_date = unless params[:e_date].nil? then params[:e_date]  
    else Time.zone.now.to_date.strftime(@time_string) end 
  
    @s = DateTime.parse(@s_date.to_s + " 00:00:00 CDT")
    @e = DateTime.parse(@e_date.to_s + " 23:59:59 CDT")
    #@msgs = SMS.find(:all,  
    #:order => "id DESC", :conditions => 
    #{ :created_at_lte => @e.utc, 
    #:created_at_gte => @s.utc } )

    @rp = @apartment.find_int_peeps(@s.utc, @e.utc)  

    respond_to do |format|
      format.html 
    end
  end


  def callback_complete
    @callback = ApartmentCallback.find(params[:id])
    @callback.completed = true
    @callback.save
    @cb = @callback 
    respond_to do |format|
      format.html { redirect_to(@callback.apartment) }
      format.js { 
        render :partial => "callback", :locals => {:cb => @callback}
      }
    end
  end

  def callback_uncomplete
    @callback = ApartmentCallback.find(params[:id])
    @callback.completed = false
    @callback.save
    respond_to do |format|
      format.html { redirect_to(@callback.apartment) }
      format.js { 
        render :partial => "callback", :locals => {:cb => @callback}
      }
    end
  end

  def new_status
    @apartment = Apartment.find(params[:id])
    @status = ApartmentStatus.new(params[:apartment_status])

    @apartment.statuses << @status
    @apartment.save

    redirect_to(@apartment)
  end

  def index
    @apartments = Apartment.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
    @new_status = ApartmentStatus.new

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def show_callbacks
    @apartment = Apartment.find(params[:id])
    
    respond_to do |format|
      format.html 
    end
  end

  def new
    @apartment = Apartment.new
    @apartment.statuses.build
    @apartment.build_keyword

    3.times do 
      @apartment.pics.build
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @apartment = Apartment.find(params[:id])
  end

  def create
    @apartment = Apartment.new(params[:apartment])
    @apartment.pics.each do |p|
      if p.url.empty? then p.destroy end
    end

    respond_to do |format|
      if @apartment.save
        flash[:notice] = 'Keyword was successfully created.'
        format.html { redirect_to(@apartment) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @apartment = Apartment.find(params[:id])

    respond_to do |format|
      if @apartment.update_attributes(params[:apartment])
        flash[:notice] = 'Keyword was successfully updated.'
        format.html { redirect_to(@apartment) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @apartment = Apartment.find(params[:id])
    @apartment.destroy

    respond_to do |format|
      format.html { redirect_to(apartments_url) }
    end
  end
end
