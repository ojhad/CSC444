class ContactUsMailer < ApplicationMailer
	default to: 'shamitra.rohan@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_us_mailer.contact_us_mail.subject
  #

  def contact_us_mail (email, description)
  	@description = description
  	mail from: email, subject: "TeenServ Enquiry"
  end
end
