module UsersHelper
    def gravatar_for(user)
        #Generate a hex token
        #ivan@gmail.com -> $a.b34.sgi
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"

        #<img src="gravatar_url" alt: user.name>
        image_tag(gravatar_url, alt: user.name)
    end
end
