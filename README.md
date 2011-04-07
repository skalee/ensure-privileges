Not yet ready for production use. Sorry

### `login_as`

`login_as` must be defined somewhere in `spec/support`. It should take a string as the only obligatory parameter.
It should make user logged in for testing purposes. Typical implementation would be like this:

    def login_as(who)
      user_object = case who
      when 'admin', 'user'
        Factory who.to_sym
      when 'anonymous'
        nil
      when /\A@.+/
        instance_variable_get who
      else
        fail "Improper parameter '#{who}' for login_as."
      end

      user_id = user_object.kind_of?(User) ? user_object.id : user_object
      session[:user_id] = user_id
    end

License
-------

MIT license. Copyright (c) 2011 Sebastian Skałacki.
