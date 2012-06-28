# CancanTraffic

**can-traffic** is an extension to [cancan](http://github.com/ryanb/cancan/) and is based on a principle similar to [inherited_resources](http://github.com/josevalim/inherited_resources).

It adds some magic in your rails controllers, when you're using the cancan methods ```load_and_authorize_resource``` & friends


## Requirements:

* Ruby >= 1.9.2
* Rails >= 3.2.0
* Cancan >= 1.6.7

Feel free to fork & test with other configuration.

## Installation


Add this line to your application's Gemfile:

    gem 'cancan-traffic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cancan-traffic

## Usage

Three methods available :

* ``control_traffic``
* ``rescue_traffic``
* ``control_and_rescue_traffic``


#### Example

```
class UfoController < ApplicationController
  control_and_rescue_traffic
  respond_to :html, :json

  load_and_authorize_resource :ufo
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
