# request.rb
#
# Net::HTTP::Post wrapper
#
# All API calls for requesting user details and sending messages
# should be sent via HTTP POST to the following URL:
# https://www.imified.com/api/bot/.
#
# Authentication is managed using Basic HTTP authentication.
# Every request must include the Authorization HTTP header
# with your IMified username and password.
#
class Imified::Request < Net::HTTP::Post
  URL = URI.parse(Imified::URL)

  # Construct a Net::HTTP::Post object.
  # Prepare basic authentication using the username and
  # password specified in the configuration.
  #
  # == Usage
  #   Imified::Request.new
  #
  # @return[Net::HTTP::Post]
  def initialize
    super(URL.path)
    self.basic_auth Imified::USERNAME, Imified::PASSWORD
    self.set_form_data({
      'apimethod' => 'getallusers',
      'botkey'    => Imified::BOTKEY
    })
  end

  # Submit the request to Imified.
  def submit
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    http.start { |send| send.request(self) }
  end

end
