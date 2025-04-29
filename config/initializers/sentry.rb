# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://0839ac3bd7d9de5a808bcfb6cff9dfa0@o935588.ingest.us.sentry.io/4509192856862720'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
end
