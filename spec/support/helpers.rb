# Disables HTTP communications with the `URL`. If a service
# tries to contact that URL, it gets `body` as the response.
def fake_it(url, body)
  FakeWeb.register_uri(:post, url, body: body)
end