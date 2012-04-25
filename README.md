# Traffic

```
class ApplicationController < ActionController::Base
  protect_from_forgery
  control_and_rescue_traffic
end

class ProjectsController < ActionController::Base
  # Use your favorite cancan methods :
  load_and_authorize_resource :project
end
```