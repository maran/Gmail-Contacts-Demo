class Google
	class Authorization
		def self.build_auth_url(return_url)
			# The URL of the page that Google should redirect the user to after authentication.
			return_url = return_url
			# Indicates that the application is requesting a token to access contacts feeds. 
			scope_param = "http://www.google.com/m8/feeds/"
			# Indicates whether the client is requesting a secure token.
			secure_param = 0
			# Indicates whether the token returned can be exchanged for a multi-use (session) token.
			session_param = 1
			# root url
			root_url = "https://www.google.com/accounts/AuthSubRequest"
	
			root_url + "?scope=#{scope_param}&session=#{session_param}&secure=#{secure_param}&next=#{return_url}"
		end

		def self.exchange_singular_use_for_session_token(token)
			require 'net/http'
			require 'net/https'

			http = Net::HTTP.new('www.google.com', 443)
			http.use_ssl = true
			path = '/accounts/AuthSubSessionToken'
			headers = {'Authorization' => "AuthSub token=#{token}"}
			resp, data = http.get(path, headers)

			if resp.code == "200" 
				token = ''
				data.split.each do |str|
					if not (str =~ /Token=/).nil?
						token = str.gsub(/Token=/, '')
					end
				end
				return token
			else
				return false
			end
		end
	end
	class Contact
		attr_accessor :name
		attr_accessor :email
		def initialize(name, email)
			@name = name
			@email = email
		end
		
		def self.all(token)
			# GET http://www.google.com/m8/feeds/contacts/default/base
			require 'net/http'
			require 'rexml/document'      

			http = Net::HTTP.new('www.google.com', 80)
			# by default Google returns 50? contacts at a time.  Set max-results to very high number
			# in order to retrieve more contacts
			path = "/m8/feeds/contacts/default/base?max-results=10000"
			headers = {'Authorization' => "AuthSub token=#{token}"}
			resp, data = http.get(path, headers)

			# extract the name and email address from the response data
			xml = REXML::Document.new(data)
			contacts = []
			xml.elements.each('//entry') do |entry|
			  name = entry.elements['title'].text

			  gd_email = entry.elements['gd:email']
			  email = gd_email.attributes['address'] if gd_email
				person = self.new(name, email)
			  contacts << person
			end
			return contacts
		end
	end
end