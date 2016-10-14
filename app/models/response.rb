class Response < ActiveRecord::Base
  belongs_to :user
  validates :response, presence: true
  validate :required_questions_must_be_answered

  def required_questions_must_be_answered
    Question.all.each do |q|
      if q.required && question_empty(q)
        errors.add(:response, q.question)
      end
    end
  end

  def question_empty(q)
    response[q.question].empty? || response[q.question] == [""]
  end
end
