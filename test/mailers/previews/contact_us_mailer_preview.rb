# Preview all emails at http://localhost:3000/rails/mailers/contact_us_mailer
class ContactUsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/contact_us_mailer/contact_us_mail
  def contact_us_mail
    ContactUsMailer.contact_us_mail
  end

end
