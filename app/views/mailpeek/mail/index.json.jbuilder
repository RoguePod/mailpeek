json.emails(@emails) do |email|
  json.extract!(email, :message_id, :date, :subject)
  json.created_at time_ago_in_words(email.date)
  json.to email[:to].decoded
  json.from email[:from].decoded

  parts = []
  if email.body.parts.empty?
    parts.push(
      type: email.content_type =~ /plain/ ? 'text' : 'html',
      content: email.body.decoded)
  else
    email.body.parts.each do |part|
      parts.push(
        type: part.content_type =~ /plain/ ? 'text' : 'html',
        content: part.body.decoded)
    end
  end

  json.body(parts) do |part|
    json.type part[:type]
    json.content part[:content]
  end
end
