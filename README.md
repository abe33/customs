
# Customs

**customs** uses the power of [cancan](http://github.com/ryanb/cancan/) to control the flow of your controllers.

It adds some magic in your rails controllers, through the cancan magic formula : ```load_and_authorize_resource```, and let you customize the flow.

**customs** provides you :

* default cruds methods
* full control on controllers methods, steps by steps
* methods for HTTP statuses
* common errors rescue

```
class DrogsController < ApplicationController
  control_and_rescue
  respond_to :html, :json

  load_and_authorize_resource :drog
end
```


## Requirements:

Tested under these conditions :

* Ruby >= 1.9.3
* Rails >= 3.2.0
* Cancan >= 1.6.9

I try to work with gems on the edge. Feel free to fork & test with other configuration.


## Installation

Add this line to your application's Gemfile:

    gem 'customs'

Or install it yourself as:

    $ gem install customs

Then, take a beer.

## Usage

Two methods available :

* ``control_traffic``
* ``rescue_traffic``

Or only one to bring them all and in the darkness bind them :

* ``control_and_rescue``


#### Example

```
class DrogsController < ApplicationController
  control_and_rescue
  respond_to :html, :json

  load_and_authorize_resource :drog
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

You can customize your flow by overwriting any step in your own controllers :

  * `resource_params` - parameters attributes, which will be used to create/update resources
  * `success_response` - what happened after successfull action
  * `resource_location` - where redirect on a success response (depending on the `action_name`)

 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
