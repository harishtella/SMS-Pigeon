require 'rubygems'
require 'active_support'
require 'ar-extensions'
require 'date'

class CallbacksController < ApplicationController
  def complete_all
    @callbacks = ApartmentCallback.find(:all, :conditions => 
    {:completed => false})
    @callbacks.each do |cb| 
      cb.completed = true
      cb.save
    end
    
    redirect_to(root_url) 
  end

  def callback_complete
    @callback = ApartmentCallback.find(params[:id])
    @callback.completed = true
    @callback.save
    respond_to do |format|
      #format.html { redirect_to(@callback.apartment) }
      format.js { 
        render :partial => "callbacks/callback", :locals => {:cb => @callback}
      }
    end
  end

  def callback_uncomplete
    @callback = ApartmentCallback.find(params[:id])
    @callback.completed = false
    @callback.save
    respond_to do |format|
      #format.html { redirect_to(@callback.apartment) }
      format.js { 
        render :partial => "callbacks/callback", :locals => {:cb => @callback}
      }
    end
  end

  def callbacks_outstanding
    @callbacks = ApartmentCallback.outstanding
  end

  def callbacks
 
    @time_string = '%b %e'

    @s_date = unless params[:s_date].nil? then params[:s_date]  
    else 2.days.ago.to_date.strftime(@time_string) end
   
    @e_date = unless params[:e_date].nil? then params[:e_date]  
    else Time.zone.now.to_date.strftime(@time_string) end 
  
    @s = DateTime.parse(@s_date.to_s + " 00:00:00 CDT")
    @e = DateTime.parse(@e_date.to_s + " 23:59:59 CDT")
    @callbacks = ApartmentCallback.find(:all,  
    :order => "created_at DESC", :conditions => 
    { :created_at_lte => @e.utc, 
    :created_at_gte => @s.utc } )
  end


end
