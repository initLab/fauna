module LightsHelper
  def status_wrapper(status)
    {
     on: 'fa-sun-o',
     off: 'fa-circle'
    }[status]
  end

  def status_color(status)
    {
     on: '',
     off: 'fa-inverse'
    }[status]
  end

  def other_policy(policy)
    {always_on: :auto, auto: :always_on}[policy]
  end

  def policy_class(policy)
    {always_on: 'btn-success', auto: 'btn-info'}[policy]
  end

  def policy_icon(policy)
    policy_icons = {
                    always_on: 'hand-paper-o',
                    auto: 'clock-o'
                   }

    icon policy_icons[policy]
  end
end
