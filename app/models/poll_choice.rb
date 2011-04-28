class PollChoice < ActiveRecord::Base
  has_many :votes, :class_name => "PollVote"
  belongs_to :poll_question

  accepts_nested_attributes_for :votes, :allow_destroy => true

  before_save :set_keyword
  before_destroy :reset_other_choices_keywords

  private
    def set_keyword
      if self.keyword.nil?
        other_choices = PollChoice.find_all_by_poll_question_id(self.poll_question)
        used_keywords = other_choices.map {|x| x.keyword }
       
        #gotta convert things to lower case
        keyword_options = ('A'..'Z').to_a

        first_available_keyword = (keyword_options - used_keywords)[0]
        self.keyword = first_available_keyword
      end
    end


    def reset_other_choices_keywords
      other_choices = PollChoice.find_all_by_poll_question_id(self.poll_question)
      other_choices -= [self]
      #gotta convert things to lower case
      keyword_options = ('A'..'Z').to_a.reverse

      other_choices.each do |c| 
        c.keyword = keyword_options.pop
        c.save
      end
    end
end
