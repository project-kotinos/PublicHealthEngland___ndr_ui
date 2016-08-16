require 'test_helper'

module NdrUi
  # Test timeago helper
  class TimeagoHelperTest < ActionView::TestCase
    test 'timeago_tag with time in html5 mode' do
      object    = Time.zone.now
      timestamp = object.iso8601
      content   = I18n.l(object, format: :long)

      assert_dom_equal content_tag(:time, content,
                                   class: 'timeago', datetime: timestamp),
                       timeago_tag(object)
      assert_dom_equal content_tag(:time, content,
                                   class: 'timeago', datetime: timestamp, pubdate: true),
                       timeago_tag(object, pubdate: true)
    end

    test 'legacy timeago_tag with time in legacy mode' do
      object    = Time.zone.now
      timestamp = object.iso8601
      content   = I18n.l(object, format: :long)

      with_options html5: false do |legacy|
        assert_dom_equal content_tag(:abbr, content,
                                     class: 'timeago', title: timestamp),
                         legacy.timeago_tag(object)
        assert_dom_equal content_tag(:abbr, content,
                                     class: 'timeago', title: timestamp, pubdate: true),
                         legacy.timeago_tag(object, pubdate: true)
      end
    end

    test 'timeago_tag with date in html5 mode' do
      object    = Time.zone.today
      timestamp = object.iso8601
      content   = I18n.l(object, format: :long)

      assert_dom_equal content_tag(:time, content,
                                   class: 'timeago', datetime: timestamp),
                       timeago_tag(object)
      assert_dom_equal content_tag(:time, content,
                                   class: 'timeago', datetime: timestamp, pubdate: true),
                       timeago_tag(object, pubdate: true)
    end

    test 'legacy timeago_tag with date in legacy mode' do
      object    = Time.zone.today
      timestamp = object.iso8601
      content   = I18n.l(object, format: :long)

      with_options html5: false do |legacy|
        assert_dom_equal content_tag(:abbr, content,
                                     class: 'timeago', title: timestamp),
                         legacy.timeago_tag(object)
        assert_dom_equal content_tag(:abbr, content,
                                     class: 'timeago', title: timestamp, pubdate: true),
                         legacy.timeago_tag(object, pubdate: true)
      end
    end
  end
end
