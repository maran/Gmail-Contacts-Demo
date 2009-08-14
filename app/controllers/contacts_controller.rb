class ContactsController < ApplicationController
	def new
		redirect_to Google::Authorization.build_auth_url("http://localhost:3000/contacts/authorize")
	end
	
	def authorize
		token =  Google::Authorization.exchange_singular_use_for_session_token(params[:token]) 
		unless token == false
			redirect_to "http://localhost:3000/contacts?token=#{token}"
		else
			flash[:error] = "Something went wrong while authorizing with google."
		end
	end
	
	def index
		@contacts = Google::Contact.all(params[:token])
	end
end