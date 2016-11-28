class Response < ActiveRecord::Base
  belongs_to :user
  validates :response, presence: true
  validate :required_questions_must_be_answered

  private

  def required_questions_must_be_answered
    Question.all.each do |q|
      if q.required && question_empty(q)
        errors.add(q.question, "You must answer this question.")
      end
    end
  end

  def question_empty(q)
    response[q.question].blank? || response[q.question] == [""]
  end
end
