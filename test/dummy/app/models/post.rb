class Post < ActiveRecord::Base
  def warnings
    @warnings ||= Hash.new { |messages, attr| messages[attr] = [] }
  end
end
