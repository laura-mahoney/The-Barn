





facebook = OAuth2Session(app_id, redirect_uri=redirect_uri)
facebook = facebook_compliance_fix(facebook)

authorization_url, state = facebook.authorization_url(authorization_base_url)
print 'Please authorize.', authorization_url

redirect_response = raw_input("https://localhost:5000")

facebook.fetch_token(token_url, app_secret=app_secret, authorization_response=redirect_response)

r = facebook.get('https://graph.facebook.com/me?')
print r.content
