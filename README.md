# OpenIDConnect Sample RP

A sample OpenID Connect Relying Party ("RP") using the `openid_connect` gem.


## Resources

For this sample:

* View source on GitHub: https://github.com/nov/openid_connect_sample_rp
* Report Issues on GitHub: https://github.com/nov/openid_connect_sample_rp/issues


For more information, see readme and wiki for `openid_connect` gem:

* https://github.com/nov/openid_connect


Also of interest, the corresponding sample OP:

* https://github.com/nov/openid_connect_sample


## Live Example

Nov has this sample running on Heroku: https://connect-rp.herokuapp.com

To see it in action right now:

* visit [Nov's Sample RP on Heroku](https://connect-rp.herokuapp.com)
* enter `connect-op.herokuapp.com` in the form
* press "Discover"
* the RP will use the OP to authenticate


## How to Run This Example on Your Machine

There are no configuration file changes needed to run the RP.

To run this in development mode:

* Download (or fork or clone) this repo
* `bundle install` (see "Note" section below if you get "pg"-gem-related problems)
* `bundle exec rake db:create db:migrate db:seed` (you have SQLite installed, right?)
* `bundle exec rails server -p 3001`

Point your browser at http://localhost:3001

If you download and run [the sample OP server](https://connect-rp.herokuapp.com)
you can have this RP use that OP for authentication
(use the OP's address in the "Discover" field, e.g. `localhost:3000`).
The two servers on localhost must run on different ports.

You can also use the address of
[Nov's Sample OP on Heroku](https://connect-op.herokuapp.com) in the
"Discover" field and your RP will use that to authenticate.


## Notes

* The Gemfile includes gem 'pg' (for PostgreSQL), but you can remove it.
  Nov uses PostgreSQL for his Heroku deployment, but the default DB configs are all SQLite.


## Centos OpenSSL Complications

Centos' default OpenSSL package does not include some Elliptic Curve algorithms for patent reasons.
Unfortunately, the gem dependency `json-jwt` calls on one of those excluded algorithms.

If you see `uninitialized constant OpenSSL::PKey::EC` when you try to run the server,
this is your problem. You need to rebuild OpenSSL to include those missing algorithms.

This problem is beyond the scope of this README, but
[this question on StackOverflow](http://stackoverflow.com/questions/32790297/uninitialized-constant-opensslpkeyec-from-ruby-on-centos/32790298#32790298)
may be of help.


## Copyright

Copyright (c) 2011 nov matake. See LICENSE for details.

