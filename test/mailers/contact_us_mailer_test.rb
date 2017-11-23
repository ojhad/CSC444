require 'test_helper'

class ContactUsMailerTest < ActionMailer::TestCase
  test "contact_us_mail" do
    mail = ContactUsMailer.contact_us_mail
    assert_equal "Contact us mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
