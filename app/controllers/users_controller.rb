class UsersController < ApplicationController

  def index
    @users = Array.new
    @name_selected = true

    if params[:search] 
      if params[:search_type].eql? "name"
        @users = User.find(:all, :conditions => ['name LIKE ?',
        "%#{params[:search]}%"],
        :order => :name)
      else
        number_search = params[:search] 
        number_search.delete! "()-"
        @users = User.find(:all, 
        :conditions => ['number LIKE ?', "%#{number_search}%"],
        :order => :name)
        @name_selected = false
      end
      @searching = true
    else
      @users = User.all(:order => 'name')
    end
  end

  def show 
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.new(params[:user])
    phone_num = "+1" + params[:num1] + params[:num2] + params[:num3]
    @user.number = phone_num

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def edit 
    @user = User.find(params[:id])

    @num1 = @user.num1 
    @num2 = @user.num2 
    @num3 = @user.num3 
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end
  
end
