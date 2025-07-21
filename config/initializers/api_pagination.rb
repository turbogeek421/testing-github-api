# frozen_string_literal: true

ApiPagination.configure do |config|
  config.paginator = :kaminari
  config.page_param = :page
  config.per_page_param = :per_page

  config.total_header = "X-Issues-Total-Count"
  config.per_page_header = "X-Issues-Per-Page"
  config.page_header = "X-Issues-Page"
end
