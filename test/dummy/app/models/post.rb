class Post < ActiveRecord::Base
  def warnings
    @warnings ||= ActiveModel::Errors.new(self)
  end

  def safe?
    @warnings.empty?
  end
end
