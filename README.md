# cancan-traffic

**can-traffic** is an extension to [cancan](http://github.com/ryanb/cancan/) and is based on a principle similar to [inherited_resources](http://github.com/josevalim/inherited_resources).

It adds some magic in your rails controllers, when you're using the cancan methods ```load_and_authorize_resource``` & friends

## Basic Usage

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
