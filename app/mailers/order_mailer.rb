class OrderMailer < ApplicationMailer

	def send_to_vendor(order)
		@order = order
		mails = @order.vendor.vendor_emails.map { |e| e.email } rescue []
		if mails.present?
			puts "-> Sending emails to the following destinations: #{mails}"
			mail(to: mails, subject: 'New purchase order')
		else
			puts "-> Vendor had no emails"
		end
		
	end
end
