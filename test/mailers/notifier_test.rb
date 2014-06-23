require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "article" do
    mail = Notifier.article
    assert_equal "Article", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
