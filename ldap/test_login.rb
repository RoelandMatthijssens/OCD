#/usr/bin/ruby -w

require 'curl'
# use gem install 'net-ldap'
# and gem install 'curb' # Yes, with a B at the end

def login_curl uname, pw
	c	= Curl::Easy.new
	c.header_in_body = false
	c.ssl_verify_host = false
	c.follow_location = false
	c.url = "https://idsserve.vub.ac.be/cgi-bin/vrfy-pw"
	f = "username=" + c.escape(uname)
	f += "&password=" + c.escape(pw)
	f += "&failure=" + c.escape("http://igwe.vub.ac.be/failure")
	f += "&location=" + c.escape("http://igwe.vub.ac.be/success")
	f += "&fields=username&options=valid%20relation"
	c.http_post(f)
	c.body_str.index('success') ? true : false
#   c.body_str.index('success') && true
end

