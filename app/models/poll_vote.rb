class PollVote < ActiveRecord::Base
  belongs_to :poll_choice
  belongs_to :user

  def title
    "#{self.poll_choice.poll_question.poll.title}"
  end

  def poll
    self.poll_choice.poll_question.poll
  end

  def datetime_string 
    "#{self.created_at.strftime('%b %e @ %l:%M %p')}"
  end
end
