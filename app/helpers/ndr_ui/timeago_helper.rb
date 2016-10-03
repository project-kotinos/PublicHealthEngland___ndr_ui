# frozen_string_literal: true

module NdrUi
  # Provides helper methods for the jQuery Timeago plugin
  module TimeagoHelper
    include CssHelper

    # Returns an timeago tag for the given date or time. By default it returns an HTML 5 time
    # element, but to return a legacy microformat abbr element set the <tt>:html5</tt> key to false
    # in the +options+.
    #
    #   timeago_tag Date.today  # =>
    #     <time datetime="2016-08-16" class="timeago">August 16, 2016</time>
    #   timeago_tag Time.now  # =>
    #     <time datetime="2016-08-16T15:21:16+01:00" class="timeago">August 16, 2016 15:21</time>
    #   timeago_tag Date.today, pubdate: true  # =>
    #     <time datetime="2016-08-16" pubdate="pubdate" class="timeago">August 16, 2016</time>
    #   timeago_tag Date.today, class: 'apples' # =>
    #     <time datetime="2016-08-16" class="timeago apples">August 16, 2016</time>
    def timeago_tag(date_or_time, options = {})
      return if date_or_time.nil?
      options   = css_class_options_merge(options, %w(timeago))
      html5     = true unless options.delete(:html5) == false
      content   = I18n.l(date_or_time, format: :long)
      timestamp = date_or_time.iso8601

      if html5
        content_tag('time', content, options.reverse_merge(datetime: timestamp))
      else
        content_tag('abbr', content, options.reverse_merge(title: timestamp))
      end
    end
  end
end
