# frozen_string_literal: true

json.emails(@emails) do |email|
  json.extract! email, :id, :read
end

json.unread unread
