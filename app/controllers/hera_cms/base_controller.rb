module HeraCms
  class BaseController < ApplicationController
    filters = _process_action_callbacks.map(&:filter) - [:activate_authlogic]
    skip_before_action(*filters, raise: false)
    skip_after_action(*filters, raise: false)
    skip_around_action(*filters, raise: false)

  end
end
