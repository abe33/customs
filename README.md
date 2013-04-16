# CancanTraffic

**can-traffic** is an extension to [cancan](http://github.com/ryanb/cancan/) and is based on a principle similar to [inherited_resources](http://github.com/josevalim/inherited_resources).

It adds some magic in your rails controllers, when you're using the cancan methods ```load_and_authorize_resource``` & friends

CancanTraffic provides you :

* default cruds methods
* methods for HTTP statuses
* common errors rescue

```
class UfoController < ApplicationController
  control_and_rescue_traffic
  respond_to :html, :json

  load_and_authorize_resource :ufo
end
```

## Requirements:

* Ruby >= 1.9.2
* Rails >= 3.2.0
* Cancan >= 1.6.7

I always try to work on the edge, feel free to fork & test with other configuration.

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


#### Control traffic

`control_traffic` provides you default methods to list, create, update & delete resources, depending on the cancan `load_resource` arguments.

It uses exception to control the flow of data, such as:

  * ActiveRecord::RecordNotFound or Mongoid::Errors::DocumentNotFound
  * ActiveRecord::RecordInvalid or Mongoid::Errors::Validations
  * CanCan::AccessDenied


#### Rescue traffic

`rescue_traffic` provides methods for specific HTTP statuses & routes the flow exceptions to the most appropriate one.

  * 401 - `unauthorized`
  * 403 - `forbidden`
  * 404 - `not_found`
  * 422 - `unprocessable`


#### Callbacks

Callbacks are working like rails filters :

  * `before_save    :make_something`
  * `before_save    :make_something_else, only: :create`
  * `before_destroy :make_nothing`

#### Flow customization

You can customize your flow by overwriting few methods in your controller :

  * `resource_params` - that's parameters attributes, using to create/update
  * `success_response` - what happened after successfull action
  * `resource_location` - where redirect on a success response (depending on the `action_name`)
  
 


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
