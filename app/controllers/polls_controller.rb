class PollsController < ApplicationController
  def index
    @polls = Poll.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @poll = Poll.find(params[:id])
    @poll.questions.each do |q|
      gen_poll_question_graph(q)
    end
  end

  def gen_poll_question_graph(question)
    g = Gruff::Bar.new(400)
    g.sort = false
    g.title = question.value

    question.choices.each do |c|
      g.data(c.value, [c.votes.count])
    end

    #g.data("champaign off-campus", [20])
    #g.data("champaign on-campus", [46])
    #g.data("urbana off-campus", [8])
    #g.data("urbana on-campus", [18])
    #g.labels = {0 => 'foo'}
    g.minimum_value = 0

    #send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => "arbitaryfilename.png")
    picname = question.id.to_s + '.png'
    g.write('public/images/graphs/' + picname )
  end


  def new
    @poll = Poll.new
    @poll.build_keyword

    2.times do 
      questions = @poll.questions.build
      2.times { questions.choices.build }
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def create
    @poll = Poll.new(params[:poll])

    respond_to do |format|
      if @poll.save
        flash[:notice] = 'Poll was successfully created.'
        format.html { redirect_to(@poll) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @poll = Poll.find(params[:id])

    respond_to do |format|
      if @poll.update_attributes(params[:poll])
        flash[:notice] = 'Poll was successfully updated.'
        format.html { redirect_to(@poll) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to(polls_url) }
    end
  end
end
