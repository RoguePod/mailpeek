json.emails(@emails) do |file, email|
  json.file file
  json.extract!(email, :message_id, :date, :subject)
  json.created_at time_ago_in_words(email.date)
  json.to email[:to].decoded
  json.from email[:from].decoded

  parts = []
  if email.body.parts.empty?
    parts.push(
      type: email.content_type =~ /plain/ ? 'text' : 'html',
      content: email.body.decoded.force_encoding('utf-8'))
  else
    email.body.parts.each do |part|
      parts.push(
        type: part.content_type =~ /plain/ ? 'text' : 'html',
        content: part.body.decoded.force_encoding('utf-8'))
    end
  end

  json.body(parts.reverse) do |part|
    json.type part[:type]
    json.content part[:content]
  end
end
