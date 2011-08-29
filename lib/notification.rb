module Notification
  def self.included(klass)
    klass.send :after_filter, :flash_to_cookie
  end

  def flash_to_cookie
    [:notice, :warn, :error].each do |key|
      if (_flash_ = flash[key]).present?
        if _flash_.is_a?(String)
          _flash_ = {text: _flash_}
        end
        _flash_json_ = _flash_.to_json
        cookies["flash.#{key}"] = _flash_json_
        flash.discard(key)
      end
    end
  end
end
