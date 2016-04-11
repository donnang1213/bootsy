module Bootsy
  module ApplicationHelper
    def refresh_btn
      link_to t('bootsy.action.refresh'),
              '#refresh-gallery',
              class: 'btn btn-default btn-sm refresh-btn'
    end

    def resource_or_nil(resource)
      resource if resource.present? && resource.persisted?
    end

  def is_mobile
    response = false
    case request.user_agent
      when /iPhone/i
        response = true
      when /Android/i && /mobile/i
        response = true
      when /Windows Phone/i
        response = true
      else
        response = false
    end
    response
  end
      
  end
end
