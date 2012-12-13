# Disables HTTP communications with the `URL`. If a service
# tries to contact that URL, it gets `body` as the response.
def fake_it(url, body)
  FakeWeb.register_uri(:post, url, body: body)
end

def deusto_server_url
 'weblab.deusto.example.com'
end

def login_url
  "#{deusto_server_url}/login/json/"
end

def core_services_url
  "#{deusto_server_url}/json/"
end