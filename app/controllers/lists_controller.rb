class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show 
    @list = List.find(params[:id])
    @new_message = ListMessage.new
  end

  def new_message 
    @list = List.find(params[:id])
    @new_message = ListMessage.new(params[:list_message])

    @list.messages << @new_message 
    @list.save

    numbers = Array.new 
    @list.subscribers.each do |s|
      numbers << s.number 
    end
    numbers_chunked = Array.new 
    numbers.each_slice(5) do |c|
      numbers_chunked << c
    end

    begin
      numbers_chunked.each do |nc|  
        numbers_string = nc.join(" ")
        Kannel.send_sms(numbers_string, @new_message.value)
        new_sms = SMS.new 
        new_sms.text = @new_message.value
        new_sms.users = @list.subscribers 
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

  
    redirect_to(@list)
  end
  

  def new 
    @list = List.new
    @list.build_keyword
  end

  def create 
    @list = List.new(params[:list])

    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.html { redirect_to(@list) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def user_listing
    @list = List.find(params[:id])

    @users = Array.new
    @name_selected = true

    if params[:search] 
      if params[:search_type].eql? "name"
        @users = User.find(:all, :conditions => ['name LIKE ?',
        "%#{params[:search]}%"])
      else
        @users = User.find(:all, :conditions => ['number LIKE ?', "%#{params[:search]}%"])
        @name_selected = false
      end
    else
      @users = User.all
    end

    @users.reject! {|u| @list.subscribers.member? u }
  end

  def user_new
    @user = User.new
    @list = List.find(params[:id])
  end

  def add_new_user
    @user = User.new(params[:user])
    @list = List.find(params[:list_id])

    phone_num = "+1" + params[:num1] + params[:num2] + params[:num3]
    @user.number = phone_num


    respond_to do |format|
      if @user.save
        @list.subscribers << @user
        @list.save
        flash[:notice] = @user.name_string + ' was successfully added to this list.'
        format.html { redirect_to(@list) }
      else
        flash[:error] = "Error with adding user to this list. " + 
        "Try adding user from the user management page." 
        format.html { redirect_to(@list) }
      end
    end
  end


  def add_user
    @list = List.find(params[:list_id])
    @user = User.find(params[:user_id])
    @list.subscribers << @user
    @list.save

    flash[:notice] = @user.name_string + " " + 
    @user.number_string + " was successfully added to this list."
    redirect_to(@list)
  end

  def remove_user
    @list = List.find(params[:list_id])
    @user = User.find(params[:user_id])
    @list.subscribers.delete(@user)
    @list.save

    flash[:notice] = @user.name_string + " " + 
    @user.number_string + " was successfully removed from this list."
    redirect_to(@list)
  end

  def edit 
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        flash[:notice] = 'List was successfully updated.'
        format.html { redirect_to(@list) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
    end
  end
  


end
